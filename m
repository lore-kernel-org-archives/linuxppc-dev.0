Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70E062C010D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:05:36 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so1598396pbb.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 22:05:34 -0700 (PDT)
Date: Fri, 26 Jul 2013 14:35:28 +0930
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: SIGSTKSZ/MINSIGSTKSZ too small on 64bit
Message-ID: <20130726050528.GF3294@bubble.grove.modra.org>
References: <20130726122325.10b900e4@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130726122325.10b900e4@kryten>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ryan Arnold <ryanarn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 12:23:25PM +1000, Anton Blanchard wrote:
> 
> Hi,
> 
> Alan has been looking at a glibc test fail. His analysis shows SEGVs
> in signal handlers using sigaltstack, and that MINSIGSTKSZ and SIGSTKSZ
> are too small.
> 
> We increased the size of rt_sigframe in commit 2b0a576d15e0
> (powerpc: Add new transactional memory state to the signal context) but
> didn't bump either SIGSTKSZ and MINSIGSTKSZ. We need to do that in both
> the kernel and glibc, but I'm a bit worried we could have broken
> existing applications that use sigaltstack.

Before VSX changes, struct rt_sigframe size was 1920 plus 128 for
__SIGNAL_FRAMESIZE giving ppc64 exactly the default MINSIGSTKSZ of
2048.

After VSX, ucontext increased by 256 bytes.  Oops, we're over
MINSIGSTKSZ.  Add another ucontext for TM and rt_sigframe is now at
3872, giving actual MINSIGSTKSZ of 4000.

The glibc testcase that I was looking at was tst-cancel21, which
allocates 2*SIGSTKSZ (not because the test is trying to be
conservative, but because the test actually has nested signal stack
frames).  We blew the allocation by 48 bytes when using current
mainline gcc to compile glibc (le ppc64).

The required stack depth in _dl_lookup_symbol_x from the top of the
next signal frame was 10944 bytes.  I guess you'd want to add 288 to
that, implying an actual SIGSTKSZ of 11232.

I think we want
#define MINSIGSTKSZ	4096
#define SIGSTKSZ	16384

							frame size	r1
#0  0x00000000295cdaec in _dl_lookup_symbol_x(memset)	190
#1  0x00000000295d3c4c in _dl_fixup()			 b0	10003310160
#2  0x00000000295dc818 in _dl_runtime_resolve()		 b0	10003310210
#3  0x00001fffff59ea8c in uw_init_context_1()		a30	100033102c0
#4  0x00001fffff59f560 in libc:_Unwind_ForcedUnwind()	c90	10003310cf0
#5  0x00001ffffffb9538 in pt:_Unwind_ForcedUnwind()	 90	10003311980
#6  0x00001ffffffb6418 in __pthread_unwind()		 70	10003311a10
#7  0x00001ffffffaaeb0 in sigcancel_handler()		 70	10003311a80
#8  <signal handler called> 1ffffffe0448 tramp		fa0	10003311af0
			10003311b70 rt_sigframe
			  10003311c58 sigcontext.gp_regs
			  10003311dd8 sigcontext.fp_regs
			  10003311ee0 sigcontext.v_regs
			  10003311ef0 sigcontext.vmx
			100033128d8 rt_sigframe.pinfo  offset d68
			10003312968 rt_sigframe.abigap
			10003312a88 end + 8 alignment
#9  0x00001ffffffb6f9c in 				 80	10003312a90
#10 0x00001ffffffb6f84 in 					10003312b10
#11 0x00000000100020f4 in delete_temp_files()		 80	10003312dc0
#12 0x0000000010002198 in 				 	10003313070
#13 <signal handler called>
#14 0x00001ffffffb6f9c in ?? ()
#15 0x00001ffffffb6f84 in ?? ()
#16 0x0000000010002274 in ?? ()
#17 0x0000000010002430 in ?? ()
#18 0x0000000010002644 in ?? ()
#19 0x0000000010001a1c in ?? ()
#20 0x00001fffffe17f0c in ?? ()
#21 0x00001fffffe18134 in ?? ()
#22 0x0000000000000000 in ?? ()


-- 
Alan Modra
Australia Development Lab, IBM
