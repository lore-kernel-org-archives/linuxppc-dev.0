Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 952E5DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 02:56:51 +1000 (EST)
In-Reply-To: <8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org>
References: <Pine.LNX.4.64.0709121154120.19816@blarg.am.freescale.net>
	<919c9b76c3e6e45af6e3fb887611a681@kernel.crashing.org>
	<8FFFBF2E-8255-40FB-836D-AB5B19222DD9@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <39e2f86a62574776183feb82935cd79c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] DTS cleanup
Date: Thu, 13 Sep 2007 18:56:39 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> * built-in for non-standard buses (ISA, PCI)
>>
>> "built-in" is some weird CHRP property, so yes we don't need it
>> or want it.
>
> Do you suggest we get ride of it from ISA nodes as well?

Yes.  You aren't CHRP so you don't have to follow the CHRP binding.
Of course it is good to copy from that binding where it makes sense,
but how is "built-in" useful to you?

>>> * Fixed ranges on lite5200*
>>
>> This has a problem still:
>>
>>>  		model = "fsl,mpc5200";
>>>  		compatible = "mpc5200";
>>>  		revision = "";			// from bootloader
>>> -		#interrupt-cells = <3>;
>>>  		device_type = "soc";
>>> -		ranges = <0 f0000000 f0010000>;
>>> -		reg = <f0000000 00010000>;
>>> +		ranges = <0 f0000000 0000c000>;
>>> +		reg = <f0000000 0000c000>;
>>
>> That makes "reg" and "ranges" identify an identical address range,
>> which means no subnode can claim any address in that range, so the
>> "ranges" property should go.  Alternatively, the "reg" might be
>> claiming too big a space.
>>
>> Which is it?
>
> Yeah, I think it should be 0x100 for the 'soc' regs on 52xx so I'll 
> set regs to that.

Okido.

Did I say "nice cleanups, thank you!" already?  :-)


Segher
