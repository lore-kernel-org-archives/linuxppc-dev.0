Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 4467767A72
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 01:10:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 29 Mar 2005 17:10:42 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B16@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: when to do ioremap?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ladies and Gentlemen,

Even if I am a Linux kernel newbie, I'm in charge of adapting a =
Montavista LSP (designed for the IBM 405EP evaluation board) to our =
propietary hardware which uses a 405EP too.
So, I created both files /arch/ppc/platforms/myBoard.c and myBoard.h =
first copying the LSP files and then modifying them.=20
However, you guess that our mapping is very different from the one used =
by the IBM eval board. The fact is that I'm not at all familiar with =
memory management (I'm a part time student/worker) and I try to =
understand the board_setup_arch function provided by the LSP (cf. =
below). I understand that the ioremap allows us to build new page tables =
mapping physical addresses on a range of contiguous (linear) virtual =
addresses. But why are we doing that at that early boot time and not in =
a driver at a wanted time? In the IBM eval board case, only 2 fpga =
registers are used but on my board, we are using up to 4K for our I/O =
space (segmented in 4 different part -> ex: =
engineer_purpose_regs,appli_regs, asic_regs,..). Then we have a software =
that must play with those registers from the user-space.
So could you explain me the original file to help me coding the new one. =
I definitely don't understand what are the consequences of that (the =
function return is void,nothing is done with the returns of ioremap =
calls except test). Does it allow us to do something later? Couldn't we =
do all of that in a driver or is there a serious reason to do it here?

void __init
board_setup_arch(void)
{
#define EVB405EP_FPGA_BASE      0xF0300000

        void *fpga_reg0;
        void *fpga_reg1;

        evb405ep_early_serial_map();
        fpga_reg0 =3D ioremap(EVB405EP_FPGA_BASE, 8);
        if (!fpga_reg0) {
                printk(KERN_CRIT
                       "evb405ep_setup_arch() fpga_reg0 ioremap =
failed\n");
                return;
        }

        fpga_reg1 =3D fpga_reg0 + 1;
}

Hoping that the question is not too stupid : tks a lot everyone for =
helping a student lost in the linux kernel sources... :-)=20
