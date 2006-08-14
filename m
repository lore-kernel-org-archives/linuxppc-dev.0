Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 59F6367B55
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:08:44 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p48so112456nfa
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 09:08:41 -0700 (PDT)
Message-ID: <787b0d920608140908x391e926cs7c1023cb7ab5597f@mail.gmail.com>
Date: Mon, 14 Aug 2006 12:08:41 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "=?ISO-8859-1?Q?Michel_D=E4nzer?=" <michel@tungstengraphics.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <1155547172.12664.115.camel@thor.lorrainebruecke.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<1155547172.12664.115.camel@thor.lorrainebruecke.local>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The module failing is not actually the problem.
I get GLcore failing with a numeric error message
(grrr... like an original Mac or Amiga, or LILO)
even when things work OK.

Messages from the failing situation:

# cat Xorg.0.log.old | egrep 'EE|WW|!!|[abcdf-zA-Z]GL|gl|Gl|GL[a-zA-Z]|Chipset'
Current Operating System: Linux cube 2.6.17-rc5 #13 PREEMPT Sun Aug 13
22:06:21 EDT 2006 ppc
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(II) LoadModule: "GLcore"
(II) Loading /usr/lib/xorg/modules/extensions/libGLcore.so
dlopen: /usr/lib/xorg/modules/extensions/libGLcore.so: undefined
symbol: __glXLastContext
(EE) Failed to load /usr/lib/xorg/modules/extensions/libGLcore.so
(II) UnloadModule: "GLcore"
(EE) Failed to load module "GLcore" (loader failed, 7)
(II) Loading extension MIT-SCREEN-SAVER
(II) LoadModule: "glx"
(II) Loading /usr/lib/xorg/modules/extensions/libglx.so
(II) Module glx: vendor="X.Org Foundation"
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/lib/xorg/modules/extensions/libGLcore.so
(II) Module GLcore: vendor="X.Org Foundation"
(II) Loading extension GLX
(--) Chipset ATI Rage 128 Pro GL PF (AGP) found
(WW) ****INVALID IO ALLOCATION**** b: 0xf0000400 e: 0xf00004ff correcting
(EE) end of block range 0xefffffff < begin 0xf0000000
(--) R128(0): Chipset: "ATI Rage 128 Pro GL PF (AGP)" (ChipID = 0x5046)
(WW) R128(0): Video BIOS not detected in PCI space!
(WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
(WW) R128(0): Video BIOS not found!
(WW) R128(0): Can't determine panel dimensions, and none specified.
(EE) R128(0): No DFP detected
(!!) R128(0): For information on using the multimedia capabilities
(WW) R128(0): Static buffer allocation failed -- need at least 19200
kB video memory
        Solid filled rectangles
        8x8 mono pattern filled rectangles
(WW) R128(0): Direct rendering disabled


Messages from when it works:

# cat Xorg.0.log | egrep 'EE|WW|!!|[abcdf-zA-Z]GL|gl|Gl|GL[a-zA-Z]|Chipset'
Current Operating System: Linux cube 2.6.17-rc5 #11 PREEMPT Sun Aug 13
19:02:53 EDT 2006 ppc
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(II) LoadModule: "GLcore"
(II) Loading /usr/lib/xorg/modules/extensions/libGLcore.so
dlopen: /usr/lib/xorg/modules/extensions/libGLcore.so: undefined
symbol: __glXLastContext
(EE) Failed to load /usr/lib/xorg/modules/extensions/libGLcore.so
(II) UnloadModule: "GLcore"
(EE) Failed to load module "GLcore" (loader failed, 7)
(II) Loading extension MIT-SCREEN-SAVER
(II) LoadModule: "glx"
(II) Loading /usr/lib/xorg/modules/extensions/libglx.so
(II) Module glx: vendor="X.Org Foundation"
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/lib/xorg/modules/extensions/libGLcore.so
(II) Module GLcore: vendor="X.Org Foundation"
(II) Loading extension GLX
(--) Chipset ATI Rage 128 Pro GL PF (AGP) found
(WW) ****INVALID IO ALLOCATION**** b: 0xf0000400 e: 0xf00004ff correcting
(EE) end of block range 0xefffffff < begin 0xf0000000
(--) R128(0): Chipset: "ATI Rage 128 Pro GL PF (AGP)" (ChipID = 0x5046)
(WW) R128(0): Video BIOS not detected in PCI space!
(WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
(WW) R128(0): Video BIOS not found!
(WW) R128(0): Can't determine panel dimensions, and none specified.
(EE) R128(0): No DFP detected
(!!) R128(0): For information on using the multimedia capabilities
(WW) R128(0): Static buffer allocation failed -- need at least 19200
kB video memory
        Solid filled rectangles
        8x8 mono pattern filled rectangles
(WW) R128(0): Direct rendering disabled

A diff:

--- Xorg.0.log  2006-08-14 16:08:07.000000000 -0400
+++ Xorg.0.log.old      2006-08-13 22:28:40.000000000 -0400
@@ -3,7 +3,7 @@
 Release Date: 21 December 2005
 X Protocol Version 11, Revision 0, Release 7.0
 Build Operating System:Linux 2.4.25 ppc
-Current Operating System: Linux cube 2.6.17-rc5 #11 PREEMPT Sun Aug
13 19:02:53 EDT 2006 ppc
+Current Operating System: Linux cube 2.6.17-rc5 #13 PREEMPT Sun Aug
13 22:06:21 EDT 2006 ppc
 Build Date: 16 March 2006
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
@@ -11,7 +11,7 @@
 Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
-(==) Log file: "/var/log/Xorg.0.log", Time: Sun Aug 13 22:32:27 2006
+(==) Log file: "/var/log/Xorg.0.log", Time: Sun Aug 13 22:28:37 2006
 (==) Using config file: "/etc/X11/xorg.conf"
 (==) ServerLayout "Default Layout"
 (**) |-->Screen "Default Screen" (0)
@@ -788,12 +788,4 @@
 Could not init font path element /usr/share/fonts/X11/TTF/, removing from list!
 Could not init font path element /usr/share/fonts/X11/OTF, removing from list!
 Could not init font path element /usr/share/fonts/X11/CID/, removing from list!
-(II) 3rd Button detected: disabling emulate3Button
-SetGrabKeysState - disabled
-SetGrabKeysState - enabled
-SetGrabKeysState - disabled
-SetGrabKeysState - enabled
-SetGrabKeysState - disabled
-SetGrabKeysState - enabled
-SetGrabKeysState - disabled
-SetGrabKeysState - enabled
+FreeFontPath: FPE "/usr/share/fonts/X11/misc" refcount is 2, should
be 1; fixing.
