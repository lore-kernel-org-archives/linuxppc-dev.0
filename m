Date: Wed, 9 Oct 2002 11:49:41 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Michael Stephen Hanni <michael@deviant-behavior.com>
Cc: xpert@XFree86.Org, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Using the "chips" XFree86 driver on a PowerBook 3400 (almost
 there.)
In-Reply-To: <1034122532.952.38.camel@zippy.deviant-behavior.com>
Message-ID: <Pine.BSF.4.44.0210091141170.56214-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It seems you have changed the address space to use the big endian
aperture, this is correct.  As for the accel engine, try turning off all
acceleration (just #if them out in the driver, no need for several XaaNo*
Options), and leave on SolidFills, this is the easiset to debug.  There is
a problem with some 65550's and polling of the BR04 register which tends
to lockup the engine, you may be running into that.  I would grab the old
source from Xpmac (I believe it had c&t accel) and poke around there to
see where the engine is initialized and the proper way to BLTWAIT on this
chip, its been long since I hacked on the c&t65550 so I don't remember
sorry.

As for the hardware cursor, you will have to swap the image of the cursor.
See the hw cursor support for radeon (or r128) and apply similair
necessary the big endian bits.


ani

On 8 Oct 2002, Michael Stephen Hanni wrote:

> Hi,
>
> Being of unsound mind and body I decided to see if the chips driver
> could be made to work on my PowerBook 3400. This model of powerbook
> includes the ct65550 chipset -- i.e. HiQV -- and has 1 meg of video ram.
> >From reading the documentation in the source tree it would appear that
> the "chips" driver fully supports this chipset and furthermore sports
> full acceleration -- which would really be nice on this older powerbook!
> However, in using the driver my powerbook lockedup nicely. After some
> trying of various config switches I got the thing to come up by using
> the "NoAccel" option. Alas, the colors were hopelessly screwed up, the
> video ram wasn't detected correctly, and the hardware cursor was not an
> X but rather <>. Suffice it to say, it was not usable.
>
> After some small hacking I've gotten the colors right (though this may
> just be a coincidence) and I've fixed the ram detection problem (I'm
> more certain here as it was only a small fix.) Unfortunately I still can
> not use the acceleration as it freezes the machine solid. Sometimes the
> screen will come up, but it is frozen on arrival (FOA.)
>
> Other issues:
>
> 1.) there seems to be a lot of visuals coming up. That is, by using the
> fbdev I get 2 TrueColor visuals for this machine, with the chips driver
> I get 2 TrueColor and 2 DirectColor.
>
> 2.) XVideo is hosed. When I try to use any program that makes use of
> xvideo I get a BadAlloc error reporting there are insufficient
> resources.
>
> Patch:
>
> This is against a freshly updated CVS copy of the xc module.
>
> I'd really appreciate any help any of you could offer on making this
> baby work. I'm not sure what exactly has to be fixed endian-wise to make
> acceleration work (the *ToCPU* stuff maybe?) and what is going on with
> xvideo.
>
> If there is any info I can give please let me know and I'd be happy to
> pass it on.
>
> Cheers!
>
> Michael
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
