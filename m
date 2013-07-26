Return-Path: <ryanarn@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D59392C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 07:32:08 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ryanarn@us.ibm.com>;
 Fri, 26 Jul 2013 15:32:03 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E64D23E40042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:31:12 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6QLVZOS336950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:31:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6QLVYps011840
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 15:31:34 -0600
In-Reply-To: <20130726050528.GF3294@bubble.grove.modra.org>
References: <20130726122325.10b900e4@kryten>
 <20130726050528.GF3294@bubble.grove.modra.org>
Subject: Re: SIGSTKSZ/MINSIGSTKSZ too small on 64bit
To: Alan Modra <amodra@gmail.com>
Message-ID: <OFE7C3B8EC.F822633B-ON86257BB4.00708A32-86257BB4.00763ECE@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Fri, 26 Jul 2013 16:31:34 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF127DFE30CA28f9e8a93df938690918c09BBF127DFE30CA2"
Cc: Michael Neuling <mikey@neuling.org>, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 rsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF127DFE30CA28f9e8a93df938690918c09BBF127DFE30CA2
Content-type: text/plain; charset=US-ASCII

Alan Modra <amodra@gmail.com> wrote on 07/26/2013 12:05:28 AM:

> Alan Modra <amodra@gmail.com>
> 07/26/2013 12:05 AM
>
> To
>
> Anton Blanchard <anton@samba.org>,
>
> cc
>
> Michael Neuling <mikey@neuling.org>, Ryan Arnold/Rochester/
> IBM@IBMUS, linuxppc-dev@lists.ozlabs.org
>
> Subject
>
> Re: SIGSTKSZ/MINSIGSTKSZ too small on 64bit
>
> On Fri, Jul 26, 2013 at 12:23:25PM +1000, Anton Blanchard wrote:
> >
> > Hi,
> >
> > Alan has been looking at a glibc test fail. His analysis shows SEGVs
> > in signal handlers using sigaltstack, and that MINSIGSTKSZ and SIGSTKSZ
> > are too small.
> >
> > We increased the size of rt_sigframe in commit 2b0a576d15e0
> > (powerpc: Add new transactional memory state to the signal context) but
> > didn't bump either SIGSTKSZ and MINSIGSTKSZ. We need to do that in both
> > the kernel and glibc, but I'm a bit worried we could have broken
> > existing applications that use sigaltstack.
>
> Before VSX changes, struct rt_sigframe size was 1920 plus 128 for
> __SIGNAL_FRAMESIZE giving ppc64 exactly the default MINSIGSTKSZ of
> 2048.
>
> After VSX, ucontext increased by 256 bytes.  Oops, we're over
> MINSIGSTKSZ.  Add another ucontext for TM and rt_sigframe is now at
> 3872, giving actual MINSIGSTKSZ of 4000.
>
> The glibc testcase that I was looking at was tst-cancel21, which
> allocates 2*SIGSTKSZ (not because the test is trying to be
> conservative, but because the test actually has nested signal stack
> frames).  We blew the allocation by 48 bytes when using current
> mainline gcc to compile glibc (le ppc64).
>
> The required stack depth in _dl_lookup_symbol_x from the top of the
> next signal frame was 10944 bytes.  I guess you'd want to add 288 to
> that, implying an actual SIGSTKSZ of 11232.
>
> I think we want
> #define MINSIGSTKSZ   4096
> #define SIGSTKSZ   16384
>
>                      frame size   r1
> #0  0x00000000295cdaec in _dl_lookup_symbol_x(memset)   190
> #1  0x00000000295d3c4c in _dl_fixup()          b0   10003310160
> #2  0x00000000295dc818 in _dl_runtime_resolve()       b0   10003310210
> #3  0x00001fffff59ea8c in uw_init_context_1()      a30   100033102c0
> #4  0x00001fffff59f560 in libc:_Unwind_ForcedUnwind()   c90   10003310cf0
> #5  0x00001ffffffb9538 in pt:_Unwind_ForcedUnwind()    90   10003311980
> #6  0x00001ffffffb6418 in __pthread_unwind()       70   10003311a10
> #7  0x00001ffffffaaeb0 in sigcancel_handler()       70   10003311a80
> #8  <signal handler called> 1ffffffe0448 tramp      fa0   10003311af0
>          10003311b70 rt_sigframe
>            10003311c58 sigcontext.gp_regs
>            10003311dd8 sigcontext.fp_regs
>            10003311ee0 sigcontext.v_regs
>            10003311ef0 sigcontext.vmx
>          100033128d8 rt_sigframe.pinfo  offset d68
>          10003312968 rt_sigframe.abigap
>          10003312a88 end + 8 alignment
> #9  0x00001ffffffb6f9c in              80   10003312a90
> #10 0x00001ffffffb6f84 in                10003312b10
> #11 0x00000000100020f4 in delete_temp_files()       80   10003312dc0
> #12 0x0000000010002198 in                 10003313070
> #13 <signal handler called>
> #14 0x00001ffffffb6f9c in ?? ()
> #15 0x00001ffffffb6f84 in ?? ()
> #16 0x0000000010002274 in ?? ()
> #17 0x0000000010002430 in ?? ()
> #18 0x0000000010002644 in ?? ()
> #19 0x0000000010001a1c in ?? ()
> #20 0x00001fffffe17f0c in ?? ()
> #21 0x00001fffffe18134 in ?? ()
> #22 0x0000000000000000 in ?? ()

Adhemerval and I were just looking at the signal stack frames and I'd
noticed the increase in size due to the addition of the HTM bits so this is
great timing.

I tried a sigstack.h patch that increased the values as you indicated and
it cleaned up the failing tst-cancel21* testcases on POWER8.  I didn't try
it on POWER7 yet.

Ryan S. Arnold
--0__=09BBF127DFE30CA28f9e8a93df938690918c09BBF127DFE30CA2
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Alan Modra &lt;amodra@gmail.com&gt; wrote on 07/26/2013 12:05:28 AM:<br>
<br>
&gt; Alan Modra &lt;amodra@gmail.com&gt; </font></tt><br>
<tt><font size="2">&gt; 07/26/2013 12:05 AM</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; To</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Anton Blanchard &lt;anton@samba.org&gt;, </font></tt><br>
<tt><font size="2">&gt; <br>
&gt; cc</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Michael Neuling &lt;mikey@neuling.org&gt;, Ryan Arnold/Rochester/<br>
&gt; IBM@IBMUS, linuxppc-dev@lists.ozlabs.org</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Subject</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; Re: SIGSTKSZ/MINSIGSTKSZ too small on 64bit</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; On Fri, Jul 26, 2013 at 12:23:25PM +1000, Anton Blanchard wrote:<br>
&gt; &gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; Alan has been looking at a glibc test fail. His analysis shows SEGVs<br>
&gt; &gt; in signal handlers using sigaltstack, and that MINSIGSTKSZ and SIGSTKSZ<br>
&gt; &gt; are too small.<br>
&gt; &gt; <br>
&gt; &gt; We increased the size of rt_sigframe in commit 2b0a576d15e0<br>
&gt; &gt; (powerpc: Add new transactional memory state to the signal context) but<br>
&gt; &gt; didn't bump either SIGSTKSZ and MINSIGSTKSZ. We need to do that in both<br>
&gt; &gt; the kernel and glibc, but I'm a bit worried we could have broken<br>
&gt; &gt; existing applications that use sigaltstack.<br>
&gt; <br>
&gt; Before VSX changes, struct rt_sigframe size was 1920 plus 128 for<br>
&gt; __SIGNAL_FRAMESIZE giving ppc64 exactly the default MINSIGSTKSZ of<br>
&gt; 2048.<br>
&gt; <br>
&gt; After VSX, ucontext increased by 256 bytes. &nbsp;Oops, we're over<br>
&gt; MINSIGSTKSZ. &nbsp;Add another ucontext for TM and rt_sigframe is now at<br>
&gt; 3872, giving actual MINSIGSTKSZ of 4000.<br>
&gt; <br>
&gt; The glibc testcase that I was looking at was tst-cancel21, which<br>
&gt; allocates 2*SIGSTKSZ (not because the test is trying to be<br>
&gt; conservative, but because the test actually has nested signal stack<br>
&gt; frames). &nbsp;We blew the allocation by 48 bytes when using current<br>
&gt; mainline gcc to compile glibc (le ppc64).<br>
&gt; <br>
&gt; The required stack depth in _dl_lookup_symbol_x from the top of the<br>
&gt; next signal frame was 10944 bytes. &nbsp;I guess you'd want to add 288 to<br>
&gt; that, implying an actual SIGSTKSZ of 11232.<br>
&gt; <br>
&gt; I think we want<br>
&gt; #define MINSIGSTKSZ &nbsp; 4096<br>
&gt; #define SIGSTKSZ &nbsp; 16384<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;frame size &nbsp; r1<br>
&gt; #0 &nbsp;0x00000000295cdaec in _dl_lookup_symbol_x(memset) &nbsp; 190<br>
&gt; #1 &nbsp;0x00000000295d3c4c in _dl_fixup() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;b0 &nbsp; 10003310160<br>
&gt; #2 &nbsp;0x00000000295dc818 in _dl_runtime_resolve() &nbsp; &nbsp; &nbsp; b0 &nbsp; 10003310210<br>
&gt; #3 &nbsp;0x00001fffff59ea8c in uw_init_context_1() &nbsp; &nbsp; &nbsp;a30 &nbsp; 100033102c0<br>
&gt; #4 &nbsp;0x00001fffff59f560 in libc:_Unwind_ForcedUnwind() &nbsp; c90 &nbsp; 10003310cf0<br>
&gt; #5 &nbsp;0x00001ffffffb9538 in pt:_Unwind_ForcedUnwind() &nbsp; &nbsp;90 &nbsp; 10003311980<br>
&gt; #6 &nbsp;0x00001ffffffb6418 in __pthread_unwind() &nbsp; &nbsp; &nbsp; 70 &nbsp; 10003311a10<br>
&gt; #7 &nbsp;0x00001ffffffaaeb0 in sigcancel_handler() &nbsp; &nbsp; &nbsp; 70 &nbsp; 10003311a80<br>
&gt; #8 &nbsp;&lt;signal handler called&gt; 1ffffffe0448 tramp &nbsp; &nbsp; &nbsp;fa0 &nbsp; 10003311af0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003311b70 rt_sigframe<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003311c58 sigcontext.gp_regs<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003311dd8 sigcontext.fp_regs<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003311ee0 sigcontext.v_regs<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003311ef0 sigcontext.vmx<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;100033128d8 rt_sigframe.pinfo &nbsp;offset d68<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003312968 rt_sigframe.abigap<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003312a88 end + 8 alignment<br>
&gt; #9 &nbsp;0x00001ffffffb6f9c in &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;80 &nbsp; 10003312a90<br>
&gt; #10 0x00001ffffffb6f84 in &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10003312b10<br>
&gt; #11 0x00000000100020f4 in delete_temp_files() &nbsp; &nbsp; &nbsp; 80 &nbsp; 10003312dc0<br>
&gt; #12 0x0000000010002198 in &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 10003313070<br>
&gt; #13 &lt;signal handler called&gt;<br>
&gt; #14 0x00001ffffffb6f9c in ?? ()<br>
&gt; #15 0x00001ffffffb6f84 in ?? ()<br>
&gt; #16 0x0000000010002274 in ?? ()<br>
&gt; #17 0x0000000010002430 in ?? ()<br>
&gt; #18 0x0000000010002644 in ?? ()<br>
&gt; #19 0x0000000010001a1c in ?? ()<br>
&gt; #20 0x00001fffffe17f0c in ?? ()<br>
&gt; #21 0x00001fffffe18134 in ?? ()<br>
&gt; #22 0x0000000000000000 in ?? ()<br>
</font></tt><br>
<tt><font size="2">Adhemerval and I were just looking at the signal stack frames and I'd noticed the increase in size due to the addition of the HTM bits so this is great timing.</font></tt><br>
<br>
<tt><font size="2">I tried a sigstack.h patch that increased the values as you indicated and it cleaned up the failing tst-cancel21* testcases on POWER8. &nbsp;I didn't try it on POWER7 yet.</font></tt><br>
<br>
<tt><font size="2">Ryan S. Arnold</font></tt></body></html>
--0__=09BBF127DFE30CA28f9e8a93df938690918c09BBF127DFE30CA2--
