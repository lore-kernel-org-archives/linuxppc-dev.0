Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 8CAAC67A86
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 22:09:03 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id DB79C3DDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 12:09:01 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 8 Feb 2005 12:09:01 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B71@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Jarno Manninen" <manninej@students.cc.tut.fi>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: AW: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 8 Feb 2005, Geert Uytterhoeven wrote:
> > > I have similar problems with an MPC5200 board and a Silicon Motion
> > > SM501 (Voyager) grafic controller. The controller has a PCI and a
> > > local bus interface. We use the local bus interface to connect it
> > > with the 5200. In 32 bit truecolor mode everything works fine, but
> > > in 16 bit mode bytes are swapped: 0x12345678 =3D> 0x34127856.
> > > I'm not sure, if this problem has something to do with the CoralP
> > > problem, but it is likely too similar to be completely
> > > independent. Does anyone use an SM501 in 16 bit mode?
> >=20
> > This is the problem with big-endian systems with PCI bus. I've seen
> > this on sparc and on MPC5200 too. There is no other solution, but
> > to swap the bytes in SW.
>=20
> Yep, the Cybervision graphics cards on Amiga (S3 Trio or ViRGE)
> suffer from the same problem.
>=20
> > The problem is that the PCI bus and CPU must agree when thinking of
> > arithmetic context. For example when talking about adresses, both
> > parties have to see address numbers in the same way. Problem is
> > that with graphics formats we are talking about bit masks, not
> > actual numbers. So inner byte order _does_ have meaning while with
> > plain numbers it does _not_, right?=20
>=20
> If your graphics chip has separate apertures for big and little
> endian (and a control register to `fix' swapping depending on the
> color depth), you may be able to find a configuration that doesn't
> need any swapping on the CPU.=20

Hm, the SM501 has 8 MB internal RAM. The framebuffer lies within this
memory. The SM501 is connected with the MPC5200 over the local bus=20
interface (not over PCI) and mapped with CS1 to address range
0xE0000000-0xE3FFFFFF. The SM501 configuration registers are within=20
the mapped memory area at 0xE3E00000. I can't imagine, why the byte=20
swapping should only affect accesses to the famebuffer memory and not
to the configuration registers (where also single bits at the right=20
position must be set correctly). I could configure CS1 to do byte=20
swapping, but then access to the SM501 configuration registers does=20
not work any longer, because this bytes are swapped, too.

Geert, I've seen, you have done much of the fb stuff in the linux=20
kernel (thank you for that!). Could you please point me to the best=20
place, where byte swapping should be done if I want to use the linux=20
text console in 16 bit mode with the MPC5200?

regards,
Martin Krause
