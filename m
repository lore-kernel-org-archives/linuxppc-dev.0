Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FDFA1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:12:50 +1100 (EST)
In-Reply-To: <1259209632.16367.246.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<49443.84.105.60.153.1259172058.squirrel@gate.crashing.org>
	<1259209632.16367.246.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28453315-9EC5-48EE-8DFC-C8B3BBA7CF24@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Thu, 26 Nov 2009 23:19:46 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +			xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
>>> +			xfb-size = <0x168000>;
>>
>> XFB address isn't fixed on the hardware, and the kernel might
>> want to move it, and you can easily probe for it anyway.  Remove
>> these last two properties please.
>
> Ok but you need to know what it was setup to by the FW no ? To avoid
> having a temporary display "glitch" while booting... Also on a 24M
> config,it might get tough for the driver to allocate 2M contiguous  
> like
> that if it's done late in the boot process.

Sure, the platform code will have to probe this very early.  Can always
do the /memreserve/ if really needed.

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
> Or make it a child of audio ? :-)

Hrm, actually, DSP and AI should be separate nodes, and ARAM a child
of DSP (on its own bus, so it can show that it is 16MB etc.)


Segher
