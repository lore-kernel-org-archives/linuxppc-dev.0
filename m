Date: Thu, 1 Apr 2004 08:09:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: okorpil@fh-landshut.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial Console / Booting Linux with the PPCbug on MVME2100?
Message-ID: <20040401150943.GE21709@smtp.west.cox.net>
References: <Pine.LNX.4.58.0403311359540.21912@ppcproject1> <20040331170924.GL13819@smtp.west.cox.net> <Pine.LNX.4.58.0404011015410.476@ppcproject1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0404011015410.476@ppcproject1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 10:26:28AM +0200, okorpil@fh-landshut.de wrote:

> Hello!
>
> I'm using a plain vanilla 2.4.25 kernel with the attached config.
>
> As you may have noted I'm using the zImage.prep.
>
> Do I need to make a mkbugboot by hand? (It's only configured to be done
> for the CONFIG_LOPEC, CONFIG_PPLUS and CONFIG_PRPMC750)

This is what I expected.  Looking quickly over the prep_* files in
arch/ppc/platform confirms that the MVME2100 is not supported by these
files.  As an aside, mkbugboot is only needed to put an image into flash
and boot it. mkprep is used for hd(/cd?), floppy and network.

Now, a quick googling for Linux and MVME2100 gives this very old, but
mostly sufficient patch:
http://www.aps.anl.gov/asd/people/anj/mvme2100.patch.gz
Since you have the hardware, from here it should be not too hard, using
the LoPEC as an example, port the code in that patch to 2.4 and 2.6 (if
you do a patch vs 2.6 we can get that support into kernel.org, if you're
willing to try and keep the platform working).

-
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
