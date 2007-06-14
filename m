Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7B97ADDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 08:58:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 17:50:03 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0307485D@ismail.innsys.innovsys.com>
In-Reply-To: <1181807671.30670.358.camel@gentoo-jocke.transmode.se>
References: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
	<1181807671.30670.358.camel@gentoo-jocke.transmode.se>
From: "Rune Torgersen" <runet@innovsys.com>
To: <joakim.tjernlund@transmode.se>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is what I had to do to get best-fit + not allocating too much:
(against 2.6.18)
--- linux-innsys/arch/ppc/lib/rheap.c	2006/10/10 22:54:41	175
+++ linux-innsys/arch/ppc/lib/rheap.c	2006/12/03 18:04:42	205
@@ -428,19 +428,22 @@
 {
 	struct list_head *l;
 	rh_block_t *blk;
-	rh_block_t *newblk;
+	rh_block_t *newblk1, *newblk2;
 	void *start;
-
+	int align_mask =3D alignment - 1;
+    int off;
+	unsigned long s, e, m, bs, be;
+   =20
 	/* Validate size, (must be power of two) */
 	if (size <=3D 0 || (alignment & (alignment - 1)) !=3D 0)
 		return ERR_PTR(-EINVAL);
=20
 	/* given alignment larger that default rheap alignment */
-	if (alignment > info->alignment)
-		size +=3D alignment - 1;
+	//if (alignment > info->alignment)
+	//	size +=3D alignment - 1;
=20
 	/* Align to configured alignment */
-	size =3D (size + (info->alignment - 1)) & ~(info->alignment - 1);
+	//size =3D (size + (info->alignment - 1)) & ~(info->alignment -
1);
=20
 	if (assure_empty(info, 1) < 0)
 		return ERR_PTR(-ENOMEM);
@@ -448,8 +451,18 @@
 	blk =3D NULL;
 	list_for_each(l, &info->free_list) {
 		blk =3D list_entry(l, rh_block_t, list);
-		if (size <=3D blk->size)
+	=09
+		if ((blk->size =3D=3D size) && (((int)blk->start &
align_mask) =3D=3D 0))
+		    break;
+	=09
+		if (((int)blk->start & align_mask) !=3D 0)
+			off =3D align_mask - ((int)blk->start &
align_mask) + 1;
+		else
+			off =3D 0;
+		   =20
+		if (blk->size - off >=3D size)
 			break;
+	=09
 		blk =3D NULL;
 	}
=20
@@ -468,25 +481,35 @@
 		return start;
 	}
=20
-	newblk =3D get_slot(info);
-	newblk->start =3D blk->start;
-	newblk->size =3D size;
-	newblk->owner =3D owner;
-
-	/* blk still in free list, with updated start, size */
-	blk->start =3D (int8_t *)blk->start + size;
-	blk->size -=3D size;
+	bs =3D (int)blk->start;
+	be =3D (int)blk->start + blk->size;
+	s =3D (int)blk->start + off;
+	e =3D s + size;
+=09
+	if (bs =3D=3D s || be =3D=3D e) {
+		if (bs =3D=3D s)
+			blk->start =3D (int8_t *)blk->start + size;
+		blk->size -=3D size;
=20
-	start =3D newblk->start;
+	} else {
+		/* The front free fragment */
+		blk->size =3D s - bs;
=20
-	attach_taken_block(info, newblk);
-=09
-	/* for larger alignment return fixed up pointer  */
-	/* this is no problem with the deallocator since */
-	/* we scan for pointers that lie in the blocks   */
-	if (alignment > info->alignment)
-		start =3D (void *)(((unsigned long)start + alignment - 1)
&
-				~(alignment - 1));
+		/* The back free fragment */
+		newblk2 =3D get_slot(info);
+		newblk2->start =3D (void *)e;
+		newblk2->size =3D be - e;
+
+		list_add(&newblk2->list, &blk->list);
+	}
+
+	newblk1 =3D get_slot(info);
+	newblk1->start =3D (void *)s;
+	newblk1->size =3D e - s;
+	newblk1->owner =3D owner;
+
+	start =3D newblk1->start;
+	attach_taken_block(info, newblk1);
=20
 	return start;
 }
