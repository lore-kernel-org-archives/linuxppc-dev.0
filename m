Return-Path: <zinosat@tiscali.it>
Received: from mrqout2.tiscali.it (mrqout2.tiscali.it [195.130.225.12])
 by ozlabs.org (Postfix) with ESMTP id D67402C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 21:59:41 +1000 (EST)
Message-ID: <5793250.72901348746209965.JavaMail.defaultUser@defaultHost>
Date: Thu, 27 Sep 2012 13:43:29 +0200 (CEST)
From: Davide Viti <zinosat@tiscali.it>
To: <galak@kernel.crashing.org>
Subject: R: Re: PCI device not working
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Davide Viti <zinosat@tiscali.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

>So its odd that scanning of the second bus didn't report any devices.  Do=
=20
you have code that implements ppc_md.pci_exclude_device ?

not that I'm aware=20
of

>You might also want to put some code in the indirect PCI ops (indirect.c)=
=20
to see what actual values you are getting from various indirect_read_config=
()=20
calls.

To make sure that  ppc_md.pci_exclude_device is not implemented, I've=20
put some printouts inside  indirect_read_config(): I print various paramete=
rs=20
when the function is called, and when it returns and note that:

 1.=20
indirect_read_config() is called 422 times:=20
     174 times for=20
[/pcie@ffe0a000] (controller where the device is not detected)
     248 times=20
for [/pcie@ffe09000]=20
 2. ppc_md.pci_exclude_device is always NULL
 3. the=20
function always returns with PCIBIOS_SUCCESSFUL
 4. the only call to =20
indirect_read_config() inside which  bus_no=3D0x3, returns with the followi=
ng=20
log:

pci_bus 0001:03: scanning bus
-> ind_r_config - [/pcie@ffe0a000]=20
devfn=3D0x0 len=3D0x4 hose->indirect_type=3D0x16 hose->first_busno=3D0x2 bu=
s-
>number=3D0x3
 -> ind_r_config [/pcie@ffe0a000] - (bus_no=3D0x3 reg=3D0x0=20
cfg_data=3D0xffffffff len=3D0xff7eb004) val=3D0x4 PCIBIOS_SUCCESSFUL =20

the entire=20
log is about 116Kb and is available in [1] or [2] (didn't feel like pasting=
 so=20
much data on the ML)
thanx alot,

Davide

[1] http://pastebin.com/JaPGmmfs
[2]=20
http://paste2.org/p/2273728


Invita i tuoi amici e Tiscali ti premia! Il consiglio di un amico vale pi=
=C3=B9 di uno spot in TV. Per ogni nuovo abbonato 30 =E2=82=AC di premio pe=
r te e per lui! Un amico al mese e parli e navighi sempre gratis: http://fr=
eelosophy.tiscali.it/
