Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 9B596DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 13:43:56 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so723084anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 19:43:55 -0700 (PDT)
Message-ID: <fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
Date: Wed, 2 Apr 2008 20:43:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
In-Reply-To: <200804030134.11437.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
	<200804030134.11437.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 03 April 2008, John Linn wrote:
>  > The Xilinx 16550 uart core is not a standard 16550 because it uses
>  > word-based addressing rather than byte-based addressing. With
>  > additional properties it is compatible with the open firmware
>  > 'ns16550' compatible binding.
>  >
>  > This code updates the of_serial driver to handle the reg-offset
>  > and reg-shift properties to enable this core to be used.
>  >
>  > Signed-off-by: John Linn <john.linn@xilinx.com>
>
>  I may not be the best driver maintainer, but please keep the illusion
>  alive for me and Cc me on patches to drivers I wrote ;-)
>
>
>  > diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>  > index 87f4d84..4066ec8 100644
>  > --- a/Documentation/powerpc/booting-without-of.txt
>  > +++ b/Documentation/powerpc/booting-without-of.txt
>  > @@ -2539,6 +2539,16 @@ platforms are moved over to use the flattened-device-tree model.
>  >                        differ between different families.  May be
>  >                        'virtex2p', 'virtex4', or 'virtex5'.
>  >
>  > +      iv) Xilinx Uart 16550
>  > +
>  > +      Xilinx UART 16550 devices are very similar to the NS16550 but with
>  > +      different register spacing and an offset from the base address.
>  > +
>  > +      Requred properties:
>  > +       - clock-frequency : Frequency of the clock input
>  > +       - reg-offset : A value of 3 is required
>  > +       - reg-shift : A value of 2 is required
>  > +
>  >     More devices will be defined as this spec matures.
>
>  Since it is not really compatible with ns16550, shouldn't you at least specify
>  a different "compatible" property? That way, the driver won't do incorrect
>  accesses when you try to use an old driver with a device tree that specifies
>  one of these.

Heh; we've gone back and forth on this issue.  The problem is that we
have a common case of ns16550 like devices that require a little bit
of register address tweaking that spans a whole range of vendors (so
adding a compatible match with each of those vendor's prefixes is
probably non-scalable).  So, if "ns16550" is not a good idea, then
what should be used?  "sparse16550" has been suggested more than once.

On the other side of the coin; the draft ePAPR spec already redefines
the meaning of "ns16550" to add an optional "reg-shift" property.
Also, in this particular case the problem is most likely more
theoretical than actual.  The likely hood of a platform needing these
new properties being handed a kernel which does not support the
"reg-*" properties is very slim.

Anyway, all that just to say that I prefer "ns16550", but I'll put my
vote and support behind "sparse16550" (or any other string) if other
people express consensus with it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
