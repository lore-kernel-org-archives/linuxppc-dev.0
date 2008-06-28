Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40806272122g3f4148d3ua1e59df54709cc68@mail.gmail.com>
Date: Fri, 27 Jun 2008 21:22:55 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] powerpc/bootwrapper: Add documentation of boot
	wrappertargets
In-Reply-To: <20080626201643.D01221788058@mail223-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
	<20080626164842.1D3AB1358053@mail15-sin.bigfish.com>
	<1214507238.7698.3.camel@weaponx>
	<20080626201643.D01221788058@mail223-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.com, Scott Wood <scottwood@freescale.com>,
	paulus@samba.org, John Linn <linnj@xilinx.com>,
	petermendham@computing.dundee.ac.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 1:16 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Forgive my ignorance here, but what specifically does this imply?  As
> far as I can tell, generally speaking, some of the board-specific
> information is passed into the boot wrapper, which then stuffs it into
> the device tree.

Yes, you are correct.  I'll fill out the documentation more here.

>> uImage is for device-tree aware U-Boot versions
>
> And this differs from above because it gets a device tree passed in,
> which uboot has already stuffed correctly.

Correct.

>> dtbImage is used for boards that can take an ELF zImage, but still
> need
>> a dtb provided.
>>
>> simpleImage, not sure here.
>
> So both of these are elfs...  but how do they differ?  Is it only in how
> the right head.s file gets picked up?

simpleImage is not an elf.  Its a raw position-independent binary
which can be loaded anywhere in RAM.

Some dtbImages are elfs; but there are a flat binaries.  The main
difference is that all simpleImages assume that firmware provides
nothing interesting; but the flat dtbImages have custom code for
extracting a little bit of data out of the boards firmware.

It's all a bit of a confusing mess.  It might be a good idea to rework
all the image names to stuff not so non-obvious, but I'm not sure the
best way to go about it.  There is a lot of historical stuff in there
where the various 'zImage.*' targets grew and morphed over time in
ways that are hard to follow.  It may make more sense to change the
flat-binary dtbImages to be simpleImages instead with overrides for
specific boards (just like is done for virtex405-*).  ps3 is the other
major user of dtbImage.  I created the whole dtbImage stuff in the
first place to eliminate overloaded makefile targets where some
zImage% target were providing a device tree and other zImage% targets
were not.  Splitting dtb-provided from dtb-not-provided targets
clarified the Makefile quite a bit.  dtbImage is not a fantastic name,
but I needed something different from zImage for images with an
embedded device tree.

Looking at the Makefile, dtbImage and simpleImage targets are
virtually identical.  Perhaps it would be best to merge the targets
and deal with all the differences in the wrapper script (with the
default to just use simpleboot.S as the init code).  Thoughts?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
