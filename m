Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C85C@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'Dr. Craig Hollabaugh'" <craig@hollabaugh.com>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 4 bit LCD interface on 823e not working
Date: Mon, 26 Aug 2002 23:16:49 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using port D[0-3] (PD12-15) for data. FLM, CP and LP are coming from
PD[5,4,3]
It's a passive monochrome display. I've configured it as such. It should be
working.
(See Fig 18-4 in the book) It came with an 8 bit color NEC display that
worked, so I'm assuming there's a valid config already. I've checked PD_DIR
and _PAR and they all seem to be correct.

My problems may or may not be related to the driver. It makes a horrible
assumption that the color map is as deep as the display depth. This is
normally true, but not for the 823e. 16 values must be programmed into the
cmap. Maybe this is why my bits aren't coming out right. I'm attempting to
adjust the driver to match*, but now my display doesn't even work
incorrectly. :-(

* I went into fbcmap.c and made a 3 new arrays and a new structure.
red[16]={0}, green[16]={0}, blue[16]={0..15}. (See 18-3 in the manual)
Blue's bits line up with 'GLC' when in not-color modes. (Transp is for
displays that have RGBA) Then I packed it into a fb_cmap struct called
default_mono and made the necessary changes where I thought they were needed
(fb_default_cmap()).

Adding to my confusion is 'int con' is passed into numerous functions in
lcd832e.c but is never explained and I can't tell where it's coming from.

Why or how a 1 bpp connection needs a 16 entry palette is beyond me.
Any help on this issue is greatly appreciated!

-Jason

-----Original Message-----
From: Dr. Craig Hollabaugh [mailto:craig@hollabaugh.com]
Sent: Monday, August 26, 2002 3:34 PM
To: Hihn Jason; Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)
Subject: Re: 4 bit LCD interface on 823e not working


>I'm digging in the 823e book for any registers that may need to be changed.
>-Jason


Which port are you using?
How are you configuring it?
Do you have the all the peripherals turned off?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
