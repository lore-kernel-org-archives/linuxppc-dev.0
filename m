Return-Path: <chuckk2333@yahoo.com>
Received: from web36403.mail.mud.yahoo.com (web36403.mail.mud.yahoo.com
	[209.191.91.195]) by ozlabs.org (Postfix) with SMTP id E16ECB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 06:29:07 +1000 (EST)
Message-ID: <523835.3776.qm@web36403.mail.mud.yahoo.com>
Date: Wed, 6 Apr 2011 13:29:05 -0700 (PDT)
From: Chuck Ketcham <chuckk2333@yahoo.com>
Subject: Re: Using dmaengine on Freescale P2020 RDB
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20110406201029.GC7312@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira,=0A=0AThanks for the reference to the CARMA drivers.  I will have to ta=
ke a look at that.=0A=0AIn my case, CONFIG_NET_DMA is not enabled.  However=
, I did notice the following entry in my p2020rdb.dts file that may have so=
mething to do with dma channels being allocated -- can anyone interpret thi=
s?:=0A=0A                dma@21300 {=0A                        #address-cel=
ls =3D <1>;=0A                        #size-cells =3D <1>;=0A              =
          compatible =3D "fsl,eloplus-dma";=0A                        reg =
=3D <0x21300 0x4>;=0A                        ranges =3D <0x0 0x21100 0x200>=
;=0A                        cell-index =3D <0>;=0A                        d=
ma-channel@0 {=0A                                compatible =3D "fsl,eloplu=
s-dma-channel";=0A                                reg =3D <0x0 0x80>;=0A   =
                             cell-index =3D <0>;=0A                        =
        interrupt-parent =3D <&mpic>;=0A                                int=
errupts =3D <20 2>;=0A                        };=0A                        =
dma-channel@80 {=0A                                compatible =3D "fsl,elop=
lus-dma-channel";=0A                                reg =3D <0x80 0x80>;=0A=
                                cell-index =3D <1>;=0A                     =
           interrupt-parent =3D <&mpic>;=0A                                =
interrupts =3D <21 2>;=0A                        };=0A                     =
   dma-channel@100 {=0A                                compatible =3D "fsl,=
eloplus-dma-channel";=0A                                reg =3D <0x100 0x80=
>;=0A                                cell-index =3D <2>;=0A                =
                interrupt-parent =3D <&mpic>;=0A                           =
     interrupts =3D <22 2>;=0A                        };=0A                =
        dma-channel@180 {=0A                                compatible =3D =
"fsl,eloplus-dma-channel";=0A                                reg =3D <0x180=
 0x80>;=0A                                cell-index =3D <3>;=0A           =
                     interrupt-parent =3D <&mpic>;=0A                      =
          interrupts =3D <23 2>;=0A                        };=0A           =
     };=0A=0A=0A=0A--- On Wed, 4/6/11, Ira W. Snyder <iws@ovro.caltech.edu>=
 wrote:=0A=0A> From: Ira W. Snyder <iws@ovro.caltech.edu>=0A> Subject: Re: =
Using dmaengine on Freescale P2020 RDB=0A> To: "Chuck Ketcham" <chuckk2333@=
yahoo.com>=0A> Cc: linuxppc-dev@lists.ozlabs.org=0A> Date: Wednesday, April=
 6, 2011, 1:10 PM=0A> On Wed, Apr 06, 2011 at 12:40:58PM=0A> -0700, Chuck K=
etcham wrote:=0A> > All,=0A> > =0A> > I have a Freescale P2020 Reference De=
sign Board.=A0=0A> I am investigating the possibility of using the dmaengin=
e=0A> capability in the 2.6.32.13 kernel to transfer data from=0A> memory o=
ut onto the PCIe bus.=A0 As a first step, I=0A> thought I would try the DMA=
 test client (dmatest.ko) to make=0A> sure the dmaengine was functioning.=
=A0 I know this=0A> doesn't transfer anything over PCIe but only transfers =
from=0A> one memory buffer to another, but I figured I need to get=0A> this=
 working first.=A0 Anyway I built dmatest.ko and ran=0A> it (with insmod), =
and discovered it didn't do=0A> anything.=A0 I added some printk's to the k=
ernel to=0A> investigate what was going on and I found that all attempts=0A=
> to find a channel within dma_request_channel were=0A> unsuccessful.=A0 Th=
ree of the channels were not used=0A> because they were already publicly al=
located.=A0 One=0A> channel was not used because it didn't have DMA_MEMCPY=
=0A> capability.=0A> > =0A> > Here are my questions then:=0A> > 1. Is the d=
maengine the appropriate method to use for=0A> transferring data from memor=
y out onto the PCIe bus?=0A> > 2. If dmaengine is correct, what can I do to=
 free up a=0A> channel for my own use?=0A> > =0A> =0A> I use the Freescale =
DMA engine to transfer lots of data out=0A> to PCI, on=0A> an 8349EA chip. =
The P2020 DMA engine uses the same driver.=0A> =0A> I hunch you have enable=
d CONFIG_NET_DMA, which will claim=0A> the channels.=0A> You should disable=
 it to use the devices for other uses.=0A> =0A> If you want an example of u=
sing the DMA engine to transfer=0A> from DDR=0A> memory to the PowerPC loca=
l bus, search the mailing list=0A> archives for=0A> "CARMA Board Drivers" (=
RFCv7 was the latest posting).=0A> Transferring from=0A> DDR to PCI works e=
xactly the same way.=0A> =0A> Hope it helps,=0A> Ira=0A> __________________=
_____________________________=0A> Linuxppc-dev mailing list=0A> Linuxppc-de=
v@lists.ozlabs.org=0A> https://lists.ozlabs.org/listinfo/linuxppc-dev=0A> 
