Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC3vq5LzGzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 23:29:11 +1000 (AEST)
Date: Tue, 25 Apr 2017 15:29:07 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
Message-ID: <20170425152907.7e99a3e0@kitsune.suse.cz>
In-Reply-To: <983a9293-e92a-64dc-6866-8bde74b20e1e@linux.vnet.ibm.com>
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
 <20170424160040.2659da38@kitsune.suse.cz>
 <983a9293-e92a-64dc-6866-8bde74b20e1e@linux.vnet.ibm.com>
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

On Tue, 25 Apr 2017 18:43:11 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> On Monday 24 April 2017 07:30 PM, Michal Such=C3=A1nek wrote:
> > On Mon, 24 Apr 2017 18:26:37 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> Hi Michal.
> >>

> >>>    =20
> >> I thinks there is a mixup here..
> >> I am no longer batting for handover area approach but
> >> "fadump_append=3D" approach (suggested by Michael Ellerman in this
> >> thread) where there is no need for a handover area but an
> >> additional kernel parameter fadump_append=3Dnuma=3Doff,nr_cpus=3D1..
> >> which is a comma separated list of parameters the user wants to
> >> enforce when fadump is active.
> >>
> >> I was trying to say that passing additional parameters with
> >> 'fadump_append=3D' kernel parameter is better over f/w changing the
> >> chosen/bootargs node. =20
> >
> > Ok, so a fadump specific parameter was just removed in
> > 25031865553e5a2bd9b6e0a5d044952cfa2925d8 and with this we get one
> > back. =20
>=20
> I think you mean commit c2afb7ce9d088696427018ba2135b898058507b8
> from linux-next. If so, yes.
>=20
> > If this is going to be added as an extra kernel parameter can't
> > this be passed to kdump kernel as well? Does kdump not have the same
> > restrictions?
> > =20
>=20
> kdump kernel is loaded with kexec and additional parameters can be=20
> passed to it at the
> time of loading. But fadump kernel boots like a regular kernel
> (through f/w & bootloader,
> resetting all the h/w) except that f/w guarantees to keep the memory=20
> intact. So, there is
> a need for a different approach to pass additional parameters in case
> of fadump..
>=20

I see, you can pass different commandline to the kdump kernel while
loading it with kexec but fadump kernel is booted same as normal kernel
until it looks at the devicetree so the extra arguments have to be
passed always and only appended to the commandline in the fadump case.

This sounds reasonable.

Thanks

Michal
