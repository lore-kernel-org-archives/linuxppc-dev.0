Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 710DADDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:22:26 +1000 (EST)
Message-ID: <4715FE6C.2070201@semihalf.com>
Date: Wed, 17 Oct 2007 14:22:04 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 04/15] [POWERPC] CM5200 DTS
References: <47075FA7.3030108@semihalf.com> <4708C112.9020506@semihalf.com>
	<20071008015021.GA12499@localhost.localdomain>
In-Reply-To: <20071008015021.GA12499@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> [snip]
>> +		flash@c000000 {
>> +			device_type = "rom";
>> +			compatible = "direct-mapped";
>> +			reg = <0c000000 02000000>;
>> +			probe-type = "CFI";
>> +			bank-width = <2>;
>> +			partitions = <00000000 00060000
>> +				00060000 00020000
>> +				00080000 00020000
>> +				000a0000 00020000
>> +				000c0000 00200000
>> +				002c0000 01b40000
>> +				01e00000 00200000>;
>> +			partition-names = "uboot\0env\0redund_env\0dtb\0kernel\0rootfs\0config";
>> +		};
> 
> First, this is the old flash binding, please use the new one.

Ok.

> Second, is the flash really part of the SoC?

Not directly, it is attached to LocalPlus Bus Controller, which is
part of the SoC. And the soc@ is currently the only recognized of bus
for mpc5200, so if we want to move it to some other place new bindings
will need to be defined for lpc (LocalPlus Controller) bus. But I am
not quite sure where this should be attached. Bus is under LPC which
is a part of the SoC, but on the other hand Soc address range covers
only device control registers not the address space LPC may handle
(that may be varied). Any ideas?

m.
