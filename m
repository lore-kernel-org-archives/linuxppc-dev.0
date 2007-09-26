Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070926104419.1b92002e.sfr@canb.auug.org.au>
References: <1189748800.165136.731062325870.1.gpush@pokey>
	<1189748800.165997.810365539433.2.gpush@pokey>
	<20070926104419.1b92002e.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <244a03b111160633e9a9d8926be155fa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] fsl/embedded6xx: don't cast the result of
	of_get_property
Date: Wed, 26 Sep 2007 14:55:18 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> -	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
>> -	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
>> +	phys_addr = of_get_property(avr, "reg", &len);
>> +	avr_clock_prop = of_get_property(avr, "clock-frequency", &len);
>
> If you don't use the value of the len variable, then you can pass NULL 
> to
> of_get_property.

OTOH, it is almost always an error to not use the length (missing
error check).


Segher
