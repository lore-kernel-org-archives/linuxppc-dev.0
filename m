Date: Tue, 17 Oct 2000 00:20:37 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Cc: geert@linux-m68k.org, bh40@calva.net, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: Video driver bug
Message-ID: <20001017002037.A26630@ibrium.se>
References: <Pine.LNX.4.10.10010141839280.570-100000@cassiopeia.home> <Pine.LNX.4.21.0010161712090.6261-100000@euclid.oak.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0010161712090.6261-100000@euclid.oak.suse.com>; from jsimmons@suse.com on Mon, Oct 16, 2000 at 05:22:58PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 16, 2000 at 05:22:58PM -0700, James Simmons wrote:
>
> > > > Well, my understanding is that MOL needs to be able to "probe" for all
> > > > supported mode. Doing so on a visible console would definitely be hell.
> > > > It does that in order to setup the MacOS-side driver mode list.
> > >
> > > According to Samuel's last post, MOL needs both var and fix for probing.
>
> Yes this is really bad. The way most drivers are written is that testing
> var does not change fix. If you grab fix after testing the video mode it
> will be for the current set resolution. Not the one you are testing
> for. For most drivers you need to physically set the mode to change
> fix. Sometimes the information in fix can only be obtained from the
> hardware and this requires a video mode change.

What MOL needs from the fix structure is the bytes_per_line field and
the page_offset of framebuffer. This information is necessary in order
to make it possible to switch seamlessly (by using the MMU) from a
RAM based framebuffer to the physical one.

What I'd like to see is good way to obtain these parameters without
actually setting the video mode. And, of course, it would be nice
if they were guaranteed to be constant for a given video mode.

Cheers,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
