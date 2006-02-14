Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 55F5567B32
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 04:01:43 +1100 (EST)
Date: Tue, 14 Feb 2006 09:01:40 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Ed Goforth <egoforth@gmail.com>
Subject: Re: 440gx GPIO
Message-ID: <20060214170140.GB12465@gate.ebshome.net>
References: <43F168A3.4020808@gmail.com>
	<20060214065934.GA12465@gate.ebshome.net>
	<75b39f010602140548u18f30145tf2ddf529467b2605@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75b39f010602140548u18f30145tf2ddf529467b2605@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2006 at 08:48:56AM -0500, Ed Goforth wrote:
> I posted the original from home, and didn't have the contents of the
> config register.  It is
> cfg     0x00103e00
> Which I interpret as having bit 11 set: "1 Enable GPIO11 as GPIO11"
> from the manual.
> 
> I originally tried to call ioremap64(PPC440GX_GPIO0_ADDR,) directly, but got
> "unresolved symbol ioremap64".  From inspection of ioremap(), the
> fixup for 0x40000700 translates to 0x140000700, and I get the same
> values in my code as I see from a "/proc/ocotea/gpio".
> 
> Is my approach valid?

It seems to be.

Try writing the same GPIO output register value as you read from it 
(without clearing bit 11). Also, try changing some other GPIO bit 
(e.g. one which is not connected in your design). Maybe board hangs 
exactly because you set GPIO bit 11 low :).

Also, connect scope to that GPIO pin and see what is really going on. 

-- 
Eugene
