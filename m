Return-Path: <zinosat@tiscali.it>
Received: from mrqout1.tiscali.it (mrqout1-sorbs.tiscali.it [195.130.225.22])
 by ozlabs.org (Postfix) with ESMTP id 5B8102C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 00:49:21 +1000 (EST)
Message-ID: <16335311.74971348843734905.JavaMail.defaultUser@defaultHost>
Date: Fri, 28 Sep 2012 16:48:54 +0200 (CEST)
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

>
>It was, can you figure out in u-boot what exact config read on=20
the bus would return the correct thing.
>
>The fact that when we probe the=20
device at 0001:03 we should get back something like cfg_data=3D0xabba1b65
>

here=20
follow some details about what is going on inside u-boot; verbosity increas=
es=20
from [1] to [3]

 [1] PCI printouts when the board come up
 [2] output of "pci=20
[0-3] long" u-boot command
 [3] same as [1] but with debug print inside=20
indirect_read_config_##size() [drivers/pci/pci_indirect.c]

if you were curious=20
about our u-boot board settings, please refer to:
http://www.mail-archive.
com/linuxppc-dev@lists.ozlabs.org/msg62007.html

thanx alot,
Davide



*************
*    [1]    *
*************
    PCIE1 used as Root Complex (base=20
addr ffe09000)
               Scanning PCI bus 01
        01  00  1b65  abba =20
0280  00
        cfg_addr:ffe09000  cfg_data:ffe09004  indirect_type:0
   =20
PCIE1 on bus 00 - 01


    PCIE2 used as Root Complex (base addr ffe0a000)

               Scanning PCI bus 03
        03  00  1b65  abba  0280  00
       =20
cfg_addr:ffe0a000  cfg_data:ffe0a004  indirect_type:0
    PCIE2 on bus 02 - 03


*************
*    [2]    *
*************

=3D> pci 0 long
Scanning PCI devices=20
on bus 0

Found PCI device 00.00.00:
  vendor ID =3D                   0x1957
 =20
device ID =3D                   0x0100
  command register =3D            0x0006
 =20
status register =3D             0x0010
  revision ID =3D                 0x11
 =20
class code =3D                  0x0b (Processor)
  sub class code =3D             =20
0x20
  programming interface =3D       0x00
  cache line =3D                  0x08

  latency time =3D                0x00
  header type =3D                 0x01
 =20
BIST =3D                        0x00
  base address 0 =3D              0xfff00000
 =20
base address 1 =3D              0x00000000
  primary bus number =3D          0x00
 =20
secondary bus number =3D        0x01
  subordinate bus number =3D      0x01
 =20
secondary latency timer =3D     0x00
  IO base =3D                     0x00
  IO=20
limit =3D                    0x00
  secondary status =3D            0x0000
  memory=20
base =3D                 0xa000
  memory limit =3D                0xa000
  prefetch=20
memory base =3D        0x1001
  prefetch memory limit =3D       0x0001
  prefetch=20
memory base upper =3D  0x00000000
  prefetch memory limit upper =3D 0x00000000
  IO=20
base upper 16 bits =3D       0x0000
  IO limit upper 16 bits =3D      0x0000
 =20
expansion ROM base address =3D  0x00000000
  interrupt line =3D              0x00
 =20
interrupt pin =3D               0x00
  bridge control =3D              0x0000

=3D>=20
pci 1 long
Scanning PCI devices on bus 1

Found PCI device 01.00.00:kk
  vendor=20
ID =3D                   0x1b65
  device ID =3D                   0xabba
  command=20
register =3D            0x0006
  status register =3D             0x0010
  revision=20
ID =3D                 0x01
  class code =3D                  0x02 (Network=20
controller)
  sub class code =3D              0x80
  programming interface=20
=3D       0x00
  cache line =3D                  0x08
  latency time=20
=3D                0x00
  header type =3D                 0x00
  BIST=20
=3D                        0x00
  base address 0 =3D              0xa0000000
  base=20
address 1 =3D              0xa0010000
  base address 2 =3D              0x00000000

  base address 3 =3D              0x00000000
  base address 4 =3D             =20
0x00000000
  base address 5 =3D              0x00000000
  cardBus CIS pointer=20
=3D         0x00000000
  sub system vendor ID =3D        0x0000
  sub system ID=20
=3D               0x0000
  expansion ROM base address =3D  0x00000000
  interrupt=20
line =3D              0x00
  interrupt pin =3D               0x01
  min Grant=20
=3D                   0x00
  max Latency =3D                 0x00

=3D> pci 2 long

Scanning PCI devices on bus 2

Found PCI device 02.00.00:
  vendor ID=20
=3D                   0x1957
  device ID =3D                   0x0100
  command=20
register =3D            0x0006
  status register =3D             0x0010
  revision=20
ID =3D                 0x11
  class code =3D                  0x0b (Processor)
 =20
sub class code =3D              0x20
  programming interface =3D       0x00
  cache=20
line =3D                  0x08
  latency time =3D                0x00
  header type=20
=3D                 0x01
  BIST =3D                        0x00
  base address 0=20
=3D              0xfff00000
  base address 1 =3D              0x00000000
  primary=20
bus number =3D          0x00
  secondary bus number =3D        0x01
  subordinate=20
bus number =3D      0x01
  secondary latency timer =3D     0x00
  IO base=20
=3D                     0x00
  IO limit =3D                    0x00
  secondary=20
status =3D            0x0000
  memory base =3D                 0xb000
  memory=20
limit =3D                0xb000
  prefetch memory base =3D        0x1001
  prefetch=20
memory limit =3D       0x0001
  prefetch memory base upper =3D  0x00000000
 =20
prefetch memory limit upper =3D 0x00000000
  IO base upper 16 bits =3D       0x0000

  IO limit upper 16 bits =3D      0x0000
  expansion ROM base address =3D =20
0x00000000
  interrupt line =3D              0x00
  interrupt pin =3D              =20
0x00
  bridge control =3D              0x0000

=3D> pci 3 long
Scanning PCI devices=20
on bus 3

Found PCI device 03.00.00:
  vendor ID =3D                   0x1b65
 =20
device ID =3D                   0xabba
  command register =3D            0x0006
 =20
status register =3D             0x0010
  revision ID =3D                 0x01
 =20
class code =3D                  0x02 (Network controller)
  sub class code=20
=3D              0x80
  programming interface =3D       0x00
  cache line=20
=3D                  0x08
  latency time =3D                0x00
  header type=20
=3D                 0x00
  BIST =3D                        0x00
  base address 0=20
=3D              0xb0000000
  base address 1 =3D              0xb0010000
  base=20
address 2 =3D              0x00000000
  base address 3 =3D              0x00000000

  base address 4 =3D              0x00000000
  base address 5 =3D             =20
0x00000000
  cardBus CIS pointer =3D         0x00000000
  sub system vendor ID=20
=3D        0x0000
  sub system ID =3D               0x0000
  expansion ROM base=20
address =3D  0x00000000
  interrupt line =3D              0x00
  interrupt pin=20
=3D               0x01
  min Grant =3D                   0x00
  max Latency=20
=3D                 0x00


*************
*    [3]    *
*************

    PCIE1=20
used as Root Complex (base addr ffe09000)
b=3D0 d=3D0 f=3D0 (fbusno=3D0 itype=3D0=20
cfg_adr=3Dffe09000 cfg_data=3Dffe09004) ofs=3D10 mask=3D0
...
               Scanning=20
PCI bus 01
b=3D1 d=3D0 f=3D0 (fbusno=3D0 itype=3D0 cfg_adr=3Dffe09000 cfg_data=3Dffe09=
004)=20
ofs=3De mask=3D3
...
b=3D1 d=3D0 f=3D0 (fbusno=3D0 itype=3D0 cfg_adr=3Dffe09000=20
cfg_data=3Dffe09004) ofs=3D3c mask=3D3
        01  00  1b65  abba  0280  00
b=3D1 d=3D1=20
f=3D0 (fbusno=3D0 itype=3D0 cfg_adr=3Dffe09000 cfg_data=3Dffe09004) ofs=3De=
 mask=3D3
b=3D1 d=3D1=20
f=3D0 (fbusno=3D0 itype=3D0 cfg_adr=3Dffe09000 cfg_data=3Dffe09004) ofs=3D0=
 mask=3D2
...
b=3D0=20
d=3D0 f=3D0 (fbusno=3D0 itype=3D0 cfg_adr=3Dffe09000 cfg_data=3Dffe09004) o=
fs=3D9 mask=3D3
   =20
PCIE1 on bus 00 - 01

    PCIE2 used as Root Complex (base addr ffe0a000)
b=3D0=20
d=3D0 f=3D0 (fbusno=3D2 itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a004) o=
fs=3D10 mask=3D0
b=3D0=20
d=3D0 f=3D0 (fbusno=3D2 itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a004) o=
fs=3D10 mask=3D0
...

b=3D0 d=3D0 f=3D0 (fbusno=3D2 itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a=
004) ofs=3D9 mask=3D3

               Scanning PCI bus 03
b=3D1 d=3D0 f=3D0 (fbusno=3D2 itype=3D0=20
cfg_adr=3Dffe0a000 cfg_data=3Dffe0a004) ofs=3De mask=3D3
b=3D1 d=3D0 f=3D0 (fbusno=3D2 itype=3D0=20
cfg_adr=3Dffe0a000 cfg_data=3Dffe0a004) ofs=3D0 mask=3D2
...
b=3D1 d=3D0 f=3D0 (fbusno=3D2=20
itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a004) ofs=3D3c mask=3D3
        03  00  1b65 =20
abba  0280  00
        cfg_addr:ffe0a000  cfg_data:ffe0a004  indirect_type:0

b=3D1 d=3D1 f=3D0 (fbusno=3D2 itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a=
004) ofs=3De mask=3D3

...
b=3D0 d=3D0 f=3D0 (fbusno=3D2 itype=3D0 cfg_adr=3Dffe0a000 cfg_data=3Dffe0a=
004) ofs=3D9=20
mask=3D3
    PCIE2 on bus 02 - 03



Invita i tuoi amici e Tiscali ti premia! Il consiglio di un amico vale pi=
=C3=B9 di uno spot in TV. Per ogni nuovo abbonato 30 =E2=82=AC di premio pe=
r te e per lui! Un amico al mese e parli e navighi sempre gratis: http://fr=
eelosophy.tiscali.it/
