Date: Mon, 20 May 2002 13:54:44 -0400 (EDT)
From: brad allison <jackal@aol.net>
To: YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
Cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Nvidia support
In-Reply-To: <20020517231311.6b1c91ac.billfink@mindspring.com>
Message-ID: <Pine.LNX.4.44.0205201347260.24446-100000@horus.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 17 May 2002, Bill Fink wrote:

> On Fri May 17 2002, brad allison wrote:
>
> > I was talking about my G4 900Mhz Quicksilver which came with a GeForce4
> > card.
> >
> > I was able to find a co-worker who has an older G4 with a GeForce2 MX card
> > and we traded.
> >
> > So I'm now testing against the GeForce2 MX card which is listed as
> > "supported".
> >
> > I was able to X working with it using the "nv" driver however it seems to
> > ignore everything in /etc/X11/XF86Config-4 and it boots into whatever
> > resolution it wants.  The numbers don't match.
> >
> > I figured this would be the fb settings so I checked what fbset says.
> > fbset says I'm at mode "640x480-283" which is what my consoles are running
> > at.
> >
> > I selected 1280x1024 in Xconfigurator, when X starts it's coming up in
> > 1280x960.
> >
> > Anyone know why?  Or how to fix this?
>
> You might give this a try:
>
> First boot a kernel with the riva kernel driver enabled but don't start X,
> i.e. boot into runlevel 3.  Create a new entry in /etc/yaboot.conf with
> something like the following line added:
>
> 	append="video=riva:1280x1024-24@60 3"
>


Nothing I did on the command line changed resolution.

So, then I installed MacOSX on one of the other partitions.  Inside MacOSX
I set the resolution to 1280x1024, then rebooted.  Now the yaboot prompt,
boot prompt, and console messages all come up at 1280x1024.

I booted with ben's kernel with the "novideo" option in yaboot.conf into
init 3.

Then I re-ran Xconfiguration.  Added lines to /etc/X11/XF86Config-4 from
fbset -x, and changed the driver to "nv".

When I run X it -still- comes up in 1280x960 @ 60.00.

So it's ignoring both the fb settings -and- the XF86Config-4 and booting
into whatever resolution it can sync too.

-b

--
                                 Brad Allison
                         AOL Core Services -- RHCE
  jackal.is.dreaming.org   jackal@aol.net   703.265.0908   aim:jackal242


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
