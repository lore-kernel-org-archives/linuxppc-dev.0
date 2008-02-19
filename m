Return-Path: <Nicolas.Genevrier@jdsu.com>
Received: from jdsu.com (mio.acterna.de [141.169.254.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F1E2DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 02:00:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Ethernet breakdown on a Yosemite evaluation board
Date: Tue, 19 Feb 2008 16:04:35 +0100
Message-ID: <8C40729B7184DC459A15060FA1AF589602045601@ENIEXCH01.ds.jdsu.net>
In-Reply-To: <20080219081717.6b10d60d@zod.rchland.ibm.com>
References: <8C40729B7184DC459A15060FA1AF589602045556@ENIEXCH01.ds.jdsu.net>
	<20080219081717.6b10d60d@zod.rchland.ibm.com>
From: "Nicolas Genevrier" <Nicolas.Genevrier@jdsu.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks a lot for the information,
I apologize having not seen the posted patch.
Everything seems to run well now.

Nicolas

-----Message d'origine-----
De=A0: Josh Boyer [mailto:jwboyer@gmail.com]=20
Envoy=E9=A0: mardi 19 f=E9vrier 2008 15:17
=C0=A0: Nicolas Genevrier
Cc=A0: linuxppc-embedded@ozlabs.org
Objet=A0: Re: Ethernet breakdown on a Yosemite evaluation board

On Tue, 19 Feb 2008 14:00:19 +0100
"Nicolas Genevrier" <Nicolas.Genevrier@jdsu.com> wrote:

> Hello all,
>=20
> I noticed an Ethernet blocking on a Yosemite evaluation board when we
> are using both Ethernet devices (eth0 and eth1).
> To reproduce the issue, I just telnet the board from a PC (PC1) =
through
> eth0 and then telnet another PC (PC2) from the first telnet session
> through eth1. Then I display a lot of characters on the last telnet
> session:
> 	$ for i in `seq 1 100000`; do echo "$i
> aaaaaaaaaaa..(x160)..aaa"; done
>=20
> After a while, transmission is blocked and leads to an rxde =
interruption
> from the MAL.
>=20
> Yosemite evaluation kit runs Linux 2.16.13 but I reproduced the issue
> with our board running Linux-2.6.16 on a 440EP.
> In Linux 2.6.16, the new ibm_emac driver tries to recover the error =
but
> Ethernet remains very very slow even one day after the end of the
> transmission.
>  I didn't notice any evolution related to this neither any discussion =
on
> the topic. Sorry if I missed them.
>=20
> I am working on the subject but an idea or related information would =
be
> helpful.

There was a patch from Wolfgang Ocker recently that fixed some interrupt
settings for 440EP in arch/ppc.  You might want to look at that.  I
still need to evaluate if the arch/powerpc port needs fixing.

http://patchwork.ozlabs.org/linuxppc/patch?person=3D1210&id=3D16789

josh
