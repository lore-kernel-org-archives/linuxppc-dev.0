Date: Fri, 30 Jul 1999 13:07:26 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: Open Firmware booting on a Blue G3
In-reply-to: <v04210100b3c6a2c59d09@[192.168.0.1]>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990730130144.539028848B-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You would have a seperate kernel partition, as PREP boxen do now, in
addition to your root.

On Thu, 29 Jul 1999, Ethan Benson wrote:

> On 29/7/99 puetzk6715@uni.edu wrote:
> 
> >I had ISO in mind when I said that.
> 
> personally I would not like to have to format my root partition in 
> ISO.  but the kernel should be modifed as well so that booting 
> directly from the CDROM is possible.
> 
> another problem with ISO is that linuxppc.com has been mostly 
> instructing users to only create 2 partitions a swap and a giant all 
> encompassing partition for root, usr, and everything else.  (not 
> optimal IMO) thus if we do not support quik then that entire 
> filesystem would have to be ISO, which I cannot imagine being fast 
> nor efficient.  (granted I don't know a whole lot about ISO, does it 
> even support permissions?)

Well, the directions would ned to change...

> >... then quik can be set to ask a passwd when
> > > arguments are given (just like restricted lilo)
> >
> >Good argument for retaining quik.
> 
> yes I would much prefer having quik.

And I would prefer first that they OF-boot at all! Once the linker is
fixed (I assume it is where fixes are needed? My knowledge is a bit
thin...), it should be no issue which binary we rebuild.

> > > if we dump quik then the only way to boot into single user mode is
> > > BootX (yuk) or adding a argument to OF when booting.
> >
> >Which is not all bad. boot-file works pretty well.
> 
> but quik would be easier, and would be securable.

OK.

> > > I would say keep quik around and add the same passwd support to it as
> > > LILO this way we can setup OF once (with maybe a script that has a
> > > boot menu) with a nice config tool and use quik in the same way we
> > > use LILO on intel machines, it can help increase security options,
> > > and help reduce the need for hacking OF variables.
> >
> >sure. I don't care either way, but it would be nice to be able to OF-boot
> >new machines.
> 
> I think both quik and the kernel should be fixed, this way there is 
> the possibility for some extra security and direct BootX free booting 
> from the CD is possible.  perhaps make it a compile time option for 
> the kernel, so if you use quik (better option anyway since root 
> filesystem is ext2) you need not have a larger kernel with the extra 
> unused OF code.

Not much larger - it's a header field, nothing more... I'd say always out
it on.

> > > I am not a programmer quite yet so I cannot unfortunatly fix quik
> > > myself, but would like to see it done...
> >
> >For anyone who is - NetBSD/ppc can boot, figure out what they're doing
> >right (or so I'm told). Since that too is Open Source, you should be able
> >to see what they're telling gcc/ld/i dunno what tool that makes it get
> >things correct.
> 
> from what I have read the iMac (almost the same as far as booting 
> goes) will only boot NetBSD from the network.

But that is enough! LinuxPPC'ers had gotten an iMac to pull the kernel up
off disk (in pre-bootX days) but it was rejected because of the missing
header. If OF accepts netBSD's kernel in any way,shape, or form, it's
headers are correct.

> however I have been researching this issue for the last week and 
> found this technote from Apple:
> 
> http://developer.apple.com/technotes/tn/tn1167.html  in particular 
> they mention the need for a "bootfile" which is a file containing an 
> OpenFirmware script to finish the bootstrap process, it can 
> optionally contain additional data as well.  On Macos this file is 
> the MacOSROM image, which contains the OpenFirmware script and the 
> additional data is the actual ROM image for MacOS.
> 
> so my slightly educated theory is that quik needs to have a 
> OpenFirmware script in either its first or second level bootstraps to 
> work with OF (probably first) and if booting kernel directly (only 
> possible from ISO, thus not preferable from root filesystem)  then 
> the kernel image itself would probably have that OF header, which I 
> am not sure could be done, so instead it would probably be a 
> different file which has the additional code to load the kernel.

Hmm... OK, maybe my understanding is slightly flawed...

> would the -dev list be more appropriate to continue this discussion?

OK. I really don't know enough to do this, and am hoping that if we waste
enough bandwidth discussing it, someone will swoop in and pick it up...

> Best Regards,
> Ethan Benson
> To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
