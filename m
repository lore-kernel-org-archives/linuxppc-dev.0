To: linuxppc-embedded@lists.linuxppc.org
Cc: Dan Malek <dan@mvista.com>
Subject: Re: Sandpoint 8240 or 7400
References: <524rylvl3d.fsf@love-boat.topspincom.com> <3A722CA1.3EAE82AF@mvista.com> <52u26iut9s.fsf@love-boat.topspincom.com> <3A75C579.F3E637FD@mvista.com>
From: Roland Dreier <roland@topspincom.com>
Date: 30 Jan 2001 15:55:04 -0800
In-Reply-To: Dan Malek's message of "Mon, 29 Jan 2001 14:33:13 -0500"
Message-ID: <527l3cvbmv.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Dan> I worked on it about 40 hours this past weekend, still no go.
    Dan> The problem for me still continues to be interrupt routing on
    Dan> this board.  The 8240 or 107 have the EPIC, which is like
    Dan> OpenPIC but not really.  This is further complicated by the
    Dan> 8259 cascade, which the OpenPIC code assumes is configured a
    Dan> particular way, but doesn't work on Sandpoint.  It is just a
    Dan> problem of using standard functions and making the interrupts
    Dan> line up correctly.  Pain in the ass.  The whole Linux
    Dan> interrupt management is just plain stupid (there is more to
    Dan> the world than PCs with hardcoded 8259s).

I managed to get my Sandpoint 7400 to boot (it turns out that VxWorks
uses the opposite interrupt polarity so someone had set S5 wrong on
the motherboard).  I used the 2.4.0-pre2 kernel that comes with the
Montevista CDK 1.2, though I had to recompile to build in the 3c59x
driver (since that's the network card I'm using).

After doing that, the kernel boots, gets through the BOOTP, and mounts
its root filesystem via NFS.  However, something screwy seems to be
happening when the kernel tries to run init -- init doesn't seem to be
getting run.  Even if I use sash or a simple program that just prints
something, I don't get any output on the serial console.  I even tried
a program that listens for network connections but I can't connect to
it.  The kernel is still running: I can ping the box, get TCP
connections refused (ARP works), and the serial driver is doing enough
to echo input.  And the NFS mount is working -- the kernel panics
unless /bin/init is a ppc executable.  Anyone have any idea about
what's happening?  Am I missing something obvious?

Thanks,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
