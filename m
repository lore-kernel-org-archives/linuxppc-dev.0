Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id DD511DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 08:31:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJyU9-00048F-4V
	for linuxppc-embedded@ozlabs.org; Fri, 18 Jul 2008 15:31:33 -0700
Message-ID: <18538794.post@talk.nabble.com>
Date: Fri, 18 Jul 2008 15:31:33 -0700 (PDT)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
In-Reply-To: <20080716075025.0bca152c@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> From what I can tell, you don't even need this patch or the defconfig.
> Nothing differs at this point from Glacier other than the DTS.  Since
> U-Boot is your loader, it should be able to pass the different DTS to a
> kernel that supports Cayonlands and have no issues.
>
> ...
>
> If you do want to have explicit support for Arches, that's fine.  Look
> at how Yosemite is supported.  It just reuses Bamboo.  You could do the
> same.

Yes, I like this idea. I'll do this.

>> +config 460GT
>> +	bool
>> +	select PPC_FPU
>> +	select IBM_NEW_EMAC_EMAC4
>> +	select IBM_NEW_EMAC_RGMII
>> +	select IBM_NEW_EMAC_ZMII
>> +	select IBM_NEW_EMAC_TAH
>
> I don't see a reason to add this at all.  460EX and 460GT select the
> same set of options.

OK. I agree.

> Here you would just have:
>
> obj-$(CONFIG_ARCHES) += cayonlands.o

>> diff --git a/arch/powerpc/platforms/44x/arches.c
>> b/arch/powerpc/platforms/44x/arches.c
>> new file mode 100644
>> index 0000000..6d6aa66
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/44x/arches.c
>
> And then you don't need this file at all.  Just add a
> "amcc,canyonlands" string to your root node compatible property.

OK. Will update

Thanks,

Victor Gallardo
-- 
View this message in context: http://www.nabble.com/-PATCH--Add-AMCC-Arches-460GT-eval-board-support-to-platforms-44x-tp18480745p18538794.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
