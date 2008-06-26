Return-Path: <scottwood@freescale.com>
Message-ID: <4863FA88.1010708@freescale.com>
Date: Thu, 26 Jun 2008 15:22:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] powerpc/bootwrapper: Add documentation of
	boot	wrappertargets
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>	<20080626164842.1D3AB1358053@mail15-sin.bigfish.com>	<1214507238.7698.3.camel@weaponx>
	<20080626201643.D01221788058@mail223-wa4.bigfish.com>
In-Reply-To: <20080626201643.D01221788058@mail223-wa4.bigfish.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: John Linn <linnj@xilinx.com>, paulus@samba.org, linuxppc-dev@ozlabs.com,
	petermendham@computing.dundee.ac.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
>> cuImage is for boards running an older U-Boot that does not understand
>> device trees.
> 
> Forgive my ignorance here, but what specifically does this imply?  As
> far as I can tell, generally speaking, some of the board-specific
> information is passed into the boot wrapper, which then stuffs it into
> the device tree.

It implies that the binary is in uImage format, targets older u-boot (as 
opposed to some other bootloader entirely, which might be targeted with 
a dtbImage -- see adder875, for example), and has a device tree embedded.

>> uImage is for device-tree aware U-Boot versions
> 
> And this differs from above because it gets a device tree passed in,
> which uboot has already stuffed correctly.

Yes.

>> dtbImage is used for boards that can take an ELF zImage, but still
> need
>> a dtb provided.
>>
>> simpleImage, not sure here.
> 
> So both of these are elfs...  but how do they differ?  Is it only in how
> the right head.s file gets picked up?

Neither is necessarily an ELF.  The only simpleboot target I see is a 
flat binary, as are some of the dtbImage targets (adder875, ep88xc, 
ep405, etc).  simpleboot is more of a platform than an image type; it's 
a platform that assumes nothing about the firmware that loaded it, and 
gets all information from the embedded device tree.

-Scott
