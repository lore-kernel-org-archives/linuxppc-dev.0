Return-Path: <egoforth@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.205])
	by ozlabs.org (Postfix) with ESMTP id A634767A41
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 00:48:58 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s13so789446wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 05:48:56 -0800 (PST)
Message-ID: <75b39f010602140548u18f30145tf2ddf529467b2605@mail.gmail.com>
Date: Tue, 14 Feb 2006 08:48:56 -0500
From: Ed Goforth <egoforth@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 440gx GPIO
In-Reply-To: <20060214065934.GA12465@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43F168A3.4020808@gmail.com>
	<20060214065934.GA12465@gate.ebshome.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I posted the original from home, and didn't have the contents of the
config register.  It is
cfg     0x00103e00
Which I interpret as having bit 11 set: "1 Enable GPIO11 as GPIO11"
from the manual.

I originally tried to call ioremap64(PPC440GX_GPIO0_ADDR,) directly, but go=
t
"unresolved symbol ioremap64".  From inspection of ioremap(), the
fixup for 0x40000700 translates to 0x140000700, and I get the same
values in my code as I see from a "/proc/ocotea/gpio".

Is my approach valid?

Thanks,
Ed

On 2/14/06, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Tue, Feb 14, 2006 at 12:20:35AM -0500, Ed Goforth wrote:
> > I am struggling with a problem and I hope someone can give me some
> > pointers.  We have a custom board with a 440gx.  I need to drive GPIO11
> > low.  The best as I can tell from the docs, I need to set bit 11 of the
> > TCR to 1 and bit 11 of the OR to 0 to do this.
>
> Check that this pin is enabled as GPIO not as a function pin
> (SDR0_PFC0 register).
>
> Also, just to be sure that you remapped GPIO registers correctly, use
> ioremap64 with full physical address (not just low 32 bits).
>
> --
> Eugene
>
>
