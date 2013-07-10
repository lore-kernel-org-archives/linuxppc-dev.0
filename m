Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 52B582C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 20:42:09 +1000 (EST)
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <D5AD40B0-B069-4BAD-90E0-3ECE2FE81038@suse.de>
Date: Wed, 10 Jul 2013 12:42:04 +0200
Message-Id: <BEA4EEEE-D485-4574-A32B-31F2FA3319C5@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru> <51DC4923.5010501@suse.de>
 <51DC9CDA.3070906@ozlabs.ru> <778C7C81-5F7F-4E21-8B72-92F336002F9E@suse.de>
 <1373452753.19894.19.camel@pasglop>
 <D5AD40B0-B069-4BAD-90E0-3ECE2FE81038@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.07.2013, at 12:40, Alexander Graf wrote:

>=20
> On 10.07.2013, at 12:39, Benjamin Herrenschmidt wrote:
>=20
>> On Wed, 2013-07-10 at 12:33 +0200, Alexander Graf wrote:
>>>=20
>>> It's not exactly obvious that you're calling it with writing =3D=3D =
1 :).
>>> Can you create a new local variable "is_write" in the calling
>>> function, set that to 1 before the call to get_user_pages_fast and
>>> pass it in instead of the 1? The compiler should easily optimize all
>>> of that away, but it makes the code by far easier to read.
>>=20
>> Ugh ?
>>=20
>> Nobody else does that .... (look at futex :-)
>=20
> Yeah, that's fortunately code that I don't have to read :).

The "proper" alternative would be to pass an enum for read/write into =
the function rather than an int. But that'd be a pretty controversial, =
big change that I'd rather not put on Alexey. With a local variable =
we're nicely self-contained readable ;)


Alex
