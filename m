Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 1C4F1DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 17:17:52 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: reduce code duplication in legacy_serial,
	add UART parent types
Date: Fri, 25 Jan 2008 07:17:32 +0100
References: <200801172335.48817.arnd@arndb.de>
	<12011947821738-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <12011947821738-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801250717.34309.arnd@arndb.de>
Cc: scottwood@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 January 2008, Paul Gortmaker wrote:
> The legacy_serial was treating each UART parent in a separate code block.
> Rather than continue this trend for the new parent IDs, this condenses
> all (soc, tsi, opb, plus two more new types) into one of_device_id array.
> The new types are wrs,epld-localbus for the Wind River sbc8560, and a
> more generic "simple-bus" as requested by Scott Wood.
>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Looks good to me, thanks!
 =A0
> -=A0=A0=A0=A0=A0=A0=A0/* First fill our array with SOC ports */
> +=A0=A0=A0=A0=A0=A0=A0/* Iterate over all the 16550 ports, looking for kn=
own parents */
> =A0=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(np, "serial", "ns16550")=
 {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct device_node *soc =3D=
 of_get_parent(np);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (soc && !strcmp(soc->typ=
e, "soc")) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct device_node *parent =
=3D of_get_parent(np);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!parent)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0con=
tinue;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (of_match_node(parents, =
parent) !=3D NULL) {

Personally, I prefer to write this as

	if (of_match_node(parents, parent)) {

but that question of coding style is controversial enough that I
stopped insisting on that, so do whichever you like best.

	Arnd <><
