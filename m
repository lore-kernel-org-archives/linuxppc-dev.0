Date: Fri, 13 Oct 2000 17:42:05 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <19340907141507.13024@192.168.1.10>
Message-ID: <Pine.A41.3.96LJ1.1b7.1001013173038.60708A-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Oct 2000, Benjamin Herrenschmidt wrote:

> >That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> >all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> >video mode.
>
>
> Well, my understanding is that MOL needs to be able to "probe" for all
> supported mode. Doing so on a visible console would definitely be hell.
> It does that in order to setup the MacOS-side driver mode list.

According to Samuel's last post, MOL needs both var and fix for probing.
If there is something like:

struct fb_probe_info {
	struct fb_var_screeninfo var;
	struct fb_fix_screeninfo fix;
};

int fb_probe_mode (struct fb_probe_info *pi) {
	int err;

	pi->var.activate = FB_ACTIVATE_TEST;
	if ((err = set_var(&pi->var))<0)
		return err;
	var_to_fix(&pi->var, &pi->fix);

	return 0;
}

MOL would be happy?


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
