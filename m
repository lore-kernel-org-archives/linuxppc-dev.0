Return-Path: <MGalassi@c-cor.com>
Received: from ns1.c-cor.com (ns1.c-cor.com [12.17.0.130])
	by ozlabs.org (Postfix) with ESMTP id 329AFDE036
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 13:54:58 +1100 (EST)
Received: from scpbridge1.NTSCD.C-COR.com (sc.c-cor.com [192.168.128.20])
	by ns1.c-cor.com (8.12.10/8.12.10) with ESMTP id l0V2srLc005276
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 21:54:53 -0500 (EST)
Received: from penguin.ncube.com (localhost [127.0.0.1])
	by penguin.ncube.com (8.13.8/8.13.8) with ESMTP id l0V2sh3L053534
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 18:54:43 -0800 (PST)
	(envelope-from nerd@penguin.ncube.com)
Message-Id: <200701310254.l0V2sh3L053534@penguin.ncube.com>
To: linuxppc-embedded@ozlabs.org
From: Michael Galassi <mgalassi@c-cor.com>
Subject: mmap bug (all archs) w/ fix
Date: Tue, 30 Jan 2007 18:54:43 -0800
Sender: mgalassi@c-cor.com
Reply-To: Michael Galassi <mgalassi@c-cor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When we need to update flash on our system we use a utility which opens
/dev/mem, mmaps the region of physical memory which contains flash (top
128meg), and then does all the ugly magic to erase/write/verify.  As we
were implementing this we discovered that it is not possible to mmap a
chunk of physical addresses which ends at the top of the proc's space
(where we (and everyone else on this list) have our boot loader).  I
finally got around to looking at why this might be and found that
whoever implemented mmap got lazy.  The diff which follows is against a
fully patched MontaVista pro 4.0.1 kernel, I just checked and the exact
same fix is applicable to 2.6.20-rc6.

Index: mmap.c
===================================================================
RCS file: /CVSR1/SuperQAM/SW/src/sys/mvl401/mm/mmap.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -w -u -r1.1 -r1.2
--- mmap.c      9 Aug 2006 02:26:09 -0000       1.1
+++ mmap.c      30 Jan 2007 23:42:53 -0000      1.2
@@ -803,7 +803,8 @@
                return -ENOMEM;

        /* offset overflow? */
-       if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
+       if ((pgoff + (len >> PAGE_SHIFT)) < pgoff &&
+           (pgoff + (len >> PAGE_SHIFT)) != 0)
                return -EOVERFLOW;

        /* Too many mappings? */

This clearly applies to all architectures and all versions (at least 2.4
onward), could someone point me at some document which describes how to
submit patches to "the right place" please?  I really do not want to
support any fixes myself so getting fixes to obvious bugs merged into
the mailine code would be a good thing (tm).

Thanks,

-michael
