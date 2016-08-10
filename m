Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8YlJ0xhhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 00:42:20 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Petko Manolov' <petkan@mip-labs.com>, Mimi Zohar
 <zohar@linux.vnet.ibm.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thiago Jung
 Bauermann" <bauerman@linux.vnet.ibm.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-ima-devel@lists.sourceforge.net"
 <linux-ima-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [Linux-ima-devel] [PATCH 1/7] ima: on soft reboot, restore the
 measurement list
Date: Wed, 10 Aug 2016 14:40:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50F2BB@AcuExch.aculab.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
 <18857164.IzlezsQllh@hactar> <87vaz9rlx2.fsf@concordia.ellerman.id.au>
 <1470833676.2881.183.camel@linux.vnet.ibm.com>
 <20160810143230.GD4087@localhost>
In-Reply-To: <20160810143230.GD4087@localhost>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linuxppc-dev [mailto:linuxppc-dev-bounces+david.laight=3Daculab.com@l=
ists.ozlabs.org] On Behalf Of
> > > So given what you have above, you'd use something like:
> > >
> > > struct ima_kexec_hdr {
> > > 	u16 version;
> > > 	u16 _reserved0;
> > > 	u32 _reserved1;
> > > 	u64 buffer_size;
> > > 	u64 count;
> > > };
> > >
> > > cheers
> >
> > Thanks, I'll make this change.
>=20
> I would suggest:
>=20
> struct ima_kexec_hdr {
> 	u64 buffer_size;
> 	u64 count;
> 	u16 version;
> };
>=20
> and let the compiler add the proper padding, depending on the architectur=
e.  On
> 32bit machine we'll have 4 bytes smaller allocations (compared to 64bit) =
while
> retaining the same functionality.

AAAArrrrgggg.....

That doesn't work for 32bit applications on 64bit hosts.
The extra bytes will make 0 difference to the allocation cost and
lots to the processing.

	David
