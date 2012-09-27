Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3CBC62C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 02:07:49 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1566557.89621348751677116.JavaMail.defaultUser@defaultHost>
Date: Thu, 27 Sep 2012 11:06:09 -0500
Message-Id: <DDC80566-F415-44E4-AA71-C5B0B24E988E@kernel.crashing.org>
References: <1566557.89621348751677116.JavaMail.defaultUser@defaultHost>
To: Davide Viti <zinosat@tiscali.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2012, at 8:14 AM, Davide Viti wrote:

> Hi Kumar,
>=20
>> ----Messaggio originale----
>> Da: galak@kernel.crashing.org
>> Data:=20
> 27/09/2012 14.27
>> A: "Davide Viti"<zinosat@tiscali.it>
>> Cc: <linuxppc-dev@lists.
> ozlabs.org>
>> Ogg: Re: PCI device not working
>>=20
> ...
>> Can you see what bus_no=20
> actually gets set to in the case we scan 0001:03 ?
>>=20
>> If its set to 03, can you=20
> try hack it to 1.
>=20
> is this what you mean?

It was, can you figure out in u-boot what exact config read on the bus =
would return the correct thing.

The fact that when we probe the device at 0001:03 we should get back =
something like cfg_data=3D0xabba1b65

- k

>=20
> ---=20
> a/arch/powerpc/sysdev/indirect_pci.c
> +++ b/arch/powerpc/sysdev/indirect_pci.c
>=20
>=20
>        bus_no =3D (bus->number =3D=3D hose->first_busno) ?
>=20
> hose->self_busno : bus->number;
>=20
> +       if (bus_no =3D=3D 3) {
> +         printk
> ("*** force bus_no 3 -> 1 ***\n");
> +         bus_no =3D 1;
> +       }
> +
>=20
>=20
> I've=20
> tested a kernel with the above patch and this is what is printed on =
the log:
>=20
>=20
> pci_bus 0001:03: scanning bus
> -> ind_r_config - [/pcie@ffe0a000] devfn=3D0x0=20
> offset=3D0x0 len=3D0x4 hose->indirect_type=3D0x16 =
hose->first_busno=3D0x2 bus-
>> number=3D0x3
> *** force bus_no 3 -> 1 ***
> -> ind_r_config [/pcie@ffe0a000] -=20
> (bus_no=3D0x1 reg=3D0x0 cfg_data=3D0xff7eb004 len=3D0x4 =
hose->cfg_addr=3D0xff7eb000)=20
> val=3D0xffffffff PCIBIOS_SUCCESSFUL
>=20
> the entire log (132Kb) is available in [1]=20
> and [2]
>=20
> thanx for your help,
> Davide
>=20
> [1] http://pastebin.com/3mcbDzwY
> [2] http:
> //paste2.org/p/2274032
>=20
>=20
>=20
> Invita i tuoi amici e Tiscali ti premia! Il consiglio di un amico vale =
pi=F9 di uno spot in TV. Per ogni nuovo abbonato 30 =80 di premio per te =
e per lui! Un amico al mese e parli e navighi sempre gratis: =
http://freelosophy.tiscali.it/
