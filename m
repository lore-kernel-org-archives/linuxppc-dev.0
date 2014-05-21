Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DB841A0814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:20:44 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1400631544.3986.151.camel@pasglop>
Date: Wed, 21 May 2014 08:20:41 +0200
Message-Id: <0A9AFF1F-B755-4223-9F90-B08E92F10951@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <537B4740.6090806@suse.de> <20140520124504.GB28441@shangw>
 <537B5D85.3010305@suse.de> <1400631544.3986.151.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 21.05.2014 um 02:19 schrieb Benjamin Herrenschmidt <benh@kernel.crashin=
g.org>:
>=20
>> On Tue, 2014-05-20 at 15:49 +0200, Alexander Graf wrote:
>> So how about we just implement this whole thing properly as irqfd?=20
>> Whether QEMU can actually do anything with the interrupt is a different=20=

>> question - we can leave it be for now. But we could model all the code=20=

>> with the assumption that it should either handle the error itself or=20
>> trigger and irqfd write.
>=20
> I don't object to the idea... however this smells of Deja Vu...
>=20
> You often tend to want to turn something submitted that fills a specific
> gap and implements a specific spec/function into some kind of idealized
> grand design :-) And that means nothing gets upstream for weeks or monthes=

> as we churn and churn...
>=20
> Sometimes it's probably worth it. Here I would argue against it and would
> advocate for doing the basic functionality first, as it is used by guests,=

> and later add the irqfd option. I don't see any emergency here and adding
> the irqfd will not cause fundamental design changes:
>=20
> The "passed" flag (though I'm not fan of the name) is really something
> we want in the low level handlers to avoid triggering host side EEH in
> various places, regardless of whether we use irqfd or not.
>=20
> This is totally orthogonal from the mechanism used for notifications.
>=20
> Even in host, the detection path doesn't always involve interrupts, and
> we can detect some things as a result of a host side config space access
> for example etc...
>=20
> So let's keep things nice and separate here. The interrupt notification
> is just an "optimization" which will speed up discovery of the error in
> *some* cases later on (but adds its own complexity since we have multiple
> discovery path in host, so we need to keep track whether we have notified
> yet or not etc...) so let's keep it for later.

EEH handling is your call, but I only see reduced complexity here. I won't n=
ak the current approach though.


Alex
