Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id 2B33A67B49
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 03:48:27 +1000 (EST)
In-Reply-To: <e7e59bf0180e5958169a0f7fc0196098@freescale.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
	<c2628642aad8b8107d0e9db84535ea0c@onz.com>
	<1118845450.7564.111.camel@jmcmullan.timesys>
	<e7e59bf0180e5958169a0f7fc0196098@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a9c3f58e85815e58496be38eeee609bf@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Wed, 15 Jun 2005 10:48:23 -0700
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Jun 15, 2005, at 9:24 AM, Jason McMullan wrote:
>
>> My personal opinions:
>>
>> 	* Use macro-offsets into a cpm2_map_t struct
>
> Not going to happen.  Sorry.
>

Interesting... So are you thinking of eliminating the cpm_map_t 
structure all together?

>> 	* Put fcc_c regs back in
>
> Can you explain this.  I'm not 100% sure what regs you are referring 
> to.
>

The registers that he is referring to are in my patch with a comment 
about moving them to the device driver specific structure. The base 
address changed depending on processor.

>> 	* dpram[PROFF_*] should be in the resources list
>
> The patch I posted seems to do that.  I'm guessing these comments may 
> be against Allen's initial patch.
>
My patch did you the #defines from cpm2.h to specify the PROFF 
locations. It did not use dpram[PROFF] since that would be an address 
not an offset from the base.

>> 	* cpm2_* is a better name than MPC82xx_* or MPC85xx_*
>> 	* Keep CPM2_DMA, etc, as these *should* be showing up in
>> 	  /proc/iomem, since, IIRC, the platform layer does
>> 	  reserve them upon registration. (And I *do* have a DMA
>> 	  layer then uses CPM2_DMA as a driver-ish thing)
>
> I'll agree on DMA, do you see value in CPM, SI1 and SI2 being here?  
> And if so for what?
>
I really do not want to belabor this point about naming conventions but 
I believe it will become more of a problem in the future. The problem 
as I see it is the PQ2 is a multi-core processor composed of a PPC 603 
and a CPM. So the question is, is it more efficient to describe the 
multi-core permutations or the pieces that are put together to create 
the processor. As industry uses more IP blocks to create SoCs I can see 
the "describe the chip" approach to be a exponential problem.

DMA and CPM should be in the device list. They represent a shared 
resource or a management function shared by the "real" devices. Putting 
them in the list has the advantage that their resources are mapped with 
the device is registered. (as mentioned by Jason M.) Perhaps there will 
be a need for a DMA manager.
