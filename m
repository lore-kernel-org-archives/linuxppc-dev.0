Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83FF067A79
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 20:43:20 +1000 (EST)
Subject: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kODGrmzodTlulyxJAcb1"
Date: Thu, 25 May 2006 12:43:05 +0200
Message-Id: <1148553785.11759.12.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kODGrmzodTlulyxJAcb1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

In order to replace snd-powermac for the newer machines where the
'sound' node has the 'layout-id' property, I'm looking for testers on
machines that have a layout-id [1] property with one of the following
values: 0x24, 0x29, 0x33, 0x50 and 0x3a.

Once I have all these, I will, along with submitting snd-aoa [2], submit
a patch to snd-powermac that makes it refuse loading in presence of a
layout-id property as a first step to migrate to snd-aoa.

At the same time, I'll probably make i2sbus refuse attaching to a device
unless there's a layout-id property so that it doesn't claim devices aoa
doesn't handle yet.

johannes

[1] to find your layout-id, execute the following:

  find /proc/device-tree/ -name layout-id | xargs hexdump -e '1/4 "0x%x\n"'

If you get no output, you have no layout-id property. If you do get
output, it will look like this:
  0x46
This is the layout-id of your sound node.

[2] Before you ask: I will not do this before snd-aoa supports headphone
detection :)


--=-kODGrmzodTlulyxJAcb1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHWKN6Vg1VMiehFYAQKO/RAAuqYZ4o0SLZKoa01rDjFmJomqBQu19IwV
C+swkh3KSx/mIqx1S+SCvYg/BHGw3p5IACO+oanj0+UH7VzjLG2024Je/ifwl19G
2wGJEugqD8+8/zE6/BbUkauId/OOVr45bIU/DoFelLNK7Yu9x28yKeWlkfqrYe7h
sUn5tXf4hqDi+ogw15+c+vGZMC0K7gYlv2oj2tdfjg98xuwYFN0ueIxY3LZcPNpw
yFzZxHOMthGHfBvEfWn6uSTZHg1YXezRB8TrnZ/ctxFUkTDSZV3zZavfjxi7dgad
iP1se9mlQnfKv7mpVcKhPiGwQX/BYKI3T8jpAIXqgvruJKMBTot1h9s936jWr0SM
P9SXLMz9pTP6TsLVWO6CTYc44/sUDL9psZbFXHwHbHc416LK6qmIWL4ZzrMXEyME
y6XAYCnbObPDSNr5cphVLFyUqKmBGGGjYxrnpzYrSpnC9ZPm7uGENmvtui0qz4al
YwKqve7TPKPz53Hb59a05Y/1FjcjURMvD3krvhIj31glsgyC/tKNHsdQW2bAVvr0
L12DGbMKgLIDcqbXTy3ltuM8mmtEnPAq8CEouEAnDYHE9H8hpXBBpvFCrJBZxYLa
+GOTZodFUkFXzu+ok3O12Kn7ZOsm34aglOMfwH7+hFfxE79xr6DHSHm3Pc+gGbcO
z6sL/ND4c0I=
=sRbY
-----END PGP SIGNATURE-----

--=-kODGrmzodTlulyxJAcb1--
