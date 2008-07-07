Return-Path: <maxim@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3671DEBC4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:39:38 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m67FdC9O100730
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 15:39:12 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m67FdCBa1474700
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 16:39:12 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m67FdBpo013923
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 16:39:12 +0100
Date: Mon, 7 Jul 2008 17:39:23 +0200
From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: AZFS file system proposal
Message-ID: <20080707173923.17dc6c05@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <200807011659.33413.arnd@arndb.de>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
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

Thank you Arnd for your comments. I have changed my patch accordinly (I wil=
l send it in a few minutes).

> > Subject: azfs: initial submit of azfs, a non-buffered filesystem
>=20
> Please make the patch subject the actual subject of your email next time,
> and put the introductory text below the Signed-off-by: lines, separated
> by a "---" line. That will make the standard tools work without extra
> effort on my side. Also, please always Cc the person you want to merge
> the patch, in this case probably me.

Done.

> All other file systems are in separate directories, so it would be better
> to rename fs/azfs.c to fs/azfs/inode.c

Done.

> > +#define AZFS_SUPERBLOCK_FLAGS		MS_NOEXEC | \
> > +					MS_SYNCHRONOUS | \
> > +					MS_DIRSYNC | \
> > +					MS_ACTIVE
>=20
> Why MS_NOEXEC? What happens on a remount if the user does not specifies
> -o remount,exec?

I also don't see any reason of keeping MS_NOEXEC - have just removed it.

> > +static unsigned long
> > +azfs_block_find(struct inode *inode, enum azfs_direction direction,
> > +		unsigned long from, unsigned long *size)
> > +{
> > ...
> > +}
>=20
> This overloading of the return type to mean either a pointer or an offset
> on the block device is rather confusing. Why not just return the raw bloc=
k_id
> before the last +=3D and leave that part up to the caller?

Changed.

> > +		if (copy_to_user(target, (void*) pin, size)) {
> > +			rc =3D -EFAULT;
> > +			goto out;
> > +		}
>=20
> Question to the powerpc folks: is copy_to_user safe for an __iomem source?
> Should there be two copies (memcpy_fromio and copy_to_user) instead?

I leave this question open.

> > +	page_prot =3D pgprot_val(vma->vm_page_prot);
> > +	page_prot |=3D (_PAGE_NO_CACHE | _PAGE_RW);
> > +	page_prot &=3D ~_PAGE_GUARDED;
> > +	vma->vm_page_prot =3D __pgprot(page_prot);
>=20
> The pgprot modifications rely on powerpc specific flags, but the
> file system should not really need to be powerpc only.
>=20
> The flags we want are more or less the same as PAGE_AGP, because
> both are I/O mapped memory that needs to be uncached but should
> not be guarded, for performance reasons.
>=20
> Maybe we can introduce a new PAGE_IOMEM here that we can use
> in all places that need something like this. In spufs we need
> the same flags for the local store mappings.
>=20
> I wouldn't hold up merging the file system for this problem, but
> until it is solved, the Kconfig entry should probably have
> a "depends on PPC".

Done.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / met vriendelijke groeten / avec regards

    Maxim V. Shchetynin
    Linux Kernel Entwicklung
    IBM Deutschland Entwicklung GmbH
    Linux f=C3=BCr Cell, Abteilung 3250
    Sch=C3=B6naicher Stra=C3=9Fe 220
    71032 B=C3=B6blingen

Vorsitzender des Aufsichtsrats: Johann Weihen
Gesch=C3=A4ftsf=C3=BChrung: Herbert Kircher
Sitz der Gesellschaft: B=C3=B6blingen
Registriergericht: Amtsgericht Stuttgart, HRB 243294

Fahr nur so schnell wie dein Schutzengel fliegen kann!
