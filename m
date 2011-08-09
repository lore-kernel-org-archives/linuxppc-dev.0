Return-Path: <xenidis@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9A4BB6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 01:25:05 +1000 (EST)
Received: by gyb11 with SMTP id 11so70650gyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 09 Aug 2011 08:25:01 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH 3/3] powerpc: icswx: Simple ACOP fault handler for both
	book3e and book3s parts.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1312902929.29273.10.camel@pasglop>
Date: Tue, 9 Aug 2011 10:24:49 -0500
Message-Id: <D031009D-98D2-4546-8EBB-035EDDAE2E3D@pobox.com>
References: <1312842408-21482-1-git-send-email-jimix@pobox.com>
	<1312842408-21482-4-git-send-email-jimix@pobox.com>
	<500B0F0F-658A-4B95-8BEC-978D738A926F@kernel.crashing.org>
	<1312902929.29273.10.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2011, at 10:15 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-08-09 at 00:26 -0500, Kumar Gala wrote:
>=20
>>> +	/* Some implementations leave us a hint for the CT */
>>> +	ct =3D ICSWX_GET_CT_HINT(error_code);
>>> +	if (ct < 0) {
>>> +		/* we have to peek at the instruction work to figure out =
CT */
>>> +		union cop_ccw ccw;
>>=20
>> don't use a union, we don't do this for any other place we decode =
instructions (just use shift/mask).  Utilize ppc-opcode.h
>=20
> Except that the union here is -not- the instruction, but the content =
of
> the RS register :-)

I agree, especially for when we need the kernel to build the =
struct/union.
However, that is a later patch (working on it now and if there are no =
objections) so I'll add it then.
-JX

>=20
> Cheers,
> Ben.
>=20
>=20
