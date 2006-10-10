Return-Path: <Masato.Noguchi@jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for read/write
	oncntl
Date: Tue, 10 Oct 2006 15:49:08 +0900
Message-ID: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3E7@jptkyxms38.jp.sony.com>
From: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops,
I'm so sorry. I mistake to send wrong patch.
Correct version is below:

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>

---

Index:
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---
linux-2.6.18-arnd-20061004.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
@@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode

 static struct file_operations spufs_cntl_fops =3D {
 	.open =3D spufs_cntl_open,
+	.release =3D simple_attr_close,
 	.read =3D simple_attr_read,
 	.write =3D simple_attr_write,
 	.mmap =3D spufs_cntl_mmap,


> -----Original Message-----
> From: Noguchi, Masato
> Sent: Tuesday, October 10, 2006 3:00 PM
> To: 'Arnd Bergmann'
> Cc: Paul Mackerras; Arnd Bergmann; linuxppc-dev@ozlabs.org;
> cbe-oss-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: RE: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for
read/write
> oncntl
>=20
> After applying these patches, it seems the kernel leaks memory.
> No doubt you forget to call simple_attr_close on "[PATCH 09/14]
> spufs: add support for read/write oncntl".
>=20
> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
>=20
> ---
>=20
> Index:
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
>
linux-2.6.18-arnd-20061004.orig/arch/powerpc/platforms/cell/spufs/file.c
> +++
linux-2.6.18-arnd-20061004/arch/powerpc/platforms/cell/spufs/file.c
> @@ -246,6 +246,7 @@ static int spufs_cntl_open(struct inode
>=20
>  static struct file_operations spufs_cntl_fops =3D {
>  	.open =3D spufs_cntl_open,
> +	.close =3D simple_attr_close,
>  	.read =3D simple_attr_read,
>  	.write =3D simple_attr_write,
>  	.mmap =3D spufs_cntl_mmap,
>=20
