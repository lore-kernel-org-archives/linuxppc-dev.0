Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D8E1DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 06:06:13 +1000 (EST)
In-Reply-To: <200706082201.26308.arnd@arndb.de>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706082126.23435.arnd@arndb.de>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
	<200706082201.26308.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <e098552c6ae6fa48212a951ec644b80f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 22:06:02 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That wasn't my question though?
>
> Sorry, I misread this. The of_node_get is done because we keep
> a reference to the device node in the axon_msic struct. There is
> no module_exit function in the driver that could clean up the
> axon_msic, so we must never have an of_node_put as far as I
> understand.

>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(axon_msi_setup_one(of_node_get(node)) =3D=3D 0)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found++;

What if axon_msi_setup_one() returns an error?  Sounds
to me like the get() should be inside that function no
matter what?

If the reference counting isn't obvious, it is obviously
wrong ;-)


Segher
