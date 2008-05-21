Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id D8331DEC91
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 05:33:40 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1689297ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 12:33:31 -0700 (PDT)
Message-ID: <fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
Date: Wed, 21 May 2008 13:33:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
	<fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
	<Pine.LNX.4.64.0805191811510.29559@axis700.grange>
	<fa686aa40805192213y485c4ba2u750748f8201e0377@mail.gmail.com>
	<Pine.LNX.4.64.0805201650280.5283@axis700.grange>
	<716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	spi-devel-general@lists.sourceforge.net,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 1:11 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> Ok, elegance apart:-) You can use the SPI-bridge construct to also
>> describe simple SPI-chipselect configurations. But is it really a good
>> idea? Wouldn't it be better to handle these two cases separately?
>
> It would be best to handle all these things that are specific to
> a certain SPI controller (like how CSs work) in the binding for
> that SPI controller, and not try to shoehorn all of this into some
> artificial generic framework.
>
> If you can have identical addresses on the SPI bus going to different
> devices based on which CS is asserted, you'll have to make the CS part
> of the "reg".  Example:
>
> spi-controller {
>        #address-cells = 2;
>        #size-cells = 0;
>        some-device@0,f000 { reg = < 0 f000 >; } // CS 0, SPI address f000
>        some-device@1,f000 { reg = < 1 f000 >; } // CS 1, SPI address f000
>        some-device@1,ff00 { reg = < 1 ff00 >; } // CS 1, SPI address ff00
> }

For SPI the CS # *is* the address.  :-)

Unlike I2C, SPI doesn't impose any protocol on the data.  It is all
anonymous data out, anonymous data in, a clock and a chip select.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
