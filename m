Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 881E81A023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:26:44 +1000 (EST)
Message-ID: <1411082804.12154.26.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 01/15] powerpc/cell: Move spu_handle_mm_fault() out of
 cell platform
From: Michael Neuling <mikey@neuling.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 19 Sep 2014 09:26:44 +1000
In-Reply-To: <541AAD26.1040607@ozlabs.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-2-git-send-email-mikey@neuling.org>
 <541AAD26.1040607@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > @@ -58,12 +56,12 @@ int spu_handle_mm_fault(struct mm_struct *mm, unsig=
ned long ea,
> >  			goto out_unlock;
> >  	}
> > =20
> > -	is_write =3D dsisr & MFC_DSISR_ACCESS_PUT;
> > +	is_write =3D dsisr & DSISR_ISSTORE;
> >  	if (is_write) {
> >  		if (!(vma->vm_flags & VM_WRITE))
> >  			goto out_unlock;
> >  	} else {
> > -		if (dsisr & MFC_DSISR_ACCESS_DENIED)
> > +		if (dsisr & DSISR_PROTFAULT)
> >  			goto out_unlock;
> >  		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
> >  			goto out_unlock;
>=20
> Consistent DSISR encodings? woot! :)

Yep!

arch/powerpc/include/asm/spu.h:605:#define MFC_DSISR_ACCESS_PUT         (1 =
<< 25)
arch/powerpc/include/asm/reg.h:255:#define   DSISR_ISSTORE              0x0=
2000000      /* access was a store */

and=20

arch/powerpc/include/asm/spu.h:603:#define MFC_DSISR_ACCESS_DENIED         =
     (1 << 27)
arch/powerpc/include/asm/reg.h:254:#define   DSISR_PROTFAULT    0x08000000 =
     /* protection fault */

Mikey
