Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20731B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 06:02:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FK6w63001159
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 16:06:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FK2RaE213272
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 16:02:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FJxHtd004914
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 15:59:17 -0400
Date: Tue, 15 Sep 2009 16:02:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090915200223.GH12372@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<20090915193205.GA8115@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090915193205.GA8115@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 03:32:05PM -0400, Paul Gortmaker wrote:
>[Re: RFC: delete UART current-speed from 4xx DTS?] On 15/09/2009 (Tue 11:32) Josh Boyer wrote:
>
>> On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
>> >One of the guys here was getting a messed up console on a bamboo board
>
>I meant to say Yosemite board (and hence u-boot), sorry for that.  It
>gives garbage up until the udbg -> ttyS0 handover, at which point the
>console=ttyS0,115200 fixes things.

Ok.

>> >(on linux boot), which he traced to the fact that the default dts has a
>> >9600 baudrate coded into it (board was running 115k2, not 9600).  Either
>> >deleting the line, or replacing the 9600 with zero fixed the problem.
>> 
>> Once booted, was there a valid current-speed property in /proc/device-tree
>> for the serial node?  I'm curious if U-Boot created it, or if the kernel
>> just used whatever baud was present already.
>
>Had to go back to get this info; it turns out there is a valid prop in
>all the serial nodes (2.6.31-rc7), and hexdumping it gives 0x2580 (9600).

Sorry, that was after you removed the property in the DTS entirely, or setting
it to 0, or just using the existing DTS as-is?  I should have phrased my
question better, but I think I answered it myself already.

In my brief test with Sequoia and Bamboo, I removed the current-speed property
entirely and once booted there was no property in the serial node, which is
what I would expect for the old version of U-Boot on these boards.  The good
news is that it seems to work fine :).

>> When I did the bamboo port a while ago, I recall having issues with either
>> a missing clock-frequency or current-speed (or both perhaps) and the bootloader
>> on the board was the original PIBS.  It might have been an issue with PIBS
>> but I'm guessing the rest of the 4xx boards copied from either Ebony or
>> Bamboo in their ports and hence contain that property.
>
>Right - so there could still perhaps be the same issue with PIBS/bamboo
>present that you saw earlier (given my inability to keep board names
>straight)

OK.  I'll be sure to test PIBS.

>
>> 
>> >Looking at the Fsl boards, it seems that 99% of them don't list any
>> >current-speed at all.  I'm willing to whip up a patch to delete them
>> 
>> I think 99% of them use U-Boot, which should fix things up either way.
>
>This is the interesting part -- being a yosemite (u-boot), I would have
>thought so as well.  I've not looked at the u-boot code, but it may only
>add a current-speed if there isn't one yet.  At least that is what the
>behaviour tends to indicate.  Board is running u-boot 1.3.3 so what we
>are seeing here may not reflect what current u-boot code is doing
>anyway...

Yeah, 1.3.3 is pretty old.  However, I _think_ the kernel will just leave
the baud rate alone entirely without a current-speed property and without
console=ttyS0,<baud rate>.  Example:

linux:/proc/device-tree/plb/opb/serial@ef600300 # ls                            
clock-frequency  device_type       interrupts  reg                              
compatible       interrupt-parent  name        virtual-reg                      
linux:/proc/device-tree/plb/opb/serial@ef600300 # cat /proc/cmdline             
rootdelay=15 root=/dev/sda1 rw ip=off                                           
linux:/proc/device-tree/plb/opb/serial@ef600300 # uname -a                      
Linux linux 2.6.31 #4 Tue Sep 15 16:57:49 UTC 2009 ppc ppc ppc GNU/Linux        
linux:/proc/device-tree/plb/opb/serial@ef600300 # cat /proc/cpuinfo             
processor       : 0                                                             
cpu             : 440EP Rev. B                                                  
clock           : 399.999996MHz                                                 
revision        : 24.211 (pvr 4222 18d3)                                        
bogomips        : 799.99                                                        
timebase        : 399999996                                                     
platform        : PowerPC 44x Platform                                          
model           : amcc,bamboo                                                   
Memory          : 191 MB                                                        
linux:/proc/device-tree/plb/opb/serial@ef600300 #


>> I can test bamboo with PIBS, ebony, holly (which isn't 4xx even though it's
>> a tree name) with PIBS, sequoia, taishan, yosemite, and walnut.  Perhaps a few
>> of the 405 boards I have as well.
>> 
>> It's easy enough for me to whip up a patch, and since I'll be testing either
>> way I'd be happy to do that if you'd like.
>
>Sure -- the testing effort will be greater than the time to make the
>patch, so you doing coverage on all those would be great.  I think I've
>probably only got easy immediate access to a PIBS/bamboo at the moment.
>We already know the yosemite is OK with the change, so that is one less
>to test.

OK, sounds good.  I'll do some more testing over the next few days and post
a patch.  Thanks for bringing this to my attention.

josh
