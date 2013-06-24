Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C11F2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:05:44 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 00:59:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B50302CE8044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:05:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OF5SGg3604874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:05:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OF5bKv031410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:05:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Correct build warnings with CONFIG_TRANSPARENT_HUGEPAGE
 disabled
In-Reply-To: <51C8594B.1080701@linux.vnet.ibm.com>
References: <51C8594B.1080701@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 20:35:35 +0530
Message-ID: <87hagnzgzk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> Building with CONFIG_TRANSPARENT_HUGEPAGE disabled causes the following
> build wearnings;
>
> powerpc/arch/powerpc/include/asm/mmu-hash64.h: In function =E2=80=98__has=
h_page_thp=E2=80=99:
> powerpc/arch/powerpc/include/asm/mmu-hash64.h:354: warning: no return sta=
tement in function returning non-void
>
> This patch adds a return -1 to the static inline for __hash_page_thp()
> to correct the warnings.
>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Wondering why i am not finding this

[root@llmp24l02 thp]# make arch/powerpc/mm/hash_utils_64.o
....
.....
  CC      arch/powerpc/mm/hash_utils_64.o
[root@llmp24l02 thp]# grep TRANSPARENT_HUGEPAGE .config
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE is not set
[root@llmp24l02 thp]#=20
[root@llmp24l02 thp]# gcc --version
gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8)
Copyright (C) 2012 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


> ---
>  arch/powerpc/include/asm/mmu-hash64.h |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: powerpc/arch/powerpc/include/asm/mmu-hash64.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.orig/arch/powerpc/include/asm/mmu-hash64.h	2013-06-24 07:54:0=
8.000000000 -0500
> +++ powerpc/arch/powerpc/include/asm/mmu-hash64.h	2013-06-24 08:07:56.000=
000000 -0500
> @@ -351,6 +351,7 @@
>  				  int ssize, unsigned int psize)
>  {
>  	BUG();
> +	return -1;
>  }
>  #endif
>  extern void hash_failure_debug(unsigned long ea, unsigned long access,
