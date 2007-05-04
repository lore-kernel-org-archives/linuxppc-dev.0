Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C3E7DDF54
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 03:27:58 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l44HRrdn059564
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 17:27:53 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l44HRrK72584582
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:53 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l44HRrCb000633
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:53 +0100
Received: from [9.152.237.39] (dyn-9-152-237-39.boeblingen.de.ibm.com
	[9.152.237.39])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l44HRqXl000618
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:53 +0100
Message-ID: <463B6D16.9050400@linux.vnet.ibm.com>
Date: Fri, 04 May 2007 19:27:50 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PATCH: free mm if spufs_fill_dir() failed
Content-Type: multipart/mixed; boundary="------------060504000700000901010909"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060504000700000901010909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit




--------------060504000700000901010909
Content-Type: text/plain;
 name="spufs-free_mm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spufs-free_mm.diff"


In case spufs_fill_dir() fails only put_spu_context() 
gets called for cleanup and the acquired mm_struct never gets freed.

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Index: ps3-linux/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- ps3-linux.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ ps3-linux/arch/powerpc/platforms/cell/spufs/inode.c
@@ -277,6 +277,7 @@ spufs_mkdir(struct inode *dir, struct de
 	goto out;
 
 out_free_ctx:
+	spu_forget(ctx);
 	put_spu_context(ctx);
 out_iput:
 	iput(inode);


--------------060504000700000901010909--
