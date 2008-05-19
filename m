Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id ECCFADDFCB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 01:57:23 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so567564anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 08:57:22 -0700 (PDT)
Message-ID: <fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
Date: Mon, 19 May 2008 09:57:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <Pine.LNX.4.64.0805191446530.27140@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 7:17 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 16 May 2008, Grant Likely wrote:
>
>> +    However, the binding does not attempt to define the specific method for
>> +    assigning chip select numbers.  Since SPI chip select configuration is
>> +    flexible and non-standardized, it is left out of this binding with the
>> +    assumption that board specific platform code will be used to manage
>> +    chip selects.  Individual drivers can define additional properties to
>> +    support describing the chip select layout.
>
> Yes, this looks like a problem to me. This means, SPI devices will need
> two bindings - OF and platform?... Maybe define an spi_chipselect
> OF-binding?

Actually, spi devices have *neither*.  :-)  They bind to the SPI bus.
Not the platform bus or of_platform bus.  But that is Linux internal
details; this discussion is about device tree bindings.

Note that I did say that drivers can define additional properties for
supporting chip select changes as needed.  I'm just not attempting to
encode them into the formal binding.  There is simply just too many
different ways to manipulate chip select signals and so I don't feel
confident trying to define a *common* binding at this moment in time.
At some point in the future when we have a number of examples to
choose from then we can extend this binding with chip select related
properties.

As for the Linux internals, the 5200 SPI bus driver that I posted
exports a function that allows another driver to call in and
manipulated the CS lines before the transfer.  It isn't the prettiest
solution, but I'm not locked into the approach and that gives some
time to consider cleaner interfaces.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
