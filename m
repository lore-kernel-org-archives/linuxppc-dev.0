Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <484D49FF.4090604@grandegger.com>
References: <484CECE2.9050605@grandegger.com>
	<519f1a6d9baeca8cfea9e8ad7a92c4d4@kernel.crashing.org>
	<484D49FF.4090604@grandegger.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a9f4227722f169bc9c2e712df774b748@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] booting-without-of: add more bindings for FSL UPM driver
Date: Tue, 10 Jun 2008 01:47:30 +0200
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +      - chip-delay : may specify a delay value in milliseconds.
>>
>> Delay for what?  The binding should say.  "chip-delay" is a bit
>> too generic name as well, it could be more descriptive perhaps.
>
> The chip-delay property defines an appropriate maximum delay
> time (tR) required for read operations if the R/B pin is not
> connected.

Yeah.  So please put that in the binding.

>> Shouldn't this be a property of the NAND device anyway, not the
>> NAND controller?
>
> Strictly speaking, it's a property of the NAND device. Therefore it
> should be inside the node nand@0, I thhink:
>
> +			nand@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +			        chip-delay = <25>; // in micro-seconds

Something like that, yes.  You wrote milliseconds before; which is it?

And, a better property name, please.

> Where should that be documented?

In the binding for nand devices.  If there isn't any yet, it might be
best to include that with the binding for your nand controller (i.e.,
describe the whole sub node there).


Segher
