Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBSfh5GcczDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 00:00:44 +1000 (AEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D0EFFABEC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 14:00:40 +0000 (UTC)
Date: Mon, 24 Apr 2017 16:00:40 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
Message-ID: <20170424160040.2659da38@kitsune.suse.cz>
In-Reply-To: <ba8d55c0-0dd0-d72b-1fbe-5bb6bf79749b@linux.vnet.ibm.com>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
 <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
 <20170418161816.20e124f0@kitsune.suse.cz>
 <878tmx6nbw.fsf@concordia.ellerman.id.au>
 <20170419160826.617d173f@kitsune.suse.cz>
 <4dcf00a6-9293-a261-9ebe-68c80ce49a83@linux.vnet.ibm.com>
 <20170424122459.31761099@kitsune.suse.cz>
 <ba8d55c0-0dd0-d72b-1fbe-5bb6bf79749b@linux.vnet.ibm.com>
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

On Mon, 24 Apr 2017 18:26:37 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> Hi Michal.
>=20
> On Monday 24 April 2017 03:54 PM, Michal Such=C3=A1nek wrote:
> > On Fri, 21 Apr 2017 00:19:55 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> On Wednesday 19 April 2017 07:38 PM, Michal Such=C3=A1nek wrote: =20
> >>> On Wed, 19 Apr 2017 14:19:47 +1000
> >>> Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>>    =20

> >> With the fadump_append=3D approach I posted in this response thread,
> >> additional parameters are enforced when fadump is active. If f/w
> >> supports appending additional parameters, it has to update
> >> chosen/bootargs whenever fadump is active. Almost the same thing
> >> except the dirty job is now done by f/w? Hence I thought
> >> fadump_append=3D kernel parameter approach is simple and lesser of
> >> the two evils? Am i missing something here..
> >> =20
> > The firmware already has to set the parameter by which the kernel
> > can tell it is a fadump kernel. Hence it already modifies the
> > devicetree for fadump and you have to rely on it to do so. =20
>=20
> Right, devicetree is modified to include new 'ibm,kernel-dump' rtas
> node informing that fadump is active.
>=20
> > The handover area which stores the additional parameters is
> > reserved by the running kernel so now you also have to rely on the
> > running kernel, the running kernel and fadum kernel having the same
> > idea about the location of handover area, the crashing kernel not
> > randomly overwriting the handover area, etc.
> >
> > In short it is additional potential for trouble which can be
> > avoided.
> >
> > I don't know if the firmware does protect the fadump reserved area
> > and devicetree from being randomly overwritten by the crashing
> > kernel but it is in the position to do so if desired. The handover
> > area is controlled by the crashing kernel and cannot have this
> > guarantee.
> >
> > =20
>=20
> I thinks there is a mixup here..
> I am no longer batting for handover area approach but
> "fadump_append=3D" approach (suggested by Michael Ellerman in this
> thread) where there is no need for a handover area but an additional
> kernel parameter fadump_append=3Dnuma=3Doff,nr_cpus=3D1.. which is a comma
> separated list of parameters the user wants to enforce when fadump is
> active.
>=20
> I was trying to say that passing additional parameters with
> 'fadump_append=3D' kernel parameter is better over f/w changing the
> chosen/bootargs node.


Ok, so a fadump specific parameter was just removed in
25031865553e5a2bd9b6e0a5d044952cfa2925d8 and with this we get one back.
If this is going to be added as an extra kernel parameter can't this be
passed to kdump kernel as well? Does kdump not have the same
restrictions?

Thanks

Michal
