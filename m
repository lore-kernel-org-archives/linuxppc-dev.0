Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1J691spLzDwNF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 00:05:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Landley <rob@landley.net>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc64 kernel panic if you disable
 CONFIG_PPC_TRANSACTIONAL_MEM?
In-Reply-To: <CAOS_Y6SsUJYjrwc5GM-MpLWudWNVgkESKi4evNPs_JppEdQ8TQ@mail.gmail.com>
References: <CAOS_Y6SsUJYjrwc5GM-MpLWudWNVgkESKi4evNPs_JppEdQ8TQ@mail.gmail.com>
Date: Wed, 20 Dec 2017 00:05:00 +1100
Message-ID: <87shc698cj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Landley <rob@landley.net> writes:

> I just added a ppc64 target to https://github.com/landley/mkroot which
> means I built 4.14 with the attached miniconfig and ran it with the
> attached qemu command line, and it works fine as is but if you remove
> the transactional mem line from the config the kernel panics instead
> of launching a shell prompt:
>
> init[1]: unhandled signal 4 at 0000000010001a04 nip 0000000010001a04
> lr 000000001002ebe8 code 1
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
>
> CPU: 0 PID: 1 Comm: init Not tainted 4.14.0 #1
> Call Trace:
> [c00000000e02fa40] [c0000000004ba730] dump_stack+0xb0/0xf0 (unreliable)
> [c00000000e02fa80] [c0000000000602a0] panic+0x138/0x2f8
> [c00000000e02fb20] [c00000000006541c] do_exit+0xa9c/0xaa0
> [c00000000e02fbe0] [c0000000000654d8] do_group_exit+0x58/0xf0
> [c00000000e02fc20] [c000000000073274] get_signal+0x1c4/0x6b0
> [c00000000e02fd10] [c0000000000142a0] do_signal+0x60/0x290
> [c00000000e02fe00] [c00000000001461c] do_notify_resume+0x8c/0xd0
> [c00000000e02fe30] [c00000000000b630] ret_from_except_lite+0x5c/0x60
> Rebooting in 1 seconds..

I built it here and got:

init[1]: unhandled signal 4 at 00000000100f3eb4 nip 00000000100f3eb4 lr 00000000100d1e38 code 1

Which looking at objdump is:

00000000100f3eb0 <_savevr_30>:
    100f3eb0:   e0 ff 80 39     li      r12,-32
    100f3eb4:   ce 01 cc 7f     stvx    v30,r12,r0

stvx is an ALTIVEC (vmx) instruction, so you need a kernel built with
CONFIG_ALTIVEC.

When you turn on TRANSACTIONAL_MEM it selects ALTIVEC, so that's why
enabling that "fixes" it for you.

If you just add CONFIG_ALTIVEC=y it should work.

cheers
