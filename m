Date: Sat, 20 Dec 2003 17:58:50 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	benh@kernel.crashing.org
Subject: [PATCH] tas3004_tables.c off-by-one
Message-Id: <20031220175850.416fb0ec.colin@colino.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__20_Dec_2003_17_58_50_+0100_=.PbUjRbQ2?jeXgo"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Sat__20_Dec_2003_17_58_50_+0100_=.PbUjRbQ2?jeXgo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I noticed that when pushed to the upper limits, the mixer channels on my
ibook G4 just went silent (tested with master, bass, treble).

I found out this was due to too short (by one item) arrays in
tas3004_tables.c. This patch fixes it. I just copied over the last entry
of each array.

HTH,
--
Colin
http://www.colino.net/

--Multipart_Sat__20_Dec_2003_17_58_50_+0100_=.PbUjRbQ2?jeXgo
Content-Type: text/plain;
 name="tas3004_tables.diff"
Content-Disposition: attachment;
 filename="tas3004_tables.diff"
Content-Transfer-Encoding: 7bit

--- drivers/sound/dmasound/tas3004_tables.c.orig	2003-12-20 17:53:45.000000000 +0100
+++ drivers/sound/dmasound/tas3004_tables.c	2003-12-20 17:53:57.000000000 +0100
@@ -195,7 +195,7 @@
 	   0x1577b,    0x16a37,    0x17df5,    0x192bd,
 	   0x1a890,    0x1bf7b,    0x1d78d,    0x1f0d1,
 	   0x20b55,    0x22727,    0x24456,    0x262f2,
-	   0x2830b
+	   0x2830b,    0x2830b
 };

 static uint tas3004_mixer_tab[]={
@@ -224,7 +224,7 @@
 	  0x1577ac,   0x16a370,   0x17df51,   0x192bc2,
 	  0x1a88f8,   0x1bf7b7,   0x1d78c9,   0x1f0d04,
 	  0x20b542,   0x227268,   0x244564,   0x262f26,
-	  0x2830af
+	  0x2830af,   0x2830af
 };

 static uint tas3004_treble_tab[]={
@@ -253,7 +253,7 @@
 	      0x2f,       0x2c,       0x27,       0x23,
 	      0x1f,       0x1a,       0x15,        0xf,
 	       0x8,        0x5,        0x2,        0x1,
-	       0x1
+	       0x1,        0x1
 };

 static uint tas3004_bass_tab[]={
@@ -282,7 +282,7 @@
 	      0x36,       0x33,       0x2f,       0x2b,
 	      0x28,       0x24,       0x20,       0x1c,
 	      0x17,       0x12,        0xd,        0x7,
-	       0x1
+	       0x1,       0x1
 };

 struct tas_gain_t tas3004_gain={

--Multipart_Sat__20_Dec_2003_17_58_50_+0100_=.PbUjRbQ2?jeXgo--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
