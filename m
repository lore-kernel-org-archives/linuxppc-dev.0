Message-ID: <38D1F414.78AE4921@ncal.verio.com>
Date: Fri, 17 Mar 2000 01:00:04 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux on powerbook
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Mike,
>
> > Hi,
> >   I would like to get a new 500mhz power book to do development
> > for the 403 embedded ppc.  Is there a kernel that will run this?
> > What is the code name for the new 500 mhz powerbook (firewire)?
>
> A number of issues have been fixed on these machines, code named Pismo,
> but some things remain to be fixed before they're good to go.
>
> Regards,
> Dan
>

I've been working on this, with a lot of help from Ben H.

Interrupt initialization was resolved earlier this week and I've sent
him
some code which appears to work for the media-bay init, there are still
a couple of issues and it'll need cleanup and reconciliation with the
logic for other PowerBooks, but that's one problem mostly out of the
way.

That still leaves for basic capability:

 > OF framebuffer initialization - the color map is garbage.
   Other ATI chipsets have required fixups for their colormaps, but
   the dev-tree organization is different enough from previous systems
   that new init code will be needed even if otherwise fully register
   compatible. And than there is getting aty128 going.... Ben has been
   looking into these issues.

 > Boot parm passing from yaboot (0.4 & 0.5) doesn't work completely,
   append statements appear to suppress the novideo option and the
console
   does not come up on the display. Ben suspects the second may be
getting
   selected for the console. I can sometimes login in blind and run init
   to shutdown (I now have neworking going so I can rlogin in the next
time
   -- I'll also plug in a monitor when I start seriously debugging
this).
   Sometimes though, the system hangs before the video changes.

 > USB keyboard and mouse work on seperate USB ports, but the drivers
   trap when probing the devices if the mouse is plugged into the
   keyboard's hub.

 > The GMAC network chip works if an active line is plugged in at boot,
   but it looks like OF sometimes doesn't enable the PHYS registers
   if the network is not active at boot (but not always). I haven't
   tried ifconfig'ing eth0 in that situation yet, but I suspect there
   may be a problem.

The last two are probably not necessary fixes for a test release, but
I'll leave that call to Ben. I haven't looked into power management
yet, but that shouldn't differ much from the iBook's. And then there is
the new TI PCIMIA bridge (I think someone is already looking at this)...
Oh, and folding the fixes into the 2.3 tree.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
