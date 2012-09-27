Return-Path: <zinosat@tiscali.it>
Received: from mrqout2.tiscali.it (mrqout2.tiscali.it [195.130.225.12])
 by ozlabs.org (Postfix) with ESMTP id CE1062C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 23:15:39 +1000 (EST)
Message-ID: <1566557.89621348751677116.JavaMail.defaultUser@defaultHost>
Date: Thu, 27 Sep 2012 15:14:37 +0200 (CEST)
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

Hi Kumar,

>----Messaggio originale----
>Da: galak@kernel.crashing.org
>Data:=20
27/09/2012 14.27
>A: "Davide Viti"<zinosat@tiscali.it>
>Cc: <linuxppc-dev@lists.
ozlabs.org>
>Ogg: Re: PCI device not working
>
...
>Can you see what bus_no=20
actually gets set to in the case we scan 0001:03 ?
>
>If its set to 03, can you=20
try hack it to 1.

is this what you mean?

---=20
a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c


        bus_no =3D (bus->number =3D=3D hose->first_busno) ?
                       =20
hose->self_busno : bus->number;

+       if (bus_no =3D=3D 3) {
+         printk
("*** force bus_no 3 -> 1 ***\n");
+         bus_no =3D 1;
+       }
+


I've=20
tested a kernel with the above patch and this is what is printed on the log=
:


pci_bus 0001:03: scanning bus
-> ind_r_config - [/pcie@ffe0a000] devfn=3D0x0=20
offset=3D0x0 len=3D0x4 hose->indirect_type=3D0x16 hose->first_busno=3D0x2 b=
us-
>number=3D0x3
*** force bus_no 3 -> 1 ***
 -> ind_r_config [/pcie@ffe0a000] -=20
(bus_no=3D0x1 reg=3D0x0 cfg_data=3D0xff7eb004 len=3D0x4 hose->cfg_addr=3D0x=
ff7eb000)=20
val=3D0xffffffff PCIBIOS_SUCCESSFUL

the entire log (132Kb) is available in [1]=20
and [2]

thanx for your help,
Davide

[1] http://pastebin.com/3mcbDzwY
[2] http:
//paste2.org/p/2274032



Invita i tuoi amici e Tiscali ti premia! Il consiglio di un amico vale pi=
=C3=B9 di uno spot in TV. Per ogni nuovo abbonato 30 =E2=82=AC di premio pe=
r te e per lui! Un amico al mese e parli e navighi sempre gratis: http://fr=
eelosophy.tiscali.it/
