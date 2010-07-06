Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 3ECDCB6EEF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jul 2010 09:08:28 +1000 (EST)
Received: by iwn36 with SMTP id 36so6362595iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jul 2010 16:08:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100706152110.4f25e96b@schlenkerla.am.freescale.net>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
Date: Tue, 6 Jul 2010 16:08:26 -0700
Message-ID: <AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 6, 2010 at 1:21 PM, Scott Wood <scottwood@freescale.com> wrote:
> Hmm... try 0xfa203bf8 (assuming your muram/data node has reg =3D <0
> 0x1c00>). It looks like commit c2dd3529f35de9e2f51eba9bbf9969f5dc8382d4
> changed the bootwrapper's cpm-serial driver to allocate from the end of
> MURAM instead of the beginning, but updated
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR to match only on CPM2, not CPM1.

That was it. The value @0xfa203bf8 is 0x20000001. The kernel certainly
moved forward till it stuck at the new place cpm_uart_initbd() as
shown below. I cannot get more info from gdb now since my BDI2000's fw
is too old to get MMU translation work for 2.6.x kernel. I'm waiting
for the new firmware upgrade.

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
cpm_uart_initbd (pinfo=3D0x1032)
    at /home/rayan/wti/code/wti-linux-2.6.33.5/arch/powerpc/include/asm/io.=
h:161
161     DEF_MMIO_OUT_BE(out_be32, 32, stw);


> Could the kernel have crashed, and is waiting the 180 seconds to
> reboot? =A0Try doing a stack trace, and/or dumping the kernel's log
> buffer.

It sounds like that. gdb showed there was only one level of function
in the stack, which was udelay(). Strange? How to dump the kernel log
buffer?

Thanks a lot for your continuous help!
-Shawn.
