Date: Thu, 22 Jun 2000 15:58:26 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: Dan Malek <dan@netx4.com>
cc: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <395260E5.C7592DE3@embeddededge.com>
Message-ID: <Pine.LNX.4.21.0006221552290.11967-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> So, this should be a pretty obvious boundary condition bug in
> drivers/char/mem.c or one of the Linux MM functions.  You want to
> learn about MMUs?  Go check some of those files for inspiration......

Already. This should be The Right Thing. Anybody wants to send it to
Linus?

len is not 0, it is clear from the code above. (off + len) points to the
byte that is after the allocated area, (off + len - 1) points to the
last byte. The last byte should not be on the "other end of memory"

=======================
diff -u -r1.1.1.1 mmap.c
--- mm/mmap.c	2000/01/03 20:11:04	1.1.1.1
+++ mm/mmap.c	2000/06/22 19:52:51
@@ -186,7 +186,7 @@
 		return -EINVAL;

 	/* offset overflow? */
-	if (off + len < off)
+	if (off + len - 1 < off)
 		return -EINVAL;

 	/* Too many mappings? */
=======================

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
