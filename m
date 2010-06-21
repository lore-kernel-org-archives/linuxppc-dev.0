Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from outbound2.exchangedefender.com (outbound2.exchangedefender.com
	[65.99.255.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.exchangedefender.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE2E2B6F16
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 05:36:21 +1000 (EST)
Subject: RE: UCC interactions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 21 Jun 2010 15:19:38 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB9011BEA2B@ep-01.EmbeddedPlanet.local>
In-Reply-To: <4C1FB6BB.4040705@mlbassoc.com>
References: <4C1FB6BB.4040705@mlbassoc.com>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Gary Thomas" <gary@mlbassoc.com>,
	"Linux PPC Development" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I believe the offset for UCC3 is wrong.  The usermanual says UCC3's
registers are at 0x2200-0x23FF.  0x4000 is SDMA.  Hope that helps.

> -----Original Message-----
> From:
linuxppc-dev-bounces+blakeslees=3Dembeddedplanet.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+blakeslees=3Dembeddedplanet.com@lists.ozlabs.org] On Behalf Of
Gary
> Thomas
> Sent: Monday, June 21, 2010 3:00 PM
> To: Linux PPC Development
> Subject: UCC interactions
>=20
> I'm running 2.6.33.3 on MPC8358.  I have UCC1+UCC2 working fine
> for ethernet, but when I add UCC3 as a UART, the network devices
> quit working.
>=20
> Here are my device tree entries:
>           /* ETH0 (UCC1, MDIO 0x02, RMII) */
>           enet_eth0: ethernet@2000 {
>              device_type =3D "network";
>              compatible =3D "ucc_geth";
>              cell-index =3D <1>;
>              reg =3D <0x2000 0x200>;
>              interrupts =3D <32>;
>              interrupt-parent =3D <&qeic>;
>              local-mac-address =3D [ 00 00 00 00 00 00 ];
>              rx-clock-name =3D "none";
>              tx-clock-name =3D "clk16";
>              phy-handle =3D <&phy_eth0>;
>              phy-connection-type =3D "rmii";
>              pio-handle =3D <&pio_ucc1>;
>              linux,network-index =3D <0>;
>           };
>=20
>           /* ETH1 (UCC2, MDIO 0x01, GMII) */
>           enet_eth1: ethernet@3000 {
>              device_type =3D "network";
>              compatible =3D "ucc_geth";
>              cell-index =3D <2>;
>              reg =3D <0x3000 0x200>;
>              interrupts =3D <33>;
>              interrupt-parent =3D <&qeic>;
>              local-mac-address =3D [ 00 00 00 00 00 00 ];
>              rx-clock-name =3D "clk4";
>              tx-clock-name =3D "none";
>              fixed-link =3D <1 1 1000 0 0>;
>              phy-connection-type =3D "gmii";
>              pio-handle =3D <&pio_ucc2>;
>              linux,network-index =3D <1>;
>           };
>=20
>           /* ttyQE0 (UCC3) */
>           serial_qe0: serial@4000 {
>              device_type =3D "serial";
>              compatible =3D "ucc_uart";
>              cell-index =3D <3>;
>              reg =3D <0x4000 0x200>;
>              interrupts =3D <34>;
>              interrupt-parent =3D <&qeic>;
>              port-number =3D <0>;
>              rx-clock-name =3D "brg1";
>              tx-clock-name =3D "brg1";
>           };
>=20
> Are there known interactions between these two drivers/ports?
> Maybe there's something obviously wrong with my device tree?
>=20
> Thanks for any ideas/pointers
>=20
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--
ExchangeDefender Message Security: Click below to verify authenticity
http://www.exchangedefender.com/verify.asp?id=3Do5LJJcQU009752&from=3Dblake=
slees@embeddedplanet.com
