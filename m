Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFJ65g2dzF13M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:13:42 +1100 (AEDT)
Date: Tue, 20 Feb 2018 18:06:21 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call
 setup_rfi_flush() again
Message-ID: <20180220180621.11265945@kitsune.suse.cz>
In-Reply-To: <87lgforngp.fsf@concordia.ellerman.id.au>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
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

On Tue, 20 Feb 2018 20:59:18 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> writes:
>=20
> > Hi Michal and Michael,
> >
> > On 02/15/2018 05:13 AM, Michal Such=C3=A1nek wrote: =20
> >>> From: Michael Ellerman<mpe@ellerman.id.au>
> >>>
> >>> For PowerVM migration we want to be able to call setup_rfi_flush()
> >>> again after we've migrated the partition.
> >>>
> >>> To support that we need to check that we're not trying to
> >>> allocate the fallback flush area after memblock has gone away. If
> >>> so we just fail, we don't support migrating from a patched to an
> >>> unpatched machine. Or we do support it, but there will be no RFI
> >>> flush enabled on the destination.
> >>> =20
> >> This sounds bad to me. Either we support RFI flush or we don't.
> >>=20
> >> If we do the fallback area should be allocated at boot so it is
> >> always available. [snip] =20
> >
> > I think the problem with this is the size of the fallback area might
> > have to be different between the origin and destination systems,
> > say, a larger L1 data cache at the destination.
> >
> > In that case, the original size might not be enough to fully flush
> > the L1 data cache.
> >
> > Michael, is that the reason it is done that way?  I thought of that,
> > but don't know for sure. =20
>=20
> No, supporting different cache sizes is a good idea though :)
>=20
> I did it the way I did because otherwise we waste memory on every
> system on earth just to support a use case that we don't actually
> intend for anyone to ever use - ie. migrating from a patched machine
> to an unpatched machine.

If you have multiple hosts running some LPMs and want to update them
without shutting down the whole thing I suppose it might easily happen
that a machine (re)started on a patched host is migrated to unpatched
host.

>=20
> In fact without further checks we'd be allocating the fallback area on
> powernv machines which don't even support LPM.

They support suspend to disk which basically amounts to the same thing.
Downgrading the firmware while in sleep does not sound like a good
idea, though.

>=20
> So that just seemed a bit gross.
>=20
> I think I'm inclined to leave it the way it is, unless you feel
> strongly about it Michal?

I think it would be more user friendly to either support the fallback
method 100% or remove it and require patched firmware.=20

Thanks

Michal
