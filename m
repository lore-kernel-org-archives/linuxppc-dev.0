Date: Fri, 4 Feb 2000 15:20:54 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] little-endian dmasound silently fails
Message-ID: <Pine.LNX.4.20.0002041513270.27409-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ha. that's a pun. it's not silent at all when you listen.

seriously, the dmasound driver advertises itself as little-endian capable
but doesn't provide the proper translators. so clients like openh323
switch the mode to little-endian (without any errors) and write
little-endian data and the result is a hissing noise!

i think this is all that is needed so the little-endian switch will fail
(i can't test this; i'm not at home). the proper fix will be to implement
the little-endian versions and i've started that but i'm getting mired in
the details -- this is terse code!

--- drivers/sound/dmasound.c.orig       Fri Feb  4 16:01:17 2000
+++ drivers/sound/dmasound.c    Fri Feb  4 16:02:26 2000
@@ -2211,12 +2211,12 @@
 #ifdef CONFIG_PPC
 static TRANS transAwacsNormal = {
        pmac_ct_law, pmac_ct_law, pmac_ct_s8, pmac_ct_u8,
-       pmac_ct_s16, pmac_ct_u16, pmac_ct_s16, pmac_ct_u16
+       pmac_ct_s16, pmac_ct_u16, NULL, NULL
 };

 static TRANS transAwacsExpand = {
        pmac_ctx_law, pmac_ctx_law, pmac_ctx_s8, pmac_ctx_u8,
-       pmac_ctx_s16, pmac_ctx_u16, pmac_ctx_s16, pmac_ctx_u16
+       pmac_ctx_s16, pmac_ctx_u16, NULL, NULL
 };
 #endif /* CONFIG_PPC */

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
