From: David Jander <david.jander@protonic.nl>
To: "Hager, Johannes, HRD/AB" <johannes.hager@lfk.eads.net>
Subject: Re: AW: Compiling glibc-2.3.2 (debian) on mpc8xx ;-)
Date: Tue, 9 Mar 2004 14:03:31 +0100
References: <2D9AB865A49FD511914700105A0EF679016C4909@morse.smart.lfk.eads.net>
In-Reply-To: <2D9AB865A49FD511914700105A0EF679016C4909@morse.smart.lfk.eads.net>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403091403.31151.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 09 March 2004 10:20, you wrote:
> Dear David,
> sadly I have got no answer to your question, but I want to ask you
> something:
> Are you using U-Boot for starting Linux?
> If you do, can you give me a short roadmap, how to port to new
> board?

Yes, we are using u-boot.
Well, here's a list of suggestions based on what we did:
1.- Read the README of u-boot.
2.- Assuming there are already other boards with the same CPU and at least a
more or less similar setup that are supported, pick one of them, and copy the
directory boards/xxxx to boards/yyyy (where yyyy is the name of your board).
3.- Go to include/configs and make a copy of the xxxx.h file. Don't forget to
add your board also to the Makefile.
4.- Watch out for special stuff for the board you are using as start, it could
get in your way.
5.- Check if the xxxx's config and board support files are indeed a good
starting point (clean documented sources, using the newest format of config
files and most important, get to fully understand the source).
6.- Look at several other examples to pick up ideas and learn from the
sources.
7.- Configure your board with the design information, and from what you
learned reading README and the examples.
8.- Leave SDRAM configuration for later (assuming you use a MPC8xx processor,
where SDRAM is a special issue), and look if you get something out of your
serial port first.
9.- Use Jtag or BDM interfaces to place the bootloader into flash.
(We used a homebrewed Jtag interface to program the on-board flash, although
everyone and ther brother in this list will probably say that you MUST do it
with the BDI2000 from abatron via the BDM port).
10.- Have a Scope at hand to examine the CS and address lines (if at all
possible). This may help to see what's going on before the serial port comes
into play.
11.- If you have a mpc8xx processor, read the technical notes from Micron
about how to interface SDRAM to the MPC8xx, and how to program the UPM
correctly. There's a tool from Motorola that let's you draw the waveforms on
screen and obtain the corresponding byte-code for the UPM. This might be
handy. Again look at and learn from what others did.

Good Luck!

Best regards,

--
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1628 AL Zwaag

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
