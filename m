Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: aty128fb and EDID
Date: Mon, 10 Feb 2003 08:16:36 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <200302091940.10202.kevin.hendricks@sympatico.ca> <Pine.GSO.4.21.0302101034180.25020-100000@vervain.sonytel.be> <20030210111453.52322aba.damm@opensource.se>
In-Reply-To: <20030210111453.52322aba.damm@opensource.se>
MIME-Version: 1.0
Message-Id: <200302100816.36075.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I found the code to decode the full block from a variety of source (X11 had
some of it).  The problem is the "established timings" block was empty in
my EDID block (or I made a big mistake someplace).

My primary concern was just getting my DFP to work at all at the time.

I will dig up what I have about timings and post it if anyone wants it.

Kevin

On February 10, 2003 05:14, Magnus Damm wrote:
> > > Steal the code from the radeon dirver in the kernel.  It finds and
> > > parses the EDID block in OF for ppc linux systems for LCD.
>
> Yes, thanks. That's the short-term solution.
> The problem is that the radeon driver only parses the "detail timings".
> I want to support all timings including "established timings" and
> "detailed timings".
> And then it gets more complex...
>
> > I guess you actually meant:
> > | Move the code out of the radeon driver and make it sufficiently
> > | generic so it can be used by the aty128 and other drivers?
>
> Yes. Here's my grand plan:
>
> 1. Rearrange modes from modedb.c/macmodes.c into separate files for:
>    * Standard VGA modes
>    * Tweaked VGA modes (modex)
>    * VESA modes
>    * Archtecture-specific modes
>    (* A mode calculator)
>    This includes adding add/remove functions to be able to insmod/rmmod
>    modules runtime.
>
> 2. Add EDID parsing code.
>    The code should be able to list "established timings" and "standard
> timings". Modes should be built from "detail timings".
>    Getting the EDID structure could be done in several ways:
>    * Through Open Firmware (mac and maybe others)
>    * Through the BIOS
>    * Via I2C bitbanging (requires special support by the fb-driver)
>
> 3. Add code that gets information from the EDID parser and looks through
> the modes available and then creates a list of supported modes.
>
> 4. Add architecture-specific code that looks up the model and then
> returns a list of supported modes. This should be used if the machine
> doesn't have EDID information. (See aty128db.c and
> machine_is_compatible()).
>
> 5. Add code that takes the modes from 3 or 4 above and throws it at the
> fb-driver that looks them through and marks the supported modes with
> what colour- depths that are supported.
>
> 6. Add a "mode" variable for each framebuffer.
>    This should make it possible to switch between the following states:
>    * Safe - only modes that are listed by the monitor are accepted.
>    * Standard - old standard modes that might work
>    * Expert - funky timings that might blow your monitor
>    The "Safe" mode is default.
>    I don't know yet how the "mode"-variable should be controlled. /proc?
>
> 7. Add support to(/from) vga=ask. The user should be able to switch
> between the modes listed in 6 above.
>
> And then we have VDIF... Feedback is very welcome.
>
> / magnus
>
> BTW: I found some EDID data here:
> http://www.google.com/search?hl=sv&ie=UTF-8&oe=UTF-8&q=EDID+site%3Aftp.p
>enguinppc.org&lr=


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
