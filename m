Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id E972967A81
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 20:50:20 +1000 (EST)
Message-ID: <42511D55.4040507@ru.mvista.com>
Date: Mon, 04 Apr 2005 14:56:21 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
References: <424ACFF1.5000403@bitsim.se>	
	<111d2ae873d1bfee413409dfc4f2f064@freescale.com>	
	<424BEDFC.8080300@jonmasters.org>
	<1112284541.23088.77.camel@cashmere.sps.mot.com>
	<4250EACF.1040403@bitsim.se>
In-Reply-To: <4250EACF.1040403@bitsim.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jon Masters <jonathan@jonmasters.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jakob!

Yes, Jon Loeliger's implementation plan looks OK for me
(as far as I understood Jon's posting; having look at
the current patch would be great). And I could participate
in the implementation for Xilinx if needed too, but don't
object if you do it by yourself (at the moment, I know
little about the OF device tree, so just testing the patch
on ML300 would be fine for me as well).

Should we rely on U-Boot to give that device tree structure to
the kernel? If I got it correct this is how the Freescale team
plans to proceed. Jon (Masters), are you going the same way?
Anyone using arch/ppc/boot/simple bootwrapper with his Virtex 2 Pro
board? If we drop Virtex 2 Pro support in arch/ppc/boot and move to
U-Boot would it hurt anyone?

Thanks,
Andrei

Jakob Viketoft wrote:
> Hi!
> 
> You don't happen to have a patch of your current work against one of the 
> trees (83xx and 85xx)? It would be much easier to do work in parallell, 
> and I'd be happy to do it on the "Xilinx" tree (and help out where I 
> can, of course).
> 
> Jon Masters and Andrei: Does Jon Loeliger's implementation plan sound 
> alright to you? Since you seem quite full-handed on your end anyway, 
> Jon, I'll be happy to do the work needed unless anyone has any 
> objections...
> 
> Cheers!
> 
>     /Jakob
> 
> Jon Loeliger wrote:
> 
>> On Thu, 2005-03-31 at 06:33, Jon Masters wrote:
>>
>>> Kumar Gala wrote:
>>>
>>> |> My intention was to give a device tree structure to the kernel at 
>>> boot
>>> |> time via a (pseudo?) pointer in bd_info or similar. 
>>
>>
>>
>>> This got resurrected recently. 
>>
>>
>>
>> Hi!
>>
>>
>>> | I think this is reasonable.  The best device tree would be a flattened
>>> | OF tree since we are trying to move the world in that direction.  Jon
>>> | Masters around?
>>>
>>> Yes, but I've been tied up with worky and magazine stuff again. If
>>> someone wants to work with me then this might actually happen.
>>
>>
>>
>> Hi Jon,
>>
>> I'm here and actively(!) working on it now.   Here is the very
>> rough plan as Kumar and I have discussed it.  Please feel free
>> to comment on it or offer suggestions.  Ben has suggested that
>> I start with the "second step" below.  I'd like to do a round
>> of cleanup first.
>>
>> So far, I have taken the first step of isolating the references
>> to the global __res[] variable into one file and replacing all
>> references to the data in the bd_t structure with a thin, shim
>> layer of function calls that are nominally into an OF-like
>> interface.  I have done this for all the 85xx and 83xx boards
>> in my development tree, and am working on the others now.
>> This step effectively isolates the __res[] references to one
>> file where a well defined interface can be created to pose as
>> an OF Device Tree layer (briefly).
>>
>> As a follow-up second step, I plan on introducing essentially
>> the same code currently in ppc64 to handle the flat device tree
>> and provide an interface to that data in exactly the same manner
>> as the ppc64 currently has.  I understand the desire to have the
>> flat-tree handling be "outside the kernel".
>>
>> As a third step, the shim layer will be rewritten/augmented to
>> use the actual OF device tree data where it currently fronts
>> for the bd_t data.
>>
>> Finally, as time permits and maintainers allow (read: prod),
>> the other (not 85xx, not 83xx) boards can have their setup code
>> converted to use the "real" OF device tree function calls.
>>
>> When all of that is done, the shim layer can be removed, as needed.
>>
>>
>> Oh, yeah.  Um, also on my plate will be to construct the
>> original flat-tree blob in U-Boot to be handed to the kernel.
>> (I'll start with 85xx and 83xx, naturlich.)
>>
>> We have not yet decided on the layout of that tree to determine
>> where all the attributes and devices really belong.  I will
>> also discuss with Wolfgang and crew how to generate that tree
>> over in U-Boot land.
>>
>> Right?
>>  
>> Thanks,
>> jdl
>>
> 
> 
