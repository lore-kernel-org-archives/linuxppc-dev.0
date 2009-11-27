Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E0FA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 23:00:13 +1100 (EST)
In-Reply-To: <4B0D7AD0.5030605@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<49443.84.105.60.153.1259172058.squirrel@gate.crashing.org>
	<4B0D7AD0.5030605@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <220C04A0-4502-4CDE-B3B5-DFAA6EBCB902@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Fri, 27 Nov 2009 13:07:11 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +	soc {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		#interrupt-cells = <1>;
>>
>> This isn't an interrupt controller, don't put #interrupt-cells
>> here.
>
> Isn't this needed to define what is to be expected in the  
> "interrupts" properties of the child nodes?

Nope.  Only interrupt controllers have a #interrupt-cells.  When
interpreting the "interrupts" property of some node, you walk the
interrupt tree (which can be the same as the device tree, or fully
separate, or share some things; and doesn't have to be a tree either)
up to the next interrupt controller, and use the #interrupt-cells
from that.  (This is simplified a little bit).

>>> +		auxram@0c005000 {
>>> +			compatible = "nintendo,flipper-auxram";
>>> +			reg = <0x0c005000 0x200>;	/* DSP */
>>> +			interrupts = <6>;
>>> +			interrupt-parent = <&pic>;
>>> +		};
>>> +
>>> +		audio@0c005000 {
>>> +			compatible = "nintendo,flipper-audio";
>>> +			reg = <0x0c005000 0x200		/* DSP */
>>> +			       0x0c006c00 0x20>;	/* AI */
>>> +			interrupts = <6>;
>>> +			interrupt-parent = <&pic>;
>>> +		};
>>
>> These two have the same address, not good.  Just remove the
>> auxram node?
>
> The DSP and the ARAM control/status bits share some registers in  
> the same block.
>
> How should I match the aram block driver if I remove the auxram node?

You can make aram a child node of dsp, which allows you to show
its size as well.  I.e. you do #a-cells=1 #s-cells=1 in the dsp
node, and reg=<0 01000000> in the aram node.

Or you can do a simple property in the dsp node saying how big
the aram is, and assume the driver(s) that match know(s) how to
drive it.  You have to assume this anyway, you're not putting
e.g. bytecode drivers in the device tree ;-)

>> ...and all the applicable things I mentioned in my Wii dev tree
>> reply, of course.
>>
>> Wow, it wasn't as bad as I expected actually.  But you cheated,
>> you omitted most devices from the device trees :-)
>
> You're welcome to add them too if you have information about them :)

I'll do that later, yes.  It's not so big a problem if the device
tree doesn't describe devices you do not support at all.


Segher
