Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcFW1vv2zF0p5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 23:55:26 +1100 (AEDT)
Date: Tue, 6 Mar 2018 13:55:22 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call
 setup_rfi_flush() again
Message-ID: <20180306135522.040707de@kitsune.suse.cz>
In-Reply-To: <876069flhq.fsf@concordia.ellerman.id.au>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
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

On Tue, 06 Mar 2018 23:15:45 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> writes:
>=20
> > Hi Michael, Michal,
> >
> > I got back from vacation. Checking this one. =20
>=20
> Yeah it got stuck in a rut.
>=20
> > On 02/20/2018 02:06 PM, Michal Such=C3=A1nek wrote: =20
> >>> I did it the way I did because otherwise we waste memory on every
> >>> system on earth just to support a use case that we don't actually
> >>> intend for anyone to ever use - ie. migrating from a patched
> >>> machine to an unpatched machine. =20
> >
> > If this thread eventually closes in 'ok, so that memory has to be
> > reserved/wasted anyway', that can be done only in pseries, right?
> >
> > It seems not so much memory for this particular platform/hardware. =20
>=20
> Yes and no. We certainly have pseries machines with 10s of TBs of
> memory, but pseries is also used when running on KVM/Openstack where
> some people are interested in running small VMs - so as usual it's not
> so simple :)
>=20
> But it's not *that* much memory so we should probably stop worrying
> about it and just always allocate the fallback on pseries.
>=20
> I *think* the patch below is all we need, as well as some tweaking of
> patch 2, are you able to test and repost?
>=20
> cheers
>=20
> diff --git a/arch/powerpc/platforms/pseries/setup.c
> b/arch/powerpc/platforms/pseries/setup.c index
> 1a527625acf7..9116824bd7c5 100644 ---
> a/arch/powerpc/platforms/pseries/setup.c +++
> b/arch/powerpc/platforms/pseries/setup.c @@ -468,26 +468,18 @@ static
> void pseries_setup_rfi_flush(void)=20
>  	/* Enable by default */
>  	enable =3D true;
> +	types =3D L1D_FLUSH_FALLBACK;
> =20
>  	rc =3D plpar_get_cpu_characteristics(&result);
>  	if (rc =3D=3D H_SUCCESS) {
> -		types =3D L1D_FLUSH_NONE;
> -
>  		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
>  			types |=3D L1D_FLUSH_MTTRIG;
>  		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
>  			types |=3D L1D_FLUSH_ORI;
> =20
> -		/* Use fallback if nothing set in hcall */
> -		if (types =3D=3D L1D_FLUSH_NONE)
> -			types =3D L1D_FLUSH_FALLBACK;
> -
>  		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
> || (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
>  			enable =3D false;
> -	} else {
> -		/* Default to fallback if case hcall is not
> available */
> -		types =3D L1D_FLUSH_FALLBACK;
>  	}
> =20
>  	setup_rfi_flush(types, enable);
>=20

Enabling the fallback flush always looks a bit dodgy but
do_rfi_flush_fixups will overwrite the jump so long any other fixup is
enabled.

Reviewed-by: Michal Such=C3=A1nek <msuchanek@suse.de>

Thanks

Michal
