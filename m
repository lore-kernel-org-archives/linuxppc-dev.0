Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27BC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 09:40:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F24F206E9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 09:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F24F206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495z7L36yTzDqnT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 19:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 495z4K3kn8zDqfZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 19:37:19 +1000 (AEST)
Received: from localhost (p54B336C5.dip0.t-ipconnect.de [84.179.54.197])
 by pokefinder.org (Postfix) with ESMTPSA id E25912C1FBE;
 Tue, 21 Apr 2020 11:37:15 +0200 (CEST)
Date: Tue, 21 Apr 2020 11:37:13 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Aishwarya R <aishwaryarj100@gmail.com>, "Erhard F." <erhard_f@mailbox.org>
Subject: Re: [PATCH] i2c: powermac: Simplify reading the "reg" and
 "i2c-address" property
Message-ID: <20200421093712.GA1241@ninjato>
References: <20200408100354.17782-1-aishwaryarj100@gmail.com>
 <20200415131916.23555-1-aishwaryarj100@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20200415131916.23555-1-aishwaryarj100@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 06:49:14PM +0530, Aishwarya R wrote:
> >> Use of_property_read_u32 to read the "reg" and "i2c-address" property
> >> instead of using of_get_property to check the return values.
> >>
> >> Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
>=20
> > This is quite a fragile driver. Have you tested it on HW?
>=20
> This change is not tested with the Hardware.
> But of_property_read_u32 is better here than generic of_get_property.
> This make sure that value read properly independent of system endianess.

This driver is only used on PPC_BE. And it is *very* fragile. The gain
is not enough for me to accept it without testing. Maybe Erhard (CCed)
is interested. If not, you may find someone on the ppc lists.


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6evsQACgkQFA3kzBSg
KbZZew/9FFFtMHlcKTYHVgIyAJEHF4gXnOacFSvV02PMg4ZwajJfEatTog1WhMhU
aHpK1kEpP6nwsFk1HXD6+NMeZUsTojUkYk4ipKclvJBydN4O7VJKYYyWhdvcKlNG
T6q2bRsC3qI5QGAxaSumXIqT48HKGxM420yiJDySa8JeAQSDyoL3Q5NAzH04BQBF
JPWfJyJmhB0rP+DLkXLD2ZG/DDnBMZWWmRHxMbzognRcYkeV1RB0svQTKtKsFbLs
vfiTx2E+VvNtt1eoIOXapPnozbkOZUjAd+59JO59UMKORCf0HL393qsAyqMgfSQz
unuzZ8ZRL8xhFv2ptHfi+9zpGt4WVSk8r1U2lvBgM5g1ais7+acRiLWvyBW4yGdJ
TzsYE2x5eLW2bSQtaAo17VTF/cSC927DRvk0GRutj5+yxIqmWlJg6jGDZz8rS4WF
3S5JNkAdOYFWjsQpqOCBSEipY1YhinOlUtfw70bYUlJjUiKDN7nENuPtT5fAMEaj
KhVoAI4pzrTPzz2I4/tBjlV3q6P8fLhVPORPxz4DNzOBGk40oSbgSWeLs6Nr2BKY
J/uIFg5+9K9jdEnRDRWlDNx7fRgGxxozQV7tsGej+Sp/8Cn7kRg8gm4OTbwDlr8j
LZ3cwigeiQYOe3aiCPNVkxWFDbJuhDeM4tnf/fAlbNcLNqhyOew=
=SHDk
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
