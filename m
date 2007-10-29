Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B33DFDE017
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 01:20:35 +1100 (EST)
Message-ID: <4725F9F8.60600@ru.mvista.com>
Date: Mon, 29 Oct 2007 18:19:20 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] PowerPC: Add 44x NDFC device-tree aware support
References: <20071026163058.GA11354@ru.mvista.com>
	<alpine.LFD.0.9999.0710262316590.3186@localhost.localdomain>
In-Reply-To: <alpine.LFD.0.9999.0710262316590.3186@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Gleixner wrote:
> On Fri, 26 Oct 2007, Valentine Barshak wrote:
>> The major difference is that the original implements each chip connected NDFC banks as a
>> separate MTD device. Here I try to have one MTD device spread on all chips found.
>> However, the chips should have equal ID's and sizes, but I've never seen several different
>> chips attached to single ndfc.
> 
> Bamboo has 2 different nand chips. And I'm aware of another board
> which has a 2k-page onboard NAND and sockets for SmartMedia /
> PictureXd cards, which will simply break with your design.
> 
> Restricting stuff for no good reason is never a good idea.
> 
> mtdconcat can build you a big one if you want, so why adding
> restrictions to a driver ?
> 
>> I'm adding ndfc_of as a separate file, since some other changes
>> have also been made (e.g. all i/o is made with ndfc_readl/writel inline functions).
> 
> This should be done in the original ndfc driver and not in a separate
> incarnation.
> 
>> The original version didn't handle driver removal well (it never calls del_mtd...),it's 
>> corrected here.
> 
> Why not fixing the original driver ?
> 
>> Any comments are greatly appreciated.
> 
> NACK.
> 
> Please fix the existing driver and convert it to deal with OF and fix
> the other short comings as well.
> 
> Duplicate code is not going anywhere near drivers/mtd/nand
> 
> 	tglx

Thanks all for your comments.
Well, let me explain why I did this.
First of all I should have checked twice, since I was thinking bamboo 
had identical chips :) I planned to add different chip support later a 
bit, just wanted to get a simple OF driver version working first. 
Surely, mtd concat can be used, but it adds a slight overhead for 
identical chips. Eventually, I wanted to make it support both separate 
mtd devices on each chip or spread across identical ones depending on 
the device-tree settings. The other thing is that the original driver 
lacked a distinct parent-child relationship between ndfc and chips. 
Simply registering chip driver only after ndfc is successfully 
registered doesn't guarantee we initialize chip device after ndfc is 
properly initialized.
Even if we set ndfc parent for the chip platform device as suggested by 
Stefan:
static struct platform_device nand_dev = {
	.name = "ndfc-chip",
	.id = 0,
	.num_resources = 1,
	.resource = &r,
	.dev = {
		.platform_data = &nand_chip,
		.parent = &ndfc_dev.dev,
	}
};
If for some reason ndfc probe fails the kernel will crash on the chip 
probe. Of course it would work most of the time, but I think that both 
initialization and clean-up has to be reworked in the original driver.
The original driver has a tight connection to the 
platform_device/platform_data structures. Stefan suggested a 
OF-to-platform device wrapper to make both versions work:
http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044019.html
It's fine to have this glue code, but right now only 1 chip is 
supported. To add support for more chips we need an array of at least 4 
ndfc-chip platform devices. And this approach looks to me like inventing 
something new (OF) and then adding glue and quirks to make it work with 
the old stuff. Why invent new stuff then?
To make the original driver work with both "platform device" and new OF 
device descriptions need additional rework of the current ndfc code (add 
some #ifdefs, or completely split platform/OF and nand core stuff into 
separate files). I know that duplicating code is no good either, but 
since the original stuff is going to die and be removed anyway should it 
be a big problem?
So, these are just my thoughts.
Thanks,
Valentine.
