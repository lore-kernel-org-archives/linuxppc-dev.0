Message-ID: <3AEDEF2D.4B823134@iiic.ethz.ch>
Date: Tue, 01 May 2001 01:03:10 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
		<3ACB537B.99B851B9@netfall.com>
		<87hf0433qs.fsf@amadeus.openinformatics.com>
		<3ACB6167.3B2E0242@iiic.ethz.ch>
		<878zlg31mw.fsf@amadeus.openinformatics.com>
		<3ACB9611.C95D16A2@iiic.ethz.ch>
		<87ae5w1ce3.fsf@amadeus.openinformatics.com>
		<3ACB9EB3.2661FFCE@iiic.ethz.ch>
		<87u242zz7y.fsf@amadeus.openinformatics.com>
		<3ACCFFBB.58CC75D2@iiic.ethz.ch> <87itjmf7lf.fsf_-_@amadeus.openinformatics.com>
Content-Type: multipart/mixed;
 boundary="------------B26AD1FADCEA1F2A488889E1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B26AD1FADCEA1F2A488889E1
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


(Adding CC: to linuxppc-dev to reach more potentially interested people)

"Jason E. Stewart" wrote:

> I'm writing this email to you off my ViewSonic21 running at measly
> 1280x1024 but it's much better than the 1024x768 I got using
> 'mirror'.
>
> I rebuilt r128_driver.c with the CRTOnly code commented in, added:
>
> Option "CRTOnly"
>
> to my XF86Config, and took out:
>
> Option "ProgramFPRegs" "No"
>
> (that last one caused me quite some grief till I read the code and
> realized it wasn't running the CRTOnly check unless registers were
> on....)
>
> And it works!!!!

Great!


> I'm happy to provide my recompiled r128_drv.o to pismo folks. Perhaps
> Michel can put it on his WWW site?

I am reluctant to do that. I'd prefer to get a solution into XFree86.

Someone please try the attached patch against current CVS. It turns Option
"UseBIOSDisplay" (which probably doesn't work for us - no BIOS here...) into
Option "Display" which accepts modes "CRT", "FP", "Mirror" and "BIOS".


Reports, comments and suggestions most welcome.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member
--------------B26AD1FADCEA1F2A488889E1
Content-Type: text/plain; charset=us-ascii;
 name="r128_display.diff"
Content-Disposition: inline;
 filename="r128_display.diff"
Content-Transfer-Encoding: 7bit

Index: r128_driver.c
===================================================================
RCS file: /cvs/xc/programs/Xserver/hw/xfree86/drivers/ati/r128_driver.c,v
retrieving revision 1.26
diff -u -3 -r1.26 r128_driver.c
--- r128_driver.c	2001/04/10 16:07:59	1.26
+++ r128_driver.c	2001/04/30 15:38:46
@@ -140,7 +140,7 @@
   /* FIXME: Disable CRTOnly until it is tested */
   OPTION_CRT,
 #endif
-  OPTION_BIOS_DISPLAY,
+  OPTION_DISPLAY,
   OPTION_PANEL_WIDTH,
   OPTION_PANEL_HEIGHT,
   OPTION_PROG_FP_REGS,
@@ -165,7 +165,7 @@
   { OPTION_BUFFER_SIZE,  "BufferSize",       OPTV_INTEGER, {0}, FALSE },
   { OPTION_USE_CCE_2D,   "UseCCEfor2D",      OPTV_BOOLEAN, {0}, FALSE },
 #endif
-  { OPTION_BIOS_DISPLAY, "UseBIOSDisplay",   OPTV_BOOLEAN, {0}, FALSE },
+  { OPTION_DISPLAY,      "Display",          OPTV_STRING,  {0}, FALSE },
   { OPTION_PANEL_WIDTH,  "PanelWidth",       OPTV_INTEGER, {0}, FALSE },
   { OPTION_PANEL_HEIGHT, "PanelHeight",      OPTV_INTEGER, {0}, FALSE },
   { OPTION_PROG_FP_REGS, "ProgramFPRegs",    OPTV_BOOLEAN, {0}, FALSE },
@@ -920,10 +920,24 @@
        setting.  BIOS_5_SCRATCH holds the display device on flat panel
        systems only. */
     if (info->HasPanelRegs) {
-	if (xf86ReturnOptValBool(R128Options, OPTION_BIOS_DISPLAY, FALSE))
-	    info->BIOSDisplay = INREG8(R128_BIOS_5_SCRATCH);
+        char *display = xf86GetOptValString(R128Options, OPTION_DISPLAY);
+
+	if (!strcmp(display, "BIOS"))
+	  info->BIOSDisplay = INREG8(R128_BIOS_5_SCRATCH);
+	else if (!strcmp(display, "Mirror"))
+	  info->BIOSDisplay = R128_BIOS_DISPLAY_FP_CRT;
+	else if (!strcmp(display, "CRT"))
+	  info->BIOSDisplay = R128_BIOS_DISPLAY_CRT;
+	else if (!strcmp(display, "FP"))
+	  info->BIOSDisplay = R128_BIOS_DISPLAY_FP;
 	else
-	    info->BIOSDisplay = R128_BIOS_DISPLAY_FP;
+	{
+	  xf86DrvMsg(pScrn->scrnIndex, X_ERROR,
+		     "Unsupported mode \"%s\" specified for Option \"Display\".\n", display);
+	  xf86DrvMsg(pScrn->scrnIndex, X_INFO,
+		     "Supported modes are: \"BIOS\", \"Mirror\", \"CRT\" and \"FP\"\n");
+	  return FALSE;
+	}
     } else {
 	info->BIOSDisplay     = R128_BIOS_DISPLAY_CRT;
     }
@@ -1949,7 +1963,7 @@
 #endif
 			     )) return FALSE;

-				/* DPMS setup */
+				/* DPMS setup - FIXME: also for mirror mode? - Michel */
     if (!info->HasPanelRegs || info->BIOSDisplay == R128_BIOS_DISPLAY_CRT)
 	xf86DPMSInit(pScreen, R128DisplayPowerManagementSet, 0);


--------------B26AD1FADCEA1F2A488889E1--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
