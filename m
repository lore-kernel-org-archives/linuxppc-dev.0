Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 5BAC867A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 06:55:48 +1100 (EST)
To: "=?iso-8859-1?Q?francois.ruvoen@libertysurf.fr?="
	<francois.ruvoen@libertysurf.fr>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Feb 2005 11:10:36 +0100."
	<IBJDLO$2F7CB4091C41824099E5E47AB0570FD3@tiscali.fr>
Date: Mon, 07 Feb 2005 20:55:15 +0100
Sender: wd@denx.de
Message-Id: <20050207195520.D8B4DC108D@atlas.denx.de>
Cc: =?iso-8859-1?Q?linuxppc-embedded?= <linuxppc-embedded@ozlabs.org>
Subject: Re: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Francois,

in message <IBJDLO$2F7CB4091C41824099E5E47AB0570FD3@tiscali.fr> you wrote:
>
> I have been playing with the CoralP, Icecube and Debian.
> Works fine, thanks to the tutorial on the Denx site.
> I now would like to see the microwindows stuff working. I

This will not work. Microwindows can only  use  a  plain  framebuffer
interface,  but  the Coral-P does not allow for such a driver because
of the fact that it has a little-endian register interface.  For  the
frameboffer,  each color is defined by a bit offset and the number of
(contiguous bits) in a data word. For example, assuming a color depth
of 16 bpp you could have something like this:

	MSB          LSB
	rrrrrrgggggbbbbb

In this case the "green" color has bit offset 5 and is 5  bits  wide,
while  "red" has offset 10 and is 6 bits wide. On the Coral-P you see
the bytes swapped, i. e.

	MSB          LSB
	gggbbbbbrrrrrrgg

The "green" bits are  split  into  two  non-contiguous  groups  which
cannot  be  desribed  in  the  way  it  is  needed  for a framebuffer
interface.

You will need a custom graphics driver which  swaps  all  color  data
that  get  written  to  the  Coral-P.  Standard Microwindows does not
support this mode of operation.

> have been trying the demos from the ELDK but I get strange
> colors, it seems my palette is all wrong. The same happens

Yes, this is the effect explained above.

> when I recompile the latest version of microwindows (except
> I get yet another palette).

Again, thisis only to be expected.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1
