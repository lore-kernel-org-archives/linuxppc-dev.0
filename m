Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36C6F@chzugexch01.abatos.com>
From: Graf Alex <alex.graf@siemens.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Hotplug for two CF cards
Date: Wed, 1 Oct 2003 13:48:36 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working with a MPC855 Board from TQ Systems.
On this processor are two PCMCIA slots supported.

I have modified the u-boot for two slots static IDE support. And on Linux
too. This works fine. On Linux I wan't hotplug support. I've modified
m8xx_pcmcia.c for two socket pcmcia-cs support. With cardctl I can query the
cards. cardmgr loads too the right module I wan't: ide-cs.c BUT:

I can only use the slots EXOR! If I insert a second card, the first is
unloaded and new registered. This don't surprise me. Both cards are mapped
to the same io ports.
->ide0 at 0x100-0x107,0x10e on irq 7

>From where are the f... 0x100-0c107,0x10e? Yes, the ranges are in
/etc/pcmcia/config.opts defined. But why cardmgr takes not an other range
for the second insertet card?
Do I need another io_block_mapping for the second slot?
Or shoud I overwrite the ports in m8xx_ide_init_hwif_ports? (I think this
could not be the solution)

Thanks in advance

Alex Graf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
