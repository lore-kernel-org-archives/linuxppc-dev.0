Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 471A8DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:06:55 +1000 (EST)
Message-ID: <47188FB6.70306@semihalf.com>
Date: Fri, 19 Oct 2007 13:06:30 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 04/15] [POWERPC] CM5200 DTS
References: <47075FA7.3030108@semihalf.com>
	<4708C112.9020506@semihalf.com>	<20071008015021.GA12499@localhost.localdomain>	<4715FE6C.2070201@semihalf.com>
	<20071018002256.GA24236@localhost.localdomain>
In-Reply-To: <20071018002256.GA24236@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Oct 17, 2007 at 02:22:04PM +0200, Marian Balakowicz wrote:
>> David Gibson wrote:
>>> [snip]
>>>> +		flash@c000000 {
>>>> +			device_type = "rom";
>>>> +			compatible = "direct-mapped";
>>>> +			reg = <0c000000 02000000>;
>>>> +			probe-type = "CFI";
>>>> +			bank-width = <2>;
>>>> +			partitions = <00000000 00060000
>>>> +				00060000 00020000
>>>> +				00080000 00020000
>>>> +				000a0000 00020000
>>>> +				000c0000 00200000
>>>> +				002c0000 01b40000
>>>> +				01e00000 00200000>;
>>>> +			partition-names = "uboot\0env\0redund_env\0dtb\0kernel\0rootfs\0config";
>>>> +		};
>>> First, this is the old flash binding, please use the new one.
>> Ok.
>>
>>> Second, is the flash really part of the SoC?
>> Not directly, it is attached to LocalPlus Bus Controller, which is
>> part of the SoC. And the soc@ is currently the only recognized of bus
>> for mpc5200, so if we want to move it to some other place new bindings
>> will need to be defined for lpc (LocalPlus Controller) bus. But I am
>> not quite sure where this should be attached. Bus is under LPC which
>> is a part of the SoC, but on the other hand Soc address range covers
>> only device control registers not the address space LPC may handle
>> (that may be varied). Any ideas?
> 
> The bus bridge has to be there.  Is this something similar to the
> "localbus" / "chipselect" bus controllers that a whole bunch of the
> Freescale SoCs have?  

Yes, that's kind of a local bus.

> Because the bridged addresses don't lie in the
> IMMR, althoug the control registers do, the current convention is to
> make the localbus node a sibling of /soc, even though it is really
> part of the SoC (/soc would perhaps be better called /immr, but /soc
> is established now).  This approach is imperfect, but so are most of
> the other compromises we could make.
> 
> Incidentally LPC is a pretty bad abbreviation, since LPC more
> frequently refers to the Low Pin Count connections that frequently
> appear on south bridges or superIO chips.

How about 'LocalPlus Bus' and 'lpb' node then?

m.
