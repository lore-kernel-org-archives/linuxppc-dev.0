Date: Mon, 10 Jul 2000 17:20:50 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
In-Reply-To: <20000710221410.2067@192.168.1.10>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000710171750.14195D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:

> >
> >Why is pmac_backlight.c compiled in for CONFIG_ALL_PPC?  Isn't it
> >PowerBook only thing?
>
> Well, if you change that, then chipsfb.c, atyfb.c, aty128fb.c and via-
> pmu.c must be changed too. It's not completely powerbook only since, at
> term, this could driver also external LVDS LCD backlight.

Yes, that's true.  I forgot about that.  Sorry.  In any case, my initial
problem with this was just CONFIG_ADB_PMU thing, and I went too far.


Takashi Oe

--- linuxppc_2_3-vanilla/arch/ppc/kernel/pmac_backlight.c	Mon Jul 10 02:18:43 2000
+++ linuxppc_2_3-nubus/arch/ppc/kernel/pmac_backlight.c	Mon Jul 10 17:16:54 2000
@@ -63,7 +63,8 @@
 		if (backlight_level > BACKLIGHT_MAX)
 			backlight_level = BACKLIGHT_MAX;
 	}
-
+
+#ifdef CONFIG_ADB_PMU
 	backlight_autosave = machine_is_compatible("AAPL,3400/2400")
 		|| machine_is_compatible("AAPL,3500");
 	if (backlight_autosave) {
@@ -73,6 +74,7 @@
 			pmu_poll();
 		backlight_level = req.reply[1] >> 4;
 	}
+#endif /* CONFIG_ADB_PMU */

 	if (!backlighter->set_enable(1, backlight_level, data))
 		backlight_enabled = 1;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
