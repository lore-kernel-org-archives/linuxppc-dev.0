Message-ID: <3857EAF8.491F842@netx4.com>
Date: Wed, 15 Dec 1999 14:24:40 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jim Chapman <jim.chapman@iname.com>
CC: bsimon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Chapman wrote:


> Something changed between 2.2.5 and 2.2.13 to do with the virtual
> address map.


Not really, just the size of the kernel and location of some
of the variables made your luck run out.

As I have explained before, the IMMR and possibly a few other
board control registers must have physical addresses above
0x80000000.  This is because the early kernel initialization
will map these 1:1 virtual to physical.  They are needed before
the kernel VM allocator has been initialized.  If they are
below this address, they clash with the user virtual space,
so depending upon the loading of programs and libraries, you
left a big virtual hole into kernel managed hardware.


> Make sure your 860 is a rev C part or higher. If it isn't, forget trying
> to use the cache.


That's not entirely true.  There are many applications running
with copyback caches and Rev. B silicon.  It depends upon the
hardware design and including some software patches.


> Your CPU is a regular 8xx, not a 'P' (performance) variant, right? The
> latter has "optimized" cache hardware that isn't (yet?) supported by
> linuxppc.


The 860P will run just fine with Linux.  The modifications to
the cache registers don't affect Linux.  It may affect start
up boot roms.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
