Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.yellowdoglinux.com,
	Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: new G4 dual 1 gig is here - how to install?
Date: Sat, 16 Feb 2002 04:30:29 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.BSF.4.44.0202131947110.42574-100000@shell.unixbox.com> <20020215110330.PVOP20323.tomts20-srv.bellnexxia.net@there>
In-Reply-To: <20020215110330.PVOP20323.tomts20-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

BTW I just finished building XF4.2.0 in under 45 min from scratch with
just one CPU on my new box and fired it up and it works just fine out of
the box.

We really need to write a USB daemon to allow the "Brightness" button to
work on the DFP monitors from Apple.

The only way I could seem to reduce the brightness was to use the Gamma
0.50 setting in the XF86Config-4 file to reduce the gamma

Ani/Ben I will try to send you whatever patches are needed for radeonfb.c
for the 7500 (once I clean up my hacks) so that you can see what I had to
do.

Now on to SMP kernel testing!

Thanks for everyone's HELP!

Thanks,

Kevin

On February 15, 2002 06:08, Kevin B. Hendricks wrote:
> Hi Ani,
>
> A couple of problems.
>
> 1. Checking the BIOS scratch register
>
>  tmp = INREG(RADEON_BIOS_4_SCRATCH);
>
>         if (rinfo->hasCRTC2) {
>                 /* primary DVI port */
>                 if (tmp & 0x08)
>                         rinfo->dviDisp_type = MT_DFP;
>
> To determine which port on a 7500 is actualy being used does not work on
> PPC, so we have to use the OF names and look in the tree to dtermine
> which port is working somehow.  Question is how?
>
> 2. For some reason I keep getting the following failure message:
>
>                          default:
>                                 printk("radeonfb: Failed to detect DFP
> panel size\n");
>                                 return 0;
>
> which means:
>
>         if (radeon_dfp_parse_EDID(rinfo))
>                 radeon_update_default_var(rinfo);
>
>         if (!rinfo->got_dfpinfo) {
>
> Somehow rinfo->got_dfpinfo is not being set (yet a received no warning
> messages about EDID not being detected).
>
> The OF device tree does have the "EDID" block but for some reason it is
> not being found properly (the dual head issue of the 7500 leading to two
> different device tree nodes?) or not being parsed properly.
>
> But I never received the following message:
>
>         if (!radeon_get_EDID_OF(rinfo))
>                 RTRACE("radeonfb: could not retrieve EDID from OF\n");
>
>
> And I never received this message either:
>
>         printk("radeonfb: detected DFP panel size from EDID: %dx%d\n",
>                 rinfo->panel_xres, rinfo->panel_yres);
>
>         rinfo->got_dfpinfo = 1;
>
>
> And instead I always get just The "Failed to detect DFP panel size"
>
> I can't figure it out.
>
> I will add some more debug print statements so that I can actually see
> what is messing up.
>
> Thanks,
>
> Kevin
>
> On February 13, 2002 10:53, Ani Joshi wrote:
> > On Wed, 13 Feb 2002, Kevin B. Hendricks wrote:
> > > 2.  The bad news is that my ATI 7500 with my flat panel display
> > > simply goes black so I can't tell exactly what is detected or not.
> >
> > You will need to check if the OpenFirmware pll probing code I use in
> > radeonfb works on 7500.  Look in the device-tree node and see what the
> > reference clock is.  If you look in radeon_get_pllinfo() you can see
> > the OF probe code there.  IIRC on x86 7500 boards, the xclk is ~
> > 22000, the ref div is 12 and reference clock is 2700 i belive.  The
> > 7500 is supported on x86 btw.
> >
> > If you can log in and get a bootlog that would be helpful.
> >
> >
> > ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
