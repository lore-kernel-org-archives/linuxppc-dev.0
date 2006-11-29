Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C493567B9B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 05:05:30 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kATI5qDG015478
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 13:05:52 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kATI5R5R190360
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 13:05:27 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kATI5Rgq012607
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 13:05:27 -0500
Date: Wed, 29 Nov 2006 12:05:22 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64_defconfig to use AUTOFS_V4 not V3
Message-ID: <20061129180522.GM10879@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, nfonteno@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Paul,

Please apply. Although I have a general question: who is served
by the ppc64_defconfig these days? Any reason why its not more 
like powerpc_defcofig?  "make defconfig" uses uname -m to pick up
the defconfig, and my cell, rhel5 and sles10 boxes report ppc64 
not pseries for uname -m.  

--linas

Defconfig ppc64 kernels running under late-model distros
may hang in the automounter rc.d script, which seems to be
expecting autofs version 4. This patch uses the newer autofs.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/configs/ppc64_defconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc4-git3/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/configs/ppc64_defconfig	2006-11-01 16:15:06.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/configs/ppc64_defconfig	2006-11-29 11:53:48.000000000 -0600
@@ -1386,8 +1386,8 @@ CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
-# CONFIG_AUTOFS4_FS is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=m
 # CONFIG_FUSE_FS is not set
 
 #
