Subject: Re: [PATCH] IDE on CHRP LongTrail
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.21.0212232301330.1694-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0212232301330.1694-100000@vervain.sonytel.be>
Content-Type: text/plain
Date: 24 Dec 2002 08:40:32 +0100
Message-Id: <1040715633.1966.32.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-12-23 at 23:13, Geert Uytterhoeven wrote:
>
> This patch enables the SL82C105 IDE interface in the W83C553 PCI/ISA bridge on
> my CHRP LongTrail.
>
> There are 2 ways to configure the IDE interface:
>   - Legacy mode, using IRQ 14 for the primary channel, and IRQ 15 for the
>     secondary channel
>   - Native mode, using IRQ 32 (OpenPIC IRQ 16) for both channels
>
> Apparently Open Firmware left the IDE interface in legacy mode, while the
> interrupt property of the device pointed to the OpenPIC interrupt. Of course
> this mix of legacy and native mode didn't work well and no interrupts came
> through.
>
> With the patch below, the SL82C105 is configured for native mode and both IDE
> channels work. The patch applies to 2.4.21-pre2 as well, but there IDE seems to
> be broken on PPC in general.

I'd rather use a pci quirk here... also, why not make this generic to
all PPCs with a W83c553 ? I know the briQ at least will need something
similar.

Regarding 2.4.21-pre2, did you check the linuxppc_2_4 tree ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
