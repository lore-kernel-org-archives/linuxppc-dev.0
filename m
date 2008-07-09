Return-Path: <maxim@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 487ADDDFF3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 19:14:41 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m699DlrM131938
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 09:13:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m699DlkT2605200
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:13:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m699DkJ2014625
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:13:46 +0200
Date: Wed, 9 Jul 2008 11:14:02 +0200
From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
To: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: AZFS file system proposal
Message-ID: <20080709111402.5af92580@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <1215593918.8970.363.camel@pasglop>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<1215593918.8970.363.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Wed, 09 Jul 2008 18:58:38 +1000
schrieb Benjamin Herrenschmidt <benh@kernel.crashing.org>:

> On Tue, 2008-07-01 at 16:59 +0200, Arnd Bergmann wrote:
> > I wouldn't hold up merging the file system for this problem, but
> > until it is solved, the Kconfig entry should probably have
> > a "depends on PPC".
>=20
> Better, use an ifdef for powerpc flags, and #else to pgprot_noncached.

Thank you Ben. Then, how about this?

azfs_mmap(struct file *file, struct vm_area_struct *vma)
{
...
...
...
#ifdef CONFIG_PPC
	pgprot_t page_prot;
#endif
...
...
...
#ifdef CONFIG_PPC
	page_prot =3D pgprot_val(vma->vm_page_prot);
	page_prot |=3D (_PAGE_NO_CACHE | _PAGE_RW);
	page_prot &=3D ~_PAGE_GUARDED;
	vma->vm_page_prot =3D __pgprot(page_prot);
#else
	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
#endif
...
...
...

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / met vriendelijke groeten / avec regards

    Maxim V. Shchetynin
    Linux Kernel Entwicklung
    IBM Deutschland Research & Development GmbH
    Linux f=C3=BCr Cell, Abteilung 3250
    Sch=C3=B6naicher Stra=C3=9Fe 220
    71032 B=C3=B6blingen

Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=C3=A4ftsf=C3=BChrung: Herbert Kircher
Sitz der Gesellschaft: B=C3=B6blingen
Registriergericht: Amtsgericht Stuttgart, HRB 243294

Fahr nur so schnell wie dein Schutzengel fliegen kann!
