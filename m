Date: Tue, 25 Feb 2003 13:43:54 -0500
From: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA out/External Monitor on ibook 2 --Success!!
Message-ID: <20030225184354.GA16054@haar.ae.gatech.edu>
References: <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de> <1044898053.10697.27.camel@thor>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <1044898053.10697.27.camel@thor>; from michel@daenzer.net on Mon, Feb 10, 2003 at 12:27:33 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I finally managed to get the VGA out working at depth 15
along-with higher resolution!! The behaviour is not completely
satisfactory, but here is a brief summary:

1. Initialize CRTC2 by pretty much copying CRTC1 values. CRTC2_GEN_CNTL is
the only one not identical to its CRTC1 counterpart.

2. Ditto for P2PLL.

3. Make sure DAC is set to CRTC2 (this is the OF default if you boot with
the monitor plugged in.)

4. (This one took some time:) Copy dda_config and dda_on_off values to
dda2_config and dda2_on_off. While debugging this, I realized that the
IBook's video memory is not 128-bit SDR SGRAM but 64-bit (sdr_64 in
aty128fb).


The problems that still remain: depths > 16 lead to screen corruption.
This could still be a dda_config/dda_on_off issue. I really have no idea
on this.
Then, at higher (than 1024x768) resolutions, the display on the external
montitor does not span the width of the monitor. Plan to look into this
during the next available free time :)


Thanks for your input.

manuj


On Feb 10, 2003  12:27 Monday Michel Dänzer wrote:
> On Mon, 2003-02-10 at 17:24, Michael Schmitz wrote:
> >
> > I'd talk to Michel Dänzer about this. The XFree people might have
> figured
> > something out on other (i386) architectures. XFree developers have
> access
> > to at least some ATI docs.
>
> The XFree86 radeon driver has indeed solved this by using both CRTCs.
> The code is there for everyone to look at. ;)
>
>
> --
> Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
> XFree86 and DRI project member   /  CS student, Free Software enthusiast
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
