From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Date: Thu, 23 Mar 2000 13:16:37 -0500
Content-Type: text/plain
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com>
In-Reply-To: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com>
MIME-Version: 1.0
Message-Id: <00032313263100.01328@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani and Kostas,


> ErrorF or xf86DrvMsg the var struct before and after a mode switch, then
> see whats wrong.

Okay, here is all the snippets I think you need to see what is going on.

AFAICT everything looks to be okay.

It's almost like we are missing a pixel cache flush or engine flush or
something along those lines.

I current have 3 modes in my XF86Config.  If I put only one mode on the mode
line then I can successfully startx properly into that mode.  If however, I put
all three modes on one line (allow SwitchMode to work) then only the first mode
(the highest resolution works, the lower resolutions do not).

Here are the snippets from the log for switching modes from 1152x870 (the
working mode) to 832x624 (bad) then to 1024x768 (again bad) and once more back
to 1152x870.

Any ideas here?  Do we need something like an engine reset or flush in
aty128fb_set_var?


Here is the log snippet:

fbdevHW: SwitchMode 0
xfree new mode: 57591   832 885 949 1152   624 625 628 667
fbdev before mode:      9999   1152 53 128 123   870 3 3 39   32 8:8:8
fbdev after mode:       17364   832 53 64 203   624 1 3 39   32 8:8:8
fbdevHW: AdjustFrame 0
fbdevHW: SwitchMode 0
xfree new mode: 78747   1024 1056 1152 1312   768 769 772 800
fbdev before mode:      17364   832 53 64 203   624 1 3 39   32 8:8:8
fbdev after mode:       12698   1024 37 96 155   768 1 3 28   32 8:8:8
fbdevHW: AdjustFrame 0
fbdevHW: SwitchMode 0
xfree new mode: 100001   1152 1205 1333 1456   870 873 876 915
fbdev before mode:      12698   1024 37 96 155   768 1 3 28   32 8:8:8
fbdev after mode:       9999   1152 53 128 123   870 3 3 39   32 8:8:8
fbdevHW: AdjustFrame 0


Here are the print routines so that you can see what is being printed above:

static void
print_fbdev_mode(char *txt, struct fb_var_screeninfo *var)
{
        ErrorF( "fbdev %s mode:\t%d   %d %d %d %d   %d %d %d %d   %d %d:%d:%d\n"
,
                txt,var->pixclock,
                var->xres, var->right_margin, var->hsync_len, var->left_margin,
                var->yres, var->lower_margin, var->vsync_len, var->upper_margin,
                var->bits_per_pixel,
                var->red.length, var->green.length, var->blue.length);
}

static void
print_xfree_mode(char *txt, DisplayModePtr mode)
{
        ErrorF( "xfree %s mode:\t%d   %d %d %d %d   %d %d %d %d\n",
                txt,mode->Clock,
                mode->HDisplay, mode->HSyncStart, mode->HSyncEnd, mode->HTotal,
                mode->VDisplay, mode->VSyncStart, mode->VSyncEnd, mode->VTotal);
}


Here is the routine that literally loads the new mode info so you can see how
the calculations from SyncStart to margins and etc are being done:

 static void
xfree2fbdev_timing(DisplayModePtr mode, struct fb_var_screeninfo *var)
{
        var->xres = mode->HDisplay;
        var->yres = mode->VDisplay;
        if (var->xres_virtual < var->xres)
                var->xres_virtual = var->xres;
        if (var->yres_virtual < var->yres)
                var->yres_virtual = var->yres;
        var->xoffset = var->yoffset = 0;
        var->pixclock = mode->Clock ? 1000000000/mode->Clock : 0;
        var->right_margin = mode->HSyncStart-mode->HDisplay;
        var->hsync_len = mode->HSyncEnd-mode->HSyncStart;
        var->left_margin = mode->HTotal-mode->HSyncEnd;
        var->lower_margin = mode->VSyncStart-mode->VDisplay;
        var->vsync_len = mode->VSyncEnd-mode->VSyncStart;
        var->upper_margin = mode->VTotal-mode->VSyncEnd;
        var->sync = 0;
        if (mode->Flags & V_PHSYNC)
                var->sync |= FB_SYNC_HOR_HIGH_ACT;
        if (mode->Flags & V_PVSYNC)
                var->sync |= FB_SYNC_VERT_HIGH_ACT;
        if (mode->Flags & V_PCSYNC)
                var->sync |= FB_SYNC_COMP_HIGH_ACT;
#if 0
        if (mode->Flags & V_BCAST)
                var->sync |= FB_SYNC_BROADCAST;
#endif
        if (mode->Flags & V_INTERLACE)
                var->vmode = FB_VMODE_INTERLACED;
        else if (mode->Flags & V_DBLSCAN)
                var->vmode = FB_VMODE_DOUBLE;
        else
                var->vmode = FB_VMODE_NONINTERLACED;
}


Everything seems to be alright to me.  I think we are just missing some sort of
flush or reset in the aty128fb set_var routine?  It is interesting to note,
that the r128 code in its SwitchMode (not usig FBDev) literally reloads all of
the registers and does a full R128EngineInit.

Ideas here?

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
