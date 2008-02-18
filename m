Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D001ADDECD
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 21:00:19 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1IA0ESA354964
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 10:00:14 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1IA0E0Y2232324
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 11:00:14 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1IA0DAd020545
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 10:00:14 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
Date: Mon, 18 Feb 2008 11:00:11 +0100
References: <200802111724.12416.ossthema@de.ibm.com>
	<OF58A8E0B3.B5CC265E-ONC12573F0.00496E2B-C12573F0.0049850F@de.ibm.com>
	<1203094538.8142.23.camel@nimitz.home.sr71.net>
In-Reply-To: <1203094538.8142.23.camel@nimitz.home.sr71.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802181100.12995.ossthema@de.ibm.com>
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, Greg KH <greg@kroah.com>,
	Dave Hansen <haveblue@us.ibm.com>, apw <apw@uk.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	netdev <netdev@vger.kernel.org>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

switching to proper mail client...

Dave Hansen <haveblue@us.ibm.com> wrote on 15.02.2008 17:55:38:

> I've been thinking about that, and I don't think you really *need* to
> keep a comprehensive map like that.=20
>=20
> When the memory is in a particular configuration (range of memory
> present along with unique set of holes) you get a unique ehea_bmap
> configuration. =A0That layout is completely predictable.
>=20
> So, if at any time you want to figure out what the ehea_bmap address for
> a particular *Linux* virtual address is, you just need to pretend that
> you're creating the entire ehea_bmap, use the same algorithm and figure
> out host you would have placed things, and use that result.
>=20
> Now, that's going to be a slow, crappy linear search (but maybe not as
> slow as recreating the silly thing). =A0So, you might eventually run into
> some scalability problems with a lot of packets going around. =A0But, I'd
> be curious if you do in practice.

Up to 14 addresses translation per packet (sg_list) might be required on=20
the transmit side. On receive side it is only 1. Most packets require only=
=20
very few translations (1 or sometimes more) =A0translations. However,=20
with more then 700.000 packets per second this approach does not seem=20
reasonable from performance perspective when memory is fragmented as you
described.

>=20
> The other idea is that you create a mapping that is precisely 1:1 with
> kernel memory. =A0Let's say you have two sections present, 0 and 100. =A0=
You
> have a high_section_index of 100, and you vmalloc() a 100 entry array.
>=20
> You need to create a *CONTIGUOUS* ehea map? =A0Create one like this:
>=20
> EHEA_VADDR->Linux Section
> 0->0
> 1->0
> 2->0
> 3->0
> ...
> 100->100
>=20
> It's contiguous. =A0Each area points to a valid Linux memory address.
> It's also discernable in O(1) to what EHEA address a given Linux address
> is mapped. =A0You just have a couple of duplicate entries.=20

This has a serious issues with constraint I mentions in the previous mail:=
=20

"- MRs can have a maximum size of the memory available under linux"

The requirement is not met that the memory region must not be=20
larger then the available memory for that partition. The "create MR"=20
H_CALL will fails (we tried this and discussed with FW development)


Regards,
Jan-Bernd & Christoph
