To: Kate Alhola <kate@iti.fi>
Cc: Tord Andersson <Tord.Andersson@combitechsystems.com>,
	linuxppc-embedded@lists.linuxppc.org,
	u-boot-users@lists.sourceforge.net
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage now working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Nov 2003 10:03:30 +0200."
             <3FAB51D2.104@iti.fi>
Date: Fri, 07 Nov 2003 12:57:22 +0100
Message-Id: <20031107115727.CAD69C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FAB51D2.104@iti.fi> you wrote:
>
> >Thanks for sharing your experiences with the MPC5200Lite card.
> >Would it be possible for you to explain the steps you took to replace
> >dbug with u-boot. Did you use dbug or a bdm?
> >I am about to do the same thing, and fear that I might end up with a
> >"dead" card if
> >things go wrong : )
> >
> I actually did not eplace it all. I just compiled and programmed u-boot
> to flash in diferent
> address than 0xfff00000 I used 0xff800000 but it is not a good choice

This is not an optimal way to solve this.

I just checked in patches  for  U-Boot  to  allow  for  a  "low-boot"
configuration,  i.  e.  you  can configure and built U-Boot using the
commands "make MPC5200LITE_LOWBOOT_config;make all" and then  program
it at the low end of the flash (0xFF000000). After switching the boot
high/low  jumper  ("B  H/L") the board will boot directly into U-Boot
and all you need to switch back to dBUG is to switch the jumper back.

It may take a while until the new version of U-Boot shows up  on  the
CVS  server; the patch against U-Boot version 1.0.0 is also available
at ftp://ftp.denx.de/pub/u-boot/lowboot-1.0.0.patch.gz


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
: ... and it's got weird formatting - Notepad, Write, Works  3  can't
: decipher it, and it's too big to go in DOS Edit. Help!
Install an operating system. :-)                  -- Tom Christiansen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
