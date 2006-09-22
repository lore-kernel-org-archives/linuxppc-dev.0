Return-Path: <jimix@watson.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9789267A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 20:58:44 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MAwaAx002247
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 06:58:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8MAwaZ6170284
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 06:58:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8MAwZ0t021540
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 06:58:36 -0400
In-Reply-To: <1158886446.8109.2.camel@localhost.localdomain>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
	<135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
	<1158886446.8109.2.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-1-226878498"
Message-Id: <6CFA644D-5C8A-4047-A7CC-F11B457E3E1D@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [POWERPC] mark BUG() as noreturn
Date: Fri, 22 Sep 2006 06:58:24 -0400
To: michael@ellerman.id.au
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	Hollis Blanchard <hollisb@us.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-226878498
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On Sep 21, 2006, at 8:54 PM, Michael Ellerman wrote:

> On Thu, 2006-09-21 at 08:18 -0400, Jimi Xenidis wrote:
>> On Sep 21, 2006, at 12:55 AM, Stephen Rothwell wrote:
>>
>>> From an idea from Michael Ellerman.
>>>
>>> We finish the BUG() macro with a call to a function marked with
>>> attribute
>>> "noreturn" so that the compiler will know that BUG() and BUG_ON()
>>> (with a constant, non-zero argument) will not return.
>>
>> But BUG() _can_ return, if I have a probe, xmon or kgdb configured it
>> is possible  to play with the state of the world and try to continue/
>> recover, (xmon "x" command).  IMHO, this is a powerful debugging
>> scenario.
>
> Hmm, ok I hadn't thought of that. Personally I've never tried to  
> recover
> from a BUG(), do people really do that much?
Oh, do it once and your hooked :)

>
>> Why are we concerned with the performance of this anyway?
>
> Not so much the performance, more that it gives the compiler more
> information about what's happening and allows it to elide code in some
> circumstances - but it's not _that_ important.
>
> Having it configurable might be an option, dunno.

I would not object to making depend on CONFIG_DEBUG_KERNEL

--Apple-Mail-1-226878498
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFFE8Hbd/h5j14PFR4RAh0wAKDJoOGtPGBNgt7S8k/M3D3CdxTlmQCfd/KY
DCkS6zK2PTFYOROV2XV3ycs=
=egyH
-----END PGP SIGNATURE-----

--Apple-Mail-1-226878498--
