Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8F9EDDF67
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 07:14:05 +1100 (EST)
Message-ID: <47BDDBA2.7040305@freescale.com>
Date: Thu, 21 Feb 2008 14:14:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH] [POWERPC] add target for building .dtb files
References: <C3E318FD.D883%gerickson@nuovations.com>
In-Reply-To: <C3E318FD.D883%gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Erickson wrote:
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index d57a67d..fb29f10 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -311,6 +311,10 @@ $(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts
>> $(wrapperbits)
>>  $(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
>> $(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
>>  
>> +# Rule to build device tree blobs
>> +$(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
>> + $(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(dtstree)/$*.dts
>> +
> 
> Grant,
> 
> Would it be beneficial to provide a way to have environment- or
> command-line-provided DTC arguments/flags such that the oft-required '-S
> <size>' and '-R <reserved>' flags can be specified? Or, are there reasonable
> size and reserved defaults appropriate for all platforms that can be
> specified?

These aren't required for the bootwrapper, which is the main purpose of 
the bootwrapper makefile...

> FWIW, generating a blob for Haleakala/Kilauea on the PPC405EX[r] using the
> above command in the patch results in complaints about lack of space for the
> "CHOSEN" node in u-boot.

U-boot should be fixed to not need this.  It's ridiculous.

-Scott
