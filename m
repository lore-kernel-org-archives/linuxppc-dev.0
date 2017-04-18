Return-Path: <srs0=5uim=32=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6nKn19tdzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 00:18:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w6nKn0BJPz8sZm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 00:18:21 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w6nKm2KTrz9s0m
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2017 00:18:19 +1000 (AEST)
Date: Tue, 18 Apr 2017 16:18:16 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
Message-ID: <20170418161816.20e124f0@kitsune.suse.cz>
In-Reply-To: <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
 <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
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

On Mon, 17 Apr 2017 20:43:02 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> On Friday 14 April 2017 01:28 AM, Michal Such=C3=A1nek wrote:
> > On Thu, 13 Apr 2017 01:59:13 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
> > =20
> >> On Friday 07 April 2017 07:16 PM, Michael Ellerman wrote: =20
> >>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes: =20
> >>>> On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote: =20
> >>>>> My preference would be that the fadump kernel "just works". If
> >>>>> it's using too much memory then the fadump kernel should do
> >>>>> whatever it needs to use less memory, eg. shrinking nr_cpu_ids
> >>>>> etc. Do we actually know *why* the fadump kernel is running out
> >>>>> of memory? Obviously large numbers of CPUs is one of the main
> >>>>> drivers (lots of stacks required). But other than that what is
> >>>>> causing the memory pressure? I would like some data on that
> >>>>> before we proceed. =20
> >>>> Almost the same amount of memory in comparison with the memory
> >>>> required to boot the production kernel but that is unwarranted
> >>>> for fadump (dump capture) kernel. =20
> >>> That's not data! :)
> >>>
> >>> The dump kernel is booted with *much* less memory than the
> >>> production kernel (that's the whole issue!) and so it doesn't need
> >>> to create struct pages for all that memory, which means it should
> >>> need less memory.
> >>>
> >>> The vfs caches are also sized based on the available memory, so
> >>> they should also shrink in the dump kernel.
> >>>
> >>> I want some actual numbers on what's driving the memory usage.
> >>>
> >>> I tried some of these parameters to see how much memory they would
> >>> save: =20
> >> Hi Michael,
> >>
> >> Tried to get data to show parameters like numa=3Doff &
> >> cgroup_disable=3Dmemory matter too but parameter nr_cpus=3D1 is making
> >> parameters like numa=3Doff, cgroup_disable=3Dmemory insignificant.
> >> Also, these parameters not using much of early memory reservations
> >> is making quantification of memory saved for each of them that
> >> much more difficult. But I would still like to argue that passing
> >> additional parameters to fadump is better than enforcing nr_cpus=3D1
> >> in the kernel for:
> >>
> >>     a) With makedumpfile tool supporting multi-threading it would
> >> make sense to leave the choice of how many CPUs to have, to the
> >> user.
> >>
> >>     b) Parameters like udev.children-max=3D2 can help to reduce the
> >> number of parallel executed events bringing down the memory
> >> pressure on fadump kernel (when it is booted with more than one
> >> CPU).
> >>
> >>     c) Ease of maintainability is better (considering any new
> >> kernel features with some memory to save or stability to gain on
> >> disabling, possible platform supports) with append approach over
> >> enforcing these parameters
> >>        in the kernel.
> >>
> >>     d) It would give user the flexibility to disable unwanted
> >> kernel features in fadump kernel (numa=3Doff,
> >> cgroup_disable=3Dmemory). For every feature enabled in the
> >> production kernel, fadump kernel will have the choice to
> >>        opt out of it, provided there is such cmdline option. =20
> > Hello, =20
>=20
> Hi Michal,
>=20
> > can't the extra parameters be passed in the devicetree? =20
>=20
> Hmmm.. possible. Without change in f/w, this may not be guaranteed
> though.
>=20
> > The docs say that the kernel can tell it's a fadump crash kernel by
> > checking the devicetree ibm,dump-kernel property. Is there any
> > reason =20
>=20
> This node is exported by firmware
>=20
> > more (optional) properties cannot be added? =20
>=20
> Kernel change seems simple over f/w enhancement..

That certainly looks so when you are a kernel developer and can
implement the change yourself compared to convincing some firmware
developer that this feature makes sense.

On the other hand, the proposed kernel-only solution introduces
requirement that the maintainer does not like.

For the platform as a whole does it make more sense to add a hack to
the kernel or does it make sense to enhance the firmware to provide
more options for firmware-assisted dump?

Thanks

Michal
