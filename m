Date: Mon, 20 Mar 2000 11:12:18 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: michdaen@iiic.ethz.ch
cc: "James B. Parker" <pajama1@mindspring.com>,
        LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86 4.0 (mach stuff)
In-Reply-To: <20000320095225.4833.qmail@web110.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10003201056060.3889-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Beige G3 (rev 2) Rage Pro chip (onboard) w/6mb vram
>
> So it isn't only a Lombard issue *sigh*

Apparently not. But let's wait for his lspci log.

I've done a bit more homework and located the spots inside atyfb where the
kernel crashes when running XFree86 without -probeonly. Code snippets
below, the bottom line: the first register access on the card fails.
(My interpretation of the xmon output and the disassembly is more than
only part lucky guess but it's been confirmed with trace messages from the
kernel). The machine drops into xmon and I could perhaps poke around in
the PCI bridge if someone could explain how exactly to do that from xmon.
The test was made without the busid option set, but the X server
apparently managed to mangle the PCI setup anyway - the whole colormap and
cursor color functions were just fine up to the moment where X
switches the console and starts up.

The source:

static void
aty_set_cursor_color(struct fb_info_aty *fb, u8 *pixel,
                     u8 *red, u8 *green, u8 *blue)
{
        struct aty_cursor *c = fb->cursor;
	int i;

        if (!c)
                return;

#ifdef __sparc__
        if (fb->mmaped && (!fb->fb_info.display_fg
            || fb->fb_info.display_fg->vc_num == fb->vtconsole))
		return;
#endif

        for (i = 0; i < 2; i++) {
		c->color[i] =  (u32)red[i] << 24;
      		c->color[i] |= (u32)green[i] << 16;
                c->color[i] |= (u32)blue[i] <<  8;
       		c->color[i] |= (u32)pixel[i];
	}

	wait_for_fifo(2, fb);				<----- in here
        printk("aty_set_cursor_color: write regs\n");
 	aty_st_le32(CUR_CLR0, c->color[0], fb);
		  aty_st_le32(CUR_CLR1, c->color[1], fb);
}


static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int
blue,
                           u_int transp, struct fb_info *fb)
{
    struct fb_info_aty *info = (struct fb_info_aty *)fb;
    int i, scale;

    if (regno > 255)
        return 1;
    red >>= 8;
    green >>= 8;
    blue >>= 8;
    info->palette[regno].red = red;
    info->palette[regno].green = green;
    info->palette[regno].blue = blue;
    i = aty_ld_8(DAC_CNTL, info) & 0xfc;		<--- here
    if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx == GV_CHIP_ID ||
        Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx == LG_CHIP_ID ||
        Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx == GI_CHIP_ID ||
        Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
        i |= 0x2;       /*DAC_CNTL|0x2 turns off the extra brightness for gt*/
    printk("atyfb_setcolreg: write DAC_CNTL\n");
    aty_st_8(DAC_CNTL, i, info);
    aty_st_8(DAC_MASK, 0xff, info);
    scale = ((Gx != GX_CHIP_ID) && (Gx != CX_CHIP_ID) &&
             (info->current_par.crtc.bpp == 16)) ? 3 : 0;
    printk("atyfb_setcolreg: write lut regs\n");
    info->aty_cmap_regs->windex = regno << scale;
    eieio();
    info->aty_cmap_regs->lut = red;
    eieio();
    info->aty_cmap_regs->lut = green;
    eieio();
    info->aty_cmap_regs->lut = blue;
    eieio();

    [...]


> > Well, the build took its usual length of time but I don't think everything
> > was built.  Major bin files seem to be missing.  My x86 installation is
> > based on the Redhat 6.0 install from Summer.
>
> Which has 3.3.x I suppose. Lots of things have changes in 4.0, maybe those
> bin files aren't needed anymore or are somewhere else? Which ones are you
> referring to?

And did you just install the new xfree over the old files, instead of into
a new directory? I kept my 3.3.x installation untouched (except for 4.0
trampling over /etc/X11/) for good reason :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
