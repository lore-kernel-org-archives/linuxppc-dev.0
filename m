Message-ID: <3A553C09.2AB9F6F@mvista.com>
Date: Thu, 04 Jan 2001 19:14:17 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
CC: "'Matthias Fuchs'" <matthias.fuchs@esd-electronics.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 4MB initrd crashes linux on 405 hardhat linux
References: <B25E2E5A003CD311B61E00902778AF2A018279E0@server1.skystream.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:
>
> Matthew,
>
> You might want to try this patch.  We experienced panics for ramdisks larger
> than about 12MB without it.  This code was present in the 2.3.x series, but
> somehow was mising from MontaVista's 2.4.0-test2.
>
> -Brian
>
> ===================================================================
> RCS file: /home/CVS/linux/fs/buffer.c,v
> retrieving revision 1.1.1.1
> diff -c -r1.1.1.1 buffer.c
> *** buffer.c    2000/10/17 17:47:52     1.1.1.1
> --- buffer.c    2000/10/28 21:45:15
> ***************
> *** 2338,2344 ****
>   {
>         DECLARE_WAITQUEUE(wait, current);
>
> !       if (current == bdflush_tsk)
>                 return;
>
>         if (!block) {
> --- 2338,2344 ----
>   {
>         DECLARE_WAITQUEUE(wait, current);
>
> !       if (bdflush_tsk == 0 || current == bdflush_tsk)
>                 return;
>
>         if (!block) {


Yes, please apply Brian's patch.  Brian has sent it to me and I applied
it to my sources soon after last putting my sources out on the ftp site.
This fix is also not in the FSM Labs linux_2_5 tree.  I will eventually
submit it into the proper tree if no one beats me to it.

If Brian's patch doesn't solve your problem, let me know and I'll send
you a tool to convert your stack trace to symbols so we can analyze
your problem more easily.


> -----Original Message-----
> From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
> Sent: Thursday, January 04, 2001 10:05 AM
> To: linuxppc-embedded
> Subject: 4MB initrd crashes linux on 405 hardhat linux
>
> Hello,
>
> I want to use an initial ramdisk (4 MB) on a IBM405 board. I am using
> Monta Vistas Hardhat Linux (kernel 2.4.0-test2).
> I have no problems with ramdisk with up to 2MB. They are working fine !
> Here are the startup messages of my kernel, when it crashes. I put some
> debug messages in the source to see where it crashes. I found out that
> the kernel crashes while unpacking the compressed image.
>
> Linux version 2.4.0-test2_mvista_001126 (matthias@pc-linux-dev) (gcc
> version 2.95.2 19991024 (release)) #55 Don Jan 4 18:30:
> 57 CET 2001


< details deleted >

> copy done
> copy from c027ac00 to c0debc00
> copy done
> NIP: C00153D4 XER: 20000000 LR: C00153D0 REGS: c0219270 TRAP: 1100
> MSR: 00001230 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0218000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C0219320 C0218000 00000001 00009230 C0219358 C0219378
> 01234567
> GPR08: C0218000 C0007488 00000000 C0219368 00000000 71000000 00000000
> 00000400
> GPR16: 00000000 00003000 00005000 00000100 00001000 C027B000 000009EC
> C01A0000
> GPR24: 00000000 00000000 00000400 000003FF C015B3E0 C0160000 00000000
> C0219320
> Call backtrace:
> C019AF54 C003A234 C0037870 C003790C C003E21C C0176A2C C009885C
> C00992A8 C00993F0 C009947C C0099988 C0176BA4 C01764EC C01768F0
> C0174DEC C0170888 C0170924 C00024F4 C0007BD8
> Kernel panic: kernel access of bad area pc c00153d4 lr c00153d0 address
> 40 tsk swapper/1
>
> ---------------------------
> What could be the problem of this crash ?
>
> Matthias


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
