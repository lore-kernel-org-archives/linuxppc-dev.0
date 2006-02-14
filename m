Return-Path: <egoforth@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id E0E2867B3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 04:10:37 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s19so832353wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 09:10:36 -0800 (PST)
Message-ID: <75b39f010602140910v39bc60dcxeba0acb6065a4bbd@mail.gmail.com>
Date: Tue, 14 Feb 2006 12:10:15 -0500
From: Ed Goforth <egoforth@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 440gx GPIO
In-Reply-To: <20060214170140.GB12465@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43F168A3.4020808@gmail.com>
	<20060214065934.GA12465@gate.ebshome.net>
	<75b39f010602140548u18f30145tf2ddf529467b2605@mail.gmail.com>
	<20060214170140.GB12465@gate.ebshome.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/14/06, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Tue, Feb 14, 2006 at 08:48:56AM -0500, Ed Goforth wrote:
> > I posted the original from home, and didn't have the contents of the
> > config register.  It is
> > cfg     0x00103e00
> > Which I interpret as having bit 11 set: "1 Enable GPIO11 as GPIO11"
> > from the manual.
> >
> > I originally tried to call ioremap64(PPC440GX_GPIO0_ADDR,) directly, bu=
t got
> > "unresolved symbol ioremap64".  From inspection of ioremap(), the
> > fixup for 0x40000700 translates to 0x140000700, and I get the same
> > values in my code as I see from a "/proc/ocotea/gpio".
> >
> > Is my approach valid?
>
> It seems to be.

At least I've got that. :)

>
> Try writing the same GPIO output register value as you read from it
> (without clearing bit 11). Also, try changing some other GPIO bit
> (e.g. one which is not connected in your design). Maybe board hangs
> exactly because you set GPIO bit 11 low :).

I have successfully written back the same values that were read from
it.  I will try your suggestion about fiddling with other GPIO bits
that we aren't (supposed to be) using.

>
> Also, connect scope to that GPIO pin and see what is really going on.
>
> --
> Eugene
>

Thanks,
Ed
