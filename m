To: "linuxppc" <linuxppc-dev@lists.linuxppc.org>
Subject: libXrender bug crashes OpenOffice
From: jason@openinformatics.com (Jason E. Stewart)
Date: 27 Nov 2001 15:37:38 -0700
In-Reply-To: <20011127221834.23360@smtp.wanadoo.fr>
Message-ID: <87u1vfkfgt.fsf_-_@openinformatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey All,

While running Kevin Hendrix's build of OpenOffice I kept getting
Abort's for no reason. We've finally limited down to the Xrender
lib. When it's not on my system, OpenOffice runs fine, with it I get
crashes.

Kevin found a bug in the library and fixed it and OpenOffice runs fine
on his system with libXrender installed. I downloaded the latest xlibs
source from sid and checked, but his patch hasn't yet been
included.

Will it be included soon?

Thanks,
jas.

--- xc/lib/Xrender/Xrender.c.prev	Wed Oct 10 22:38:25 2001
+++ xc/lib/Xrender/Xrender.c	Wed Oct 10 22:39:09 2001
@@ -193,7 +193,7 @@
 	       rep.numVisuals * sizeof (xPictVisual));
     xData = (void *) Xmalloc (rlength);

-    if (!xri || !xFormat)
+    if (!xri || !xData)
     {
 	if (xri) Xfree (xri);
 	if (xData) Xfree (xData);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
