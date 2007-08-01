Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070801020836.GB31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Wed, 1 Aug 2007 06:57:33 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +	UIC0: interrupt-controller0 {
>> +		compatible = "ibm,uic-440gp","ibm,uic";
>
> The first compatible entry should always be the precise model, so in
> this case "ibm,uic-440epx".

This isn't really _required_, but it is a very good idea in
almost all cases (the exception is for very generic or legacy
devices).

> If it is (supposed to be) identical to
> the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
> since I believe all the UICs are supposed to operate the same, I think
> that's implicit in the "ibm,uic" entry.

Sure, but there is no harm in having the better qualified 440gp
name in there as well -- bytes are cheap :-)

>> +	SDR0: sdr {
>
> What is the SDR?
>
>> +		compatible = "ibm,sdr-440ep";
>> +		dcr-reg = <00e 002>;
>> +	};
>> +
>> +	CPR0: cpr {
>
> And the CPR?

Yeah, better names please -- if possible, something that someone
without knowledge of this SoC will understand what it is.

>> +				nor_flash@0,0 {
>> +					device_type = "rom";
>> +					compatible = "direct-mapped";
>> +					probe-type = "CFI";
>
> This flash binding needs to be replaced, but I guess that's not really
> your problem.

Yeah, that's my problem, thanks for the prod :-)


Segher
