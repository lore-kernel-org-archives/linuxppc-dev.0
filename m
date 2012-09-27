Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A8032C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 22:27:29 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5793250.72901348746209965.JavaMail.defaultUser@defaultHost>
Date: Thu, 27 Sep 2012 07:27:33 -0500
Message-Id: <ABE67A9F-5576-46AD-8779-33AEEF66E93B@kernel.crashing.org>
References: <5793250.72901348746209965.JavaMail.defaultUser@defaultHost>
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


On Sep 27, 2012, at 6:43 AM, Davide Viti wrote:

> Hi,
>=20
>> So its odd that scanning of the second bus didn't report any devices. =
 Do=20
> you have code that implements ppc_md.pci_exclude_device ?
>=20
> not that I'm aware=20
> of
>=20
>> You might also want to put some code in the indirect PCI ops =
(indirect.c)=20
> to see what actual values you are getting from various =
indirect_read_config()=20
> calls.
>=20
> To make sure that  ppc_md.pci_exclude_device is not implemented, I've=20=

> put some printouts inside  indirect_read_config(): I print various =
parameters=20
> when the function is called, and when it returns and note that:
>=20
> 1.=20
> indirect_read_config() is called 422 times:=20
>     174 times for=20
> [/pcie@ffe0a000] (controller where the device is not detected)
>     248 times=20
> for [/pcie@ffe09000]=20
> 2. ppc_md.pci_exclude_device is always NULL
> 3. the=20
> function always returns with PCIBIOS_SUCCESSFUL
> 4. the only call to =20
> indirect_read_config() inside which  bus_no=3D0x3, returns with the =
following=20
> log:
>=20
> pci_bus 0001:03: scanning bus
> -> ind_r_config - [/pcie@ffe0a000]=20
> devfn=3D0x0 len=3D0x4 hose->indirect_type=3D0x16 hose->first_busno=3D0x2=
 bus-
>> number=3D0x3
> -> ind_r_config [/pcie@ffe0a000] - (bus_no=3D0x3 reg=3D0x0=20
> cfg_data=3D0xffffffff len=3D0xff7eb004) val=3D0x4 PCIBIOS_SUCCESSFUL =20=


Can you see what bus_no actually gets set to in the case we scan 0001:03 =
?

If its set to 03, can you try hack it to 1.

- k

>=20
> the entire=20
> log is about 116Kb and is available in [1] or [2] (didn't feel like =
pasting so=20
> much data on the ML)
> thanx alot,
>=20
> Davide
>=20
> [1] http://pastebin.com/JaPGmmfs
> [2]=20
> http://paste2.org/p/2273728
>=20
>=20
> Invita i tuoi amici e Tiscali ti premia! Il consiglio di un amico vale =
pi=F9 di uno spot in TV. Per ogni nuovo abbonato 30 =80 di premio per te =
e per lui! Un amico al mese e parli e navighi sempre gratis: =
http://freelosophy.tiscali.it/
