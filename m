Date: Wed, 2 Jul 2003 22:54:25 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: fsck_hfs on PPC???
Message-Id: <20030702225425.220d046a.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone been able to get Apple's fsck_hfs with Roman Zippel's
Linux patch to a usable state on PPC?

I was able to build it with the following additional patch:

--- dfalib/.orig/hfs_endian.h   2003-06-07 21:36:40.000000000 -0400
+++ dfalib/.mod/hfs_endian.h    2003-06-07 22:12:27.000000000 -0400
@@ -35,11 +35,17 @@
 /* BIG ENDIAN Macros */
 /*********************/
 #if BYTE_ORDER == BIG_ENDIAN
+typedef u_int16_t u_big_int16_t;
+typedef u_int32_t u_big_int32_t;
+typedef u_int64_t u_big_int64_t;

     /* HFS is always big endian, make swaps into no-ops */
     #define SWAP_BE16(__a) (__a)
     #define SWAP_BE32(__a) (__a)
     #define SWAP_BE64(__a) (__a)
+    #define SET_SWAP_BE16(__d, __a)            (__d) = (__a)
+    #define SET_SWAP_BE32(__d, __a)            (__d) = (__a)
+    #define SET_SWAP_BE64(__d, __a)            (__d) = (__a)

 /************************/
 /* LITTLE ENDIAN Macros */

But when I try and run it on an HFS+ partition:

gwiz# fsck_hfs /dev/hda9
/dev/rhda9: No such file or directory
Can't stat /dev/rhda9
/dev/hda9 is not a character device
CONTINUE? [yn] n

So I create a raw device with:

	raw /dev/raw/raw3 /dev/hda9

And then create a symbolic link:

	ln -s /dev/raw/raw3 rhda9

But:

gwiz# fsck_hfs /dev/rhda9
** /dev/rhda9

does not appear to do anything.  Using the "-f" force option
doesn't appear to have any effect either.

gwiz# fsck_hfs -f /dev/rhda9
** /dev/rhda9

It just immediately returns.

I'm guessing fsck_hfs has only been tested on PC Linux.
Has anyone gotten it to work on PPC or have any ideas
about further things to try or investigate.

					-Thanks

					-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
