Date: Mon, 15 Nov 1999 16:03:32 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: yellowdog-devel@lists.yellowdoglinux.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Updated iBook patches
Message-Id: <19991115160332.023854@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've uploaded new iBook patches based on Paul's latest rsync tree
(linuxcare.com.au). I've added parsing of the OF interrupt tree, setup
code for IDE (both MDMA and UDMA, MDMA should work with older machines,
we cannot rely on MacOS setting the disk features for us), code cleanup
and support for iMac DV (adb-less).

There are still some issues with the iMacDV, I had only occasional access
to the machine. There is an issue with IDE timings (didn't find time to
look if the disk itself is setup incorrectly or the controller's timing
register) and the ethernet mii PHY is not recognized by the de4x5.c
driver (I didn't test tulip).

Note that BootX doesn't work on iMacDV (and probably Sawtooth), but the
poof bootloader works fine now that OF booting is supported. iBook
requires BootX 1.2b2 which will be posted real soon now.


Note about early boot text:

The arch/ppc/kernel/prom.c patch contains the changes to make prom_print
to work on the OF display after OF is terminated. You'll have to make
sure the map_bootx_text function is called after MMU initialisation. This
is usually done by xmon, but you might have to hack xmon a bit since it
does this only when there's a PMU.
Once this is done, xmon_printf should work too.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
