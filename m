Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E00FB7BA4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 03:59:56 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA5Gpab7011127
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:51:36 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA5GxrKB108774
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:59:53 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA5GxrNs026388
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:59:53 -0500
Message-ID: <4AF3046A.4050508@austin.ibm.com>
Date: Thu, 05 Nov 2009 10:59:22 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 2/5] Merge dynamic OF code to of_dynamic.c
References: <4AF1FB29.50905@austin.ibm.com> <4AF1FD46.9050101@austin.ibm.com>
	<fa686aa40911042355l73c7511bod3b2f651e9c9a5a4@mail.gmail.com>
In-Reply-To: <fa686aa40911042355l73c7511bod3b2f651e9c9a5a4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Hi Nathan,
> 
> Thanks for the patches.  Comments below.
> 
> On Wed, Nov 4, 2009 at 3:16 PM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> Creation of the OF dynamic device tree update code in drivers/of.  This
>> merges the common device tree updating routines to add/remove nodes and
>> properties from powerpc and microblaze.  All of the new code is conditional
>> based on a new OF_DYNAMIC config option.
> 
> Rather than one patch to create all the moved functions, and then
> subsequent patches to remove the duplicates from each arch, I've been
> using the pattern of one patch for each function or couple of
> functions to both remove from the old files and add to the new home.
> Would you be able to do the same for your patches here?  The merging
> is complicated enough without having to track changes to a function
> between separate commits.  Moving one function at a time will also
> make bisecting more friendly.
>

Shouldn't be a problem.

 
> Also, have you checked what impact these changes have on SPARC?
>

I took a look at sparc code, but will do again as I redo the patches to
make there are no impacts. 
 
>> --- linux-next.orig/drivers/of/Makefile 2009-11-03 11:18:08.000000000 -0600
>> +++ linux-next/drivers/of/Makefile      2009-11-03 13:42:35.000000000 -0600
>> @@ -1,6 +1,7 @@
>> obj-y = base.o
>> -obj-$(CONFIG_OF_DEVICE) += device.o platform.o
>> -obj-$(CONFIG_OF_GPIO)   += gpio.o
>> -obj-$(CONFIG_OF_I2C)   += of_i2c.o
>> -obj-$(CONFIG_OF_SPI)   += of_spi.o
>> -obj-$(CONFIG_OF_MDIO)  += of_mdio.o
>> +obj-$(CONFIG_OF_DEVICE)                += device.o platform.o
>> +obj-$(CONFIG_OF_GPIO)          += gpio.o
>> +obj-$(CONFIG_OF_I2C)           += of_i2c.o
>> +obj-$(CONFIG_OF_SPI)           += of_spi.o
>> +obj-$(CONFIG_OF_MDIO)          += of_mdio.o
>> +obj-$(CONFIG_OF_DYNAMIC)       += of_dynamic.o
> 
> Unrelated whitespace churn makes it hard to see what actually changed.
> 
ok.

-Nathan Fontenot
