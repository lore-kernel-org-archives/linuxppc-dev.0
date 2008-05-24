Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 4A22ADDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 16:25:51 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so242446anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:25:48 -0700 (PDT)
Message-ID: <fa686aa40805232325w65d4f706i50798121a8cce263@mail.gmail.com>
Date: Sat, 24 May 2008 00:25:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 3/4] spi: Add OF binding support for
	SPI busses
In-Reply-To: <200805221926.24112.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
	<fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
	<200805221926.24112.david-b@pacbell.net>
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 8:26 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 21 May 2008, Grant Likely wrote:
>> > spi-controller {
>> >        #address-cells = 2;
>> >        #size-cells = 0;
>> >        some-device@0,f000 { reg = < 0 f000 >; } // CS 0, SPI address f000
>> >        some-device@1,f000 { reg = < 1 f000 >; } // CS 1, SPI address f000
>> >        some-device@1,ff00 { reg = < 1 ff00 >; } // CS 1, SPI address ff00
>> > }
>>
>> For SPI the CS # *is* the address.  :-)
>>
>> Unlike I2C, SPI doesn't impose any protocol on the data.  It is all
>> anonymous data out, anonymous data in, a clock and a chip select.
>
> Very true ... but then there are SPI chips which embed addressing.
>
> I have in mind the mcp23s08 (and mcp23s17) GPIO expanders, which
> support up to four chips wired in parallel on a given chipselect.
> The devices are distinguished by how two address pins are wired;
> and two bits in the command byte must match them.  (I think they
> just recycled an I2C design into the SPI world.)

Very good point.  Okay, so we cannot assume any correlation between
the number of CS lines and the number of child nodes to the SPI bus.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
