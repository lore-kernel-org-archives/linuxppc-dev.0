Mime-Version: 1.0
Message-Id: <v04205500b39ffdcdcf7b@[207.234.107.13]>
In-Reply-To: <Pine.LNX.3.96.990630094414.968F-100000@mvista.com>
References: <Pine.LNX.3.96.990630094414.968F-100000@mvista.com>
Date: Wed, 30 Jun 1999 12:15:45 -0500
To: "David A. Gatwood" <dgatwood@mvista.com>,
        Benjamin Herrenschmidt <bh40@calva.net>
From: John Boswell <john@www.system-x.com>
Subject: Re: LinuxPPC R5 on PowerBook Series 1999
Cc: "Charles A. Jolley" <charles.jolley@zeratec.com>,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got it working on my new (bronze kb) 333 G3.  The biggest 
problem I had was actually getting the installer to work.  I had 
ftp'd all the files to a local machine, and burned a CD.  I put 
things on the CD in what I thought were the correct places.  However, 
throughout the install, I'd get a bunch of errors about "can't create 
.../temp", etc.  Seems it was trying to write to the cd.

Anyway, I copied the whole cd to my MacOS partition on the PB (I had 
reformatted the drive, and made the MacOS plain HFS, not HFS+).  The 
X-based installer then completed the install without a hitch.  I only 
installed the "defuault" options, plus "development" (so I could use 
gcc).

I'm using the "Standard" kernel with BootX, no video driver, and no 
ramdisk.  I told it the root device was hda8 (the Linux partition). 
Works just fine; X loads, and I have it running at 1024x768 with 
16+bit color.

There is a note on the Linuxppc.com page about the screen going black 
- the fix is to touch the "Brightness" function key once, and the 
screen comes alive.  I've never had that problem, though.

I've also successfully built and installed MySQL and Apache with PHP. 
I can now give "live" demos to clients of web sites with dynamic 
content - even if they don't have a 'net connection!  Cool. 
Justifies the time spent installing this.

Ethernet doesn't work, but this is a known issue with these PB's, and 
the developers are working on that.

My only problem (besides ethernet) is the flaky trackpad support.  It 
will often think I've double-clicked or have clicked-and dragged when 
I haven't.  I'll sometimes have to click the trackpad repeatedly to 
get control back.

USB support - doesn't seem to work.  My USB mouse (from my B+W G3) 
works flawlessly under MacOS on this PB, but doesn't work at all 
under Linux.

I made the mistake of having a USB Zip drive connected under Linux. 
It doesn't like that, and the load on the machine goes way up, as it 
continuously tries to read the zip drive (I didn't have a zip disk 
in).  Unplugging the Zip disk and rebooting fixed that.

All in all, once Ethernet is working, and if I can fix the trackpad 
flakeyness, this will be very nice.

-john

At 9:46 AM -0700 6/30/99, David A. Gatwood wrote these bits:
>On Wed, 30 Jun 1999, Benjamin Herrenschmidt wrote:
>
> > >2.  I thought I might try to get things working, or at least 
>figure out why
> > >the kernel doesn't boot.  The only issue is I can't get any feedback from
> > >the kernel on why it dies.  It prints a short message when it first starts
> > >but then the screen goes dead before I can read it.  Is there 
>another way to
> > >get that information out?   In fact, since there are no serial 
>ports on this
> > >machine (just USB...like the iMac), how do I get any feedback from the
> > >kernel without functioning video? (or an OF interface to help me along,
> > >which is what I do in my other kernel development...)
> >
> > Did you try with the "no video driver" option ?
> >
> > This may also be a backlight problem, Apple love changing the way the
> > backlight is controlled from one model to the other. You can try
> > commenting out the backlight control functions in 
>drivers/macintosh/via-pmu.c.
>
>The new PowerBooks are strange....  Under MkLinux, they freeze whenever
>you try to write to any location within IO space.  We're getting the data
>from OF, so the addresses are right, and we're doing the whole memory
>mapping thing.  It acts just like what happens when you try to access a
>hardware address where no hardware is present.  I'm beginning to wonder if
>the OF tree isn't broken.  If you guys have any luck, let me know what you
>figure out.  :-)
>
>
>David
>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
