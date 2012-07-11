Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3D4B2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 08:52:04 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel
 hooks
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1342046584.18850.40.camel@pasglop>
Date: Thu, 12 Jul 2012 00:51:56 +0200
Message-Id: <52D81ED1-AEF7-43C8-84A4-98E1D895CD0B@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <1341440735.16808.42.camel@pasglop>
 <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net> ,
 <7305F50A-8E77-4E88-8EB8-4046A7E94DF9@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15CF83@039-SN2MPN1-013.039d.mgd.msft.net>
 <EED22D54-8B0F-4EAE-BA70-C5C086DBB7C1@suse.de>
 <1342045680.18850.39.camel@pasglop>
 <FE8CCAFA-454E-461A-96E8-64E8E3D186EE@suse.de>
 <1342046584.18850.40.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.07.2012, at 00:43, Benjamin Herrenschmidt wrote:

> On Thu, 2012-07-12 at 00:35 +0200, Alexander Graf wrote:
>>> On Thu, 2012-07-12 at 00:25 +0200, Alexander Graf wrote:
>>>> Or just free up another register early on, like here.
>>>=20
>>> If you're going to do that, you want to measure the impact on null
>>> syscall performance though.
>>=20
>> That should hold true for any change in that code, no?
>=20
> Yes, but adding a gpr save is more invasive (you have to also load it
> back later on & put it on the stack).

What's the usual cache line size like on these boxes? If you align it =
properly with r10 and r11 on the paca so that all 3 registers are in the =
same cache line, the load should be almost for free, no?


Alex
