Message-ID: <3CB43C45.4263F1AA@imc-berlin.de>
Date: Wed, 10 Apr 2002 15:21:09 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: ide-m8xx as a MODULE
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I tried to make the MPC8xx IDE Driver loadable as a module (nevermind if
this is useful or not).

It is working - at least in my configuration.

BUT:

Apparently I am too stupid to understand all this Makefile stuff. That's
why I changed the drivers/ide/Makefile to look like this now:

===================================================================
RCS file: /home/cvsroot/linux-2.4.18/drivers/ide/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- drivers/ide/Makefile        2002/04/05 11:46:19     1.1.1.1
+++ drivers/ide/Makefile        2002/04/10 12:59:34
@@ -65,7 +65,15 @@
 ide-obj-$(CONFIG_BLK_DEV_TRM290)       += trm290.o
 ide-obj-$(CONFIG_BLK_DEV_UMC8672)      += umc8672.o
 ide-obj-$(CONFIG_BLK_DEV_VIA82CXXX)    += via82cxxx.o
-ide-obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)   += ide-m8xx.o
+
+ifeq ($(CONFIG_BLK_DEV_MPC8xx_IDE),y)
+       ide-obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)    += ide-m8xx.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_MPC8xx_IDE),m)
+       obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)        += ide-m8xx.o
+endif
+

 # The virtualised raid layers MUST come after the ide itself or bad
stuff
 # will happen.
Otherwiser eihter there problems during compile or ide-m8xx.o is not
built at all.
I am pretty sure that there is a better i.e. correct way to do this. Any
hints?

Another points is:

When I unload the module and call ide_unregister(0) then the function
m8xx_ide_init_hwif_ports() is called again!
Should I released the region which is ioremaped the first time
m8xx_ide_init_hwif_ports() gets called?

	if (!ide_base) {
...
		ide_base=(unsigned long)ioremap(ide_phy_base,
						ide_phy_end-ide_phy_base);
...
	}


Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
