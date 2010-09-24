Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E1A00B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 14:55:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] powerpc: Fix invalid page flags in create TLB CAM pathfor
	PTE_64BIT
Date: Fri, 24 Sep 2010 06:54:51 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C173@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <20100923153347.4b517105@udp111988uds.am.freescale.net>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
	<20100923153347.4b517105@udp111988uds.am.freescale.net>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Gortmaker, Paul" <Paul.Gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
zlabs.org] On Behalf Of Scott Wood
> Sent: Friday, September 24, 2010 4:34 AM
> To: Gortmaker, Paul
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc: Fix invalid page flags in=20
> create TLB CAM pathfor PTE_64BIT
>=20
> On Thu, 23 Sep 2010 16:10:15 -0400
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>=20
> > So the possibility exists to wrongly assign the user=20
> MAS3_U<RWX> bits=20
> > to kernel (PAGE_KERNEL_X) address space via the following=20
> code fragment:
> >=20
> >         if (flags & _PAGE_USER) {
> >            TLBCAM[index].MAS3 |=3D MAS3_UX | MAS3_UR;
> >            TLBCAM[index].MAS3 |=3D ((flags & _PAGE_RW) ? MAS3_UW : =
0);
> >         }
> >=20
> > Here is a dump of the TLB info from Simics with the above=20
> code present:
> > ------
> > L2 TLB1
> >                                             GT             =20
>      SSS UUU V I
> >  Row  Logical           Physical            SS TLPID  TID =20
> WIMGE XWR XWR F P   V
> > ----- ----------------- ------------------- -- ----- -----=20
> ----- --- --- - -   -
> >   0   c0000000-cfffffff 000000000-00fffffff 00     0     0 =20
>  M   XWR XWR 0 1   1
> >   1   d0000000-dfffffff 010000000-01fffffff 00     0     0 =20
>  M   XWR XWR 0 1   1
> >   2   e0000000-efffffff 020000000-02fffffff 00     0     0 =20
>  M   XWR XWR 0 1   1
> >=20
> > Actually this conditional code was only used for two legacy=20
> functions:
> >=20
> >   1: support KGDB to set break point.
> >      KGDB already dropped this; now uses its core write to=20
> set break point.
> >=20
> >   2: io_block_mapping() to create TLB in segmentation size=20
> (not PAGE_SIZE)
> >      for device IO space.
> >      This use case is also removed from the latest PowerPC kernel.
>=20
> io_block_mapping() went away, but the feature itself is still=20
> useful and might come back with something like this:
>=20
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg3
3851.html
>=20
> ...though I'm not sure why such mappings would ever have user access.
>=20
> This could end up being used for large user pages by=20
> something like hugetlbfs or KVM, though.  I don't think we=20
> want to make large user pages fail, especailly if it just=20

Understand.=20

Actually the following is my original modification.=20
=3D=3D=3D=3D=3D=3D
+#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
+	/* On there _PAGE_BAP_UR is always integrated into flag,
_PAGE_KERNEL_RWX=20
+	 * and _PAGE_USER here. So we have to only check _PAGE_BAP_UR as
the condition.
+ 	 */
+	if (flags & _PAGE_BAP_UR) {
+#else
	if (flags & _PAGE_USER) {
+#endif

But I find there is no any usage for this, except for the above #1> KGDB
and #2 io_block_mapping(). So I think it's possible to remove this
completely :)

> happens with the 32-bit page table format (which i may not=20
> what the person adding such a feature tests with).
>=20
> I don't see a generic accessor that can test PTE flags for=20
> user access -- in the absence of one, I guess we need an=20
> ifdef here.  Or at least put in a comment so anyone who adds=20
> a userspace use knows they need to fix it.

I already notice Ben's advice and looks fine to us.

Tiejun

>=20
> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
