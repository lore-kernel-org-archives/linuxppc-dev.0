Return-Path: <murphyf+linux-ppc@f-m.fm>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19CCF2BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 06:14:43 +1000 (EST)
Received: from 80-218-155-94.dclient.hispeed.ch
	(80-218-155-94.dclient.hispeed.ch [80.218.155.94])
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id
	i8FJnEUq027906
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 21:49:14 +0200
From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: linuxppc-dev@ozlabs.org
Date: Wed, 15 Sep 2004 21:51:42 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O1JSB/bceprgmbW"
Message-Id: <200409152151.42075.murphyf+linux-ppc@f-m.fm>
Subject: [patch] Minor keyboard problems in 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-00=_O1JSB/bceprgmbW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

  I tried sending this last week, but the old mailing list failed, so I'll 
send it again.

  I discovered a problem a while ago with the ADB conversion of the Windows 
Menu key. This won't affect most users, but it comes up on my iBook (and I 
imagine PowerBooks as well). This is basically the work of Gabriel Paubert 
<paubert@iram.es>, and I've tested this patch with 2.6.8. I imagine it would 
work in 2,4 as well. (It's only a 2-character change.)

  Before the patch, fn+KP_Enter would generate 5b / db (and X mangles the 
keysym to be the same as Page Up).

  After, it generates e0 5d / e0 dd and X recoginizes the Menu keysym 
properly.

Let me know if you need any other info.

Frank

--Boundary-00=_O1JSB/bceprgmbW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kbd_menu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kbd_menu.patch"

--- drivers/macintosh/adbhid.c.dist	2004-08-28 08:11:58.000000000 +0200
+++ drivers/macintosh/adbhid.c	2004-09-07 21:49:34.000000000 +0200
@@ -81,7 +81,7 @@
 	 15, 57, 41, 14, 96,  1, 29,125, 42, 58, 56,105,106,108,103,  0,
 	  0, 83,  0, 55,  0, 78,  0, 69,  0,  0,  0, 98, 96,  0, 74,  0,
 	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,124, 89,121,
-	 63, 64, 65, 61, 66, 67,123, 87,122, 99,  0, 70,  0, 68,101, 88,
+	 63, 64, 65, 61, 66, 67,123, 87,122, 99,  0, 70,  0, 68,127, 88,
 	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,126,116
 };
 

--Boundary-00=_O1JSB/bceprgmbW--
