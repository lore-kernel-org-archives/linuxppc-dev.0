Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 773E067B2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 00:45:54 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id c59so1672666pyc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Jun 2006 07:45:52 -0700 (PDT)
Message-ID: <b4b98b690606060745p209c071co3822300cbbce4266@mail.gmail.com>
Date: Tue, 6 Jun 2006 07:45:52 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "salvatore cusenza" <salvatore.cusenza@gmail.com>
Subject: Re: eth0: tx queue full
In-Reply-To: <9252a64b0606060113v696adbb7ib43ad95836c0724b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9252a64b0606060113v696adbb7ib43ad95836c0724b@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/6/06, salvatore cusenza <salvatore.cusenza@gmail.com> wrote:
>
> At runtime during the usual life of my board (MPC852 and linux-2.4.20 Denk's
> distribution)
>  I have experienced the following crash:
>
>
> eth0: tx queue full!.
> eth0: tx queue full!.
> eth0: tx queue full!.
>
> Oops: kernel access of bad area, sig: 11
> NIP: C000D440 XER: 00000000 LR: C00BB040 SP: C0C9BC10 REGS: c0c9bb60 TRAP:
> 0300    Tainted: P
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00001F9D, DSISR: 000000E4
> TASK = c0c9a000[145] 'L5421' Last syscall: 4
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C0C9BC10 C0C9A000 C0F56D70 00001F99 0000003C C0F56D6C
> 00000007
> GPR08: 00000001 0000003C 00000000 C0F56DB0 C0D83C3C 10071D28 00000000
> C3120000
> GPR16: C311CB04 C311C8D8 C311C754 C0170000 C3120000 C311CB30 00000001
> C0169DA0
> GPR24: F0000E00 00001F9D C0F58400 0000003C 00000040 C2080100 C0F58200
> C0F501B0
> Call backtrace:
> C00BAF8C C00BABC8 C0005848 C3119448 C31194C0 C31194F8 C00066F8
> C0011A48 C00BA8FC C00CADD8 C00C3F00 C0016B50 C00AFE4C C00B4B94
> C00B5EF4 C003571C C000457C 0FFD5E4C 0FEDB8DC 0FEDB284 1003B5B8
> 1003D558 1003A88C 0FED34A4 0FED32D0 0FFCFEE4 0FD5F590
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 180 seconds..
>
>
> Could you suggest me something to investigate?
>


First thing I'd do is get my hands on ksymoops and look at the callstack.

Check out...

http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/

>From my past experience, seems to me that I have had a similar oops
when the driver code that I have been debugging usually is stuck in a
loop at interrupt time and your missing interrupts.

Or better yet, your just plain crashing at interrupt time.  It sounds
like this is pretty easy to reproduce so follow the readme on
ksymoops.

Hope that helps.

-stv
