Message-Id: <200006052036.WAA01340@piglet.grunz.lu>
Date: Mon, 5 Jun 2000 22:36:04 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: CONFIG_BLK_DEV_IDEDMA_PCI
To: geert@linux-m68k.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10006051320470.5397-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Jun, this message from Geert Uytterhoeven echoed through cyberspace:
> When trying to compile the sl82c105 IDE driver for my LongTrail, I stumbled
> across the following problem:
>
> This driver needs CONFIG_BLK_DEV_IDEDMA=y, so its config line in
> drivers/ide/Config.in should look like:
>
>     dep_mbool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105 $CONFIG_BLK_DEV_IDEDMA_PCI
>
> Unfortunately I cannot turn CONFIG_BLK_DEV_IDEDMA on because it is
> automatically turned off again by the following construct in
> drivers/ide/Config.in:
>
>   if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
>      bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
>      dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
>      dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO $CONFIG_BLK_DEV_IDEDMA_PMAC
>      define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
>      define_bool CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDEDMA_PMAC
>   fi

Aha, that might be one of the reasons why I need to enable PowerMac
built-in IDE, although I don't have such a beast, in order to get my
Promise going...

> I think this part needs to be under the test for CONFIG_PCI, just like the
> other PCI IDE (DMA) drivers.

There is quite some mixup on PPC between standard (PC, that is :-( ) IDE
and PowerMac IDE. Paul Mackerras might help out on that part...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
