Date: Thu, 21 Sep 2000 16:08:13 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paolo Scaffardi <arsenio@tin.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Custom serial keyboard: playing dirty with the serial console
In-Reply-To: <003601c02397$670ccd60$0a00010a@paoloweb>
Message-ID: <Pine.LNX.4.10.10009211607280.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Sep 2000, Paolo Scaffardi wrote:
> We have a custom IR keyboard & mouse, that i have attached to the serial
> port of my board (i have an embedded powerpc). Its protocol is called 4PPM,
> and i had to write a driver that intercepts these serial characters, decodes
> and convert them to standard XT scancodes.
>
> Serial routines were implemented, yet, and i decided to 'insert' my 4PPM
> layer inside of the serial console driver.
>
> Everything is now ok: i receive correct packets, convert them to XT
> scancodes and call 'handle_scancode' to process them.

handle_scancode() is indeed the correct routine to feed scancodes into the
system.

> But 'handle_scancode' only prints characters to the console, without
> apparently processing them. I see everything i write, but when i press enter
> (scancode 0x1c), i only see a new line in the console, not any new bash
> prompt.
>
> Why this? Is it correct to intercept the serial console and not returning
> single characters from inside it but from 'handle_scancode' mode?

Are you in serial console mode, or in normal console mode?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
