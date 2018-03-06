Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwXqh6PLBzF0Vf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 21:21:18 +1100 (AEDT)
Date: Tue, 6 Mar 2018 11:21:12 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call
 setup_rfi_flush() again
Message-ID: <20180306112112.6cf9694b@naga.suse.cz>
In-Reply-To: <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
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

On Mon, 5 Mar 2018 19:46:12 -0300
Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> Hi Michael, Michal,
>=20
> I got back from vacation. Checking this one.
>=20
> On 02/20/2018 02:06 PM, Michal Such=C3=A1nek wrote:
> >> I did it the way I did because otherwise we waste memory on every
> >> system on earth just to support a use case that we don't actually
> >> intend for anyone to ever use - ie. migrating from a patched
> >> machine to an unpatched machine. =20
>=20
> If this thread eventually closes in 'ok, so that memory has to be
> reserved/wasted anyway', that can be done only in pseries, right?
>=20
> It seems not so much memory for this particular platform/hardware.

Yes, that is what I think too.

>=20
> > If you have multiple hosts running some LPMs and want to update them
> > without shutting down the whole thing I suppose it might easily
> > happen that a machine (re)started on a patched host is migrated to
> > unpatched host. =20
>=20
> Right, but that should be temporary, I think -- after updating some of
> the hosts, the LPAR(s) can be migrated back to one of them, where the
> fallback flush is not required anymore.

Temporary, yes. But for how long?

Also is it possible to migrate between P8 and P9 in P8 compat mode?

AFAIK on P9 fallback mode is used exclusively so far.

>=20
> >> I think I'm inclined to leave it the way it is, unless you feel
> >> strongly about it Michal? =20
>=20
> > I think it would be more user friendly to either support the
> > fallback method 100% or remove it and require patched firmware. =20
>=20
> I beg to disagree.  Since the matter is a security issue, the option
> of still have some sort of fix that works on unpatched firmware does
> look good and friendly to users (rather than require 'you _must_ get
> the firmware update') IMHO.

Specifically because this is a security issue user friendly is that
user can tell clearly if the fix is applied or not. If the kernel tells
the user the fix is applied and later it tells "sorry, could not
allocate more memory. disabling fix" this is really unfriendly.=20

Thanks

Michal
