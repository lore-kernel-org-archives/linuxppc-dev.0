Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Daniel Berlin <dan@cgsoftware.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Wed, 14 Nov 2001 17:32:21 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111141713400.30166-100000@www.cgsoftware.com>
In-Reply-To: <Pine.LNX.4.33.0111141713400.30166-100000@www.cgsoftware.com>
MIME-Version: 1.0
Message-Id: <20011114222939.ITHJ7882.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

I am working my patch into Ben's tree right now and there are some changes
you made to set the default video mode specific to your powerbook that
won't be needed if the OF EDID thing works for you.  (hopefully not a big
if!)

Do you want me to leave them as is, or do you want me to remove just those
pieces so that you can give the of_edid approach a try since it should be
more generic?

It is your call.  Just let me know what you would prefer.

Either way is fine with me

Below is an example of what I mean.  If the EDID thing works then the
correct video mode will be calculated and stored right into the
radeonfb_default_var structure changing it from 640x480 to whatever your
EDID block specified.  This allows us to do the following:


static int radeon_init_disp_var (struct radeonfb_info *rinfo)
{

#ifdef __powerpc__
  if (use_OF_EDID) {

    /* use the default var modified by the EDID info */
    rinfo->disp.var = radeonfb_default_var;

    if (noaccel)
      rinfo->disp.var.accel_flags &= ~FB_ACCELF_TEXT;
            else
              rinfo->disp.var.accel_flags |= FB_ACCELF_TEXT;

    return 0;
  }
#endif


#ifndef MODULE
        if (mode_option)
                fb_find_mode (&rinfo->disp.var, &rinfo->info, mo\de_option,
                              NULL, 0, NULL, 8);
        else
#endif
#ifdef CONFIG_ALL_PPC
                if (machine_is_compatible("PowerBook3,3")) {
                        default_vmode = VMODE_1152_768_60;
                        default_cmode = CMODE_8;
                        if (mac_vmode_to_var(default_vmode,
defa\ult_cmode, &rinfo->disp.var))
                                rinfo->disp.var = radeonfb_defau\lt_var;
                }
                else
#endif

So your ifdef CONFIG_ALL_PPC case won't really be needed anymore.

Should I remove it or do you want that special case included?


Thanks,

Kevin


On November 14, 2001 05:14, Daniel Berlin wrote:
> On Wed, 14 Nov 2001, Benjamin Herrenschmidt wrote:
> > >No, I mean using i2c to grab it.
> >
> > I think OF uses the Radeon "GPIO" registers to probe the panel type
> > based on a wired panel ID and a table of EDIDs in the driver. At
> > least, it did it that way on mach64. I dumped a disassembly of the
> > Rage M3 (r128 base) MacOS 9 driver of my Pismo and started tracing it,
> > it seem to play with GPIOs as well. I didn't yet figure out the exact
> > algorithm though.
>
> Well, the GPIO's are used to control i2c as well (gpio 0 and 3, if i
> remember right), so it might just be a red herring.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
