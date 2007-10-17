Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B863DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:35:35 +1000 (EST)
Message-ID: <47162BC4.2090907@freescale.com>
Date: Wed, 17 Oct 2007 10:35:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: linux-2.6.git: cannot build PS3 image
References: <Pine.LNX.4.62.0710121152500.28100@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710121531250.757@pademelon.sonytel.be>
	<Pine.LNX.4.62.0710171523120.19421@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710171523120.19421@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
>> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
>> index 39b27e5..795f988 100755
>> --- a/arch/powerpc/boot/wrapper
>> +++ b/arch/powerpc/boot/wrapper
>> @@ -232,7 +232,7 @@ base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
>>  entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
>>  
>>  if [ -n "$binary" ]; then
>> -    mv "$ofile" "$ofile".elf
>> +    cp "$ofile" "$ofile".elf
>>      ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
>>  fi
> 
> No comments?

That'd work in this case, though it'd probably be better to make the 
$ofile be the end result that will boot on the ps3, and leave a suffix 
on the intermediate files.

I wonder if we may be better off just making zImage a phony target and 
removing the link altogether....

-Scott
