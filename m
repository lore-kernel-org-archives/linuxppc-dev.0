Date: Thu, 16 Mar 2000 16:42:59 -0500 (EST)
From: "Jo-Ellen F. Mathews" <joellen@absoval.com>
Reply-To: "Jo-Ellen F. Mathews" <joellen@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux Planet Module Support
In-Reply-To: <38B41424.8921DC4@netx4.com>
Message-ID: <Pine.LNX.3.96.1000316161543.23230C-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi all,

I've been working on porting our 11Mb wireless LAN device driver to
Embedded Planet's nifty RPX-Lite (MPC823) board.  I've been using Embedded
Planet's wonderful, new Linux Planet development kit which includes
MontaVista's Hard Had Linux 1.0.  I'm loving this kit!

I'm using the cross compiler provided on MontaVista's cd, and I've been
very successful at compiling the default kernel and a few, simple
programs.

The most direct approach (okay, and quickest/easiest) is to keep the
wireless lan driver as a loadable module dependent on pcmcia card
services.  Before attempting to use Magnus Damm's pcmcia patches and
kernel modifications to support pcmcia, I first need to recompile my
kernel for module support.

With CONFIG_MODULES enabled (regardless of what CONFIG_MODVERSIONS or
CONFIG_KMOD are set to), I get the following errors:

ppc_ksyms.c:72: `isa_io_base' undeclared here (not in a function)
ppc_ksyms.c:72: initializer element is not constant
ppc_ksyms.c:72: (near initialization for `__ksymtab_isa_io_base.value')
ppc_ksyms.c:74: `pci_dram_offset' undeclared here (not in a function)
ppc_ksyms.c:74: initializer element is not constant
ppc_ksyms.c:74: (near initialization for
`__ksymtab_pci_dram_offset.value')


When I comment out these two lines, the compiler errors continue to get
worse.

Can anyone recommend any changes I should make to fix these errors?
Additionally, could you give me a rundown on any issues with the
MPC8xx kernel supporting modules?

Previously, we ported our 2Mb wireless lan driver to the RPX-Lite by hard
coding all the pcmcia "stuff" in the driver itself.  For this port, we'd
like to use pcmcia services so the embedded driver and our "non-embedded"
driver use the same code (easier to maintain source!).

Many, many, many thanks!
Jo-Ellen Mathews

---------------------------------------------------------
Jo-Ellen F. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: joellen@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
