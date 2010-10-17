Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: 64K PAGE_SIZE and arch/powerpc/kernel/vdso.c
In-reply-to: <1287216239.9909.234.camel@haakon2.linux-iscsi.org>
References: <1287216239.9909.234.camel@haakon2.linux-iscsi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Oct 2010 10:44:12 +1100
Message-ID: <7015.1287359052@neuling.org>
Cc: Brian King <brking@linux.vnet.ibm.com>, Tim Abbott <tabbott@ksplice.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Greetings Linux-ppc64 folks,
>=20
> While trying to compile v2.6.36-rc8 with PAGE_SIZE=3D65536 I run into the
> following compile failure w/ strict checking on a RHEL5.4 / gcc (GCC)
> 4.1.2 20080704 (Red Hat 4.1.2-46) system:
>=20
> cc1: warnings being treated as errors
> arch/powerpc/kernel/vdso.c:81: warning: alignment of =E2=80=98vdso_data_s=
tore=E2=80=99
> is greater than maximum object file alignment.  Using 32768
>   CC      arch/powerpc/sysdev/msi_bitmap.o
> make[1]: *** [arch/powerpc/kernel/vdso.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>=20
> Any ideas folks..?

It seems this broke it:

commit abe1ee3a221d53778c3e58747bbec6e518e5471b
Author: Tim Abbott <tabbott@ksplice.com>
Date:   Sun Sep 20 18:14:15 2009 -0400

    Use macros for .data.page_aligned section.
=20=20=20=20
    This patch changes the remaining direct references to
    .data.page_aligned in C and assembly code to use the macros in
    include/linux/linkage.h.

Backing out just that part of the change (see below) fixes it.

FYI the error only occurs on gcc 4.1 and 4.2.  4.3 and greater is fine.=20=
=20

Mikey

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 13002fe..c140fce 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -78,7 +78,7 @@ static int vdso_ready;
 static union {
 	struct vdso_data	data;
 	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+} vdso_data_store __attribute__((__section__(".data.page_aligned")));
 struct vdso_data *vdso_data =3D &vdso_data_store.data;
=20
 /* Format of the patch table */
