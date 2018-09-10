Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4284RK2YBSzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 20:44:12 +1000 (AEST)
Date: Mon, 10 Sep 2018 12:44:08 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
Message-ID: <20180910124408.05c2f3d2@naga.suse.cz>
In-Reply-To: <3023d79c-cc38-037a-3617-832fed397a3d@c-s.fr>
References: <20180910054405.32422-1-mikey@neuling.org>
 <20180910115457.60366160@naga.suse.cz>
 <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
 <3023d79c-cc38-037a-3617-832fed397a3d@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Sep 2018 12:16:35 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 10/09/2018 =C3=A0 12:05, Michael Neuling a =C3=A9crit=C2=A0:
> >  =20
> >>> +	/* Make sure we aren't patching a freed init section */
> >>> +	if (in_init_section(patch_addr) && init_freed())
> >>> +		return 0;
> >>> + =20
> >>
> >> Do we even need the init_freed() check? =20
> >=20
> > Maybe not.  If userspace isn't up, then maybe it's ok to skip. =20
>=20
> Euh ... Do you mean you'll skip all patches into init functions ?
> But code patching is not only for meltdown/spectrum workarounds, some
> of the patchings might be needed for the init functions themselves.

Some stuff like cpu feature tests have an early variant that does not
need patching but maybe not everything has.

and some stuff like lwsync might be also expanded from some macros or
inlines and may be needed in the init code. It might be questionable to
rely on it getting patched, though. Hard to tell without seeing what is
actually patched where.

Thanks

Michal
