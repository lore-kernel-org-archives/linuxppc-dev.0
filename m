Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A6FC6828E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 00:39:09 +1000 (EST)
Date: Tue, 13 Sep 2005 11:25:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050913142513.GD10602@dmt.cnet>
References: <4326968F.5030609@2net.co.uk>
	<20050913122541.GB9076@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050913122541.GB9076@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Folks, 

Can you please upgrade to a recent kernel? 

A problem with ptrace has been fixed sometime ago, it might be what you're hitting.

The fix is part of v2.6.13:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bf85fa6c878aa3968df47d7f70a2b506c3e53b99

If that does not work, complain. 

On Tue, Sep 13, 2005 at 09:25:41AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > I am running Linux 2.6.11 on a TQM823L development board. I find that 
> > gdb (version 6.3) hangs when I try to run an application - any 
> > application, even a simple helloworld. It's not just gdb hanging, the 
> > whole system is stone dead.
> "me too"
> actually the system is not completely dead, you still can use sysrq keys.
> Tried to use gdbserver too, but it also doesn't work (hangs after the first
> breakpoint and timeouts).
> 
> gdb           S 30106778     0   691    687   692               (NOTLB)
> Call trace:
>  [c0005330] __switch_to+0x44/0x78
>  [c015beb0] schedule+0x30c/0x730
>  [c015c888] schedule_timeout+0xdc/0xe0
>  [c0068918] sys_poll+0x27c/0x404
>  [c0002810] syscall_dotrace_cont+0x24/0x38
> flash_test    t 100009E4     0   692    691                     (NOTLB)
> Call trace:
>  [c0005330] __switch_to+0x44/0x78
>  [c015beb0] schedule+0x30c/0x730
>  [c0026248] ptrace_stop+0x68/0x88
>  [c0026604] get_signal_to_deliver+0x130/0x2b4
>  [c00063dc] do_signal+0x38/0x464
>  [c0003034] do_user_signal+0x74/0xc4
> 
> -- 
> Aristeu
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
