Date: Sat, 14 Oct 2000 14:24:40 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: geert@linux-m68k.org
Cc: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        bh40@calva.net
Subject: Re: [linux-fbdev] Re: Video driver bug
Message-ID: <20001014142440.A2104@ibrium.se>
References: <19340907141507.13024@192.168.1.10> <Pine.LNX.4.10.10010141208290.570-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010141208290.570-100000@cassiopeia.home>; from geert@linux-m68k.org on Sat, Oct 14, 2000 at 12:09:37PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 14, 2000 at 12:09:37PM +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Oct 2000, Benjamin Herrenschmidt wrote:
> > >That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> > >all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> > >video mode.
> >
> > Well, my understanding is that MOL needs to be able to "probe" for all
> > supported mode. Doing so on a visible console would definitely be hell.
> > It does that in order to setup the MacOS-side driver mode list.
>
> Wouldn't it be sufficient to run MOL in only one mode, cfr. the X server?

Well, that would cripple MOL considerably. A lot of MacOS applications
(admittedly most of these are games) expect to be able to change
the resolution or the depth. But the really imporant reason is that
in order to allow switching between MOL-in-a-window and console video
(which is much faster), several resolutions must be supported since
running MOL in a X-window with the same size as the screen is not very useful.

The main problem is that MacOS wants to know all the details
about the available video modes at startup. This information is also
necessary in order to make a transition possible from X to the
console.

Thus, if the API is going to change, I would really like to see a
possibility to obtain both the var and the fix information for
any supported video mode.

Cheers,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
