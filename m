From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm statement in include/asm not ansi conform
Date: Fri, 1 Sep 2000 18:14:32 +0200
Message-Id: <20000901161432.8125@mailhost.mipsys.com>
In-Reply-To: <39AFCE61.7D68ED0C@ivey.uwo.ca>
References: <39AFCE61.7D68ED0C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>As I remember things, the xf4 code does do a simple check to see if
there is a
>bios present.  I once enabled this code and found out on my B+W G3
machine, it
>passed that bios test but read completely bogus values (even if you converted
>the data for endian issues) whereas on my G4, it completely failed the simple
>bios check that was present.

Yes, we need a better check since OF code also begins with aa55. It looks
like on the newer machines, the ATI card ROM doesn't contain the OF code
but older cards did.

>Without a real xf86 card with a bios present to play with, there is really no
>way to try and devise a better test.  Even if a bios is present, wouldn't OF
>still do the initialization?

I don't think OF will do anything but assign base addresses.

>I think we should submit it as is and ifdef it to powerpc and forget about it
>until we find out what is up.
>
>By the way, either way, the values calculated by that code should be fine (as
>long as the main code clock rate is 2950) whether intialized by OF or an
>actual
>bios so no real harm should be done (certainly better than their hardcoded
>values used now).

There is at least one r128 based PCI card for Mac that uses a different
clock rate. I think we should (for the future at least) add code to
aty128fb to recongnize it and return proper values from a private ioctl.
That wouldn't help users not using aty128fb, but on Macs, I beleive those
will be rare.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
