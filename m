Date: Tue, 17 Oct 2000 21:09:42 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Samuel Rydh <samuel@ibrium.se>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        bh40@calva.net, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010171332540.394-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010171926140.293-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > What I'd like to see is good way to obtain these parameters without
> > actually setting the video mode. And, of course, it would be nice
>
> Currently that's possible, but it will no longer be in the future. But I guess
> it's only a few modes (640x400, 800x600, 1024x768, 1280x1024), so it won't
> cause too much annoyance?

Only if you open /dev/fb and then do a VT_ACTIVATE. Since /dev/fb is
attached to the tty attached to the process. Well usually. What we could
do is create a ioctl that retrieves fb_fix_screeninfo and fb_var_screeninfo
at the same time. Their also exist the problem of forking with using 2
ioctls to get info the current video mode.

fb_var_screeninfo first_var;
fb_fix_screeninfo fix;

ioctl(fd, FBIOGET_VSCREENINFO, first_var);
ioctl(fd, FBIOGET_FSCREENINFO, fix);

pid = fork();

if (child) {
   fb_var_screeninfo different_var_already_made_up;

   ioctl(fd, FBIOPUT_VSCREENINFO, different_var_already_made_up;
   /* Could be wrong info depending on the card and what platform it is on:-( */
   mmap(fix->smem_start, fix->smem_len, ...);
}

The fact is also with many types of hardware setups such as dual head on
matrox as Geert pointed out it might be impossible to do what you want.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
