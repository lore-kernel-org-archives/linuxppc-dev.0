Date: Mon, 5 Jun 2000 13:27:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: CONFIG_BLK_DEV_IDEDMA_PCI
Message-ID: <Pine.LNX.4.05.10006051320470.5397-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When trying to compile the sl82c105 IDE driver for my LongTrail, I stumbled
across the following problem:

This driver needs CONFIG_BLK_DEV_IDEDMA=y, so its config line in
drivers/ide/Config.in should look like:

    dep_mbool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105 $CONFIG_BLK_DEV_IDEDMA_PCI

Unfortunately I cannot turn CONFIG_BLK_DEV_IDEDMA on because it is
automatically turned off again by the following construct in
drivers/ide/Config.in:

  if [ "$CONFIG_PMAC" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
     bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
     dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
     dep_bool '        Use DMA by default' CONFIG_IDEDMA_PMAC_AUTO $CONFIG_BLK_DEV_IDEDMA_PMAC
     define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
     define_bool CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDEDMA_PMAC
  fi

I think this part needs to be under the test for CONFIG_PCI, just like the
other PCI IDE (DMA) drivers.

Note that I have no IDE devices attached, so this is just a compile test.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
