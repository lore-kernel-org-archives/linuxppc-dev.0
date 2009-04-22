Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10EFADE317
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:28:12 +1000 (EST)
Message-ID: <49EF5391.9050404@freescale.com>
Date: Wed, 22 Apr 2009 12:27:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Krill <ben@codiert.org>
Subject: Re: ofpart:  Partitions at same address cannot have the same name
References: <874owhoxce.fsf@macbook.be.48ers.dk>	<1240415535-10939-1-git-send-email-ricardo.ribalda@uam.es>
	<20090422171030.GH14906@codiert.org>
In-Reply-To: <20090422171030.GH14906@codiert.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>, linuxppc-dev@ozlabs.org,
	David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Krill wrote:
>> --- a/drivers/mtd/ofpart.c
>> +++ b/drivers/mtd/ofpart.c
>> @@ -48,7 +48,7 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
>>
>> 		/* check if this is a partition node */
>> 		partname = of_get_property(pp, "name", &len);
>> -		if (strcmp(partname, "partition") != 0) {
>> +		if (strncmp(partname, "partition", strlen("partition") != 0) {

Perhaps "compatible" should be used instead?

> Hi Recardo,
> 
> I would suggest to do:
> 
> 		if (strcmp(partname, "partition") <= 0) {

Check whether it sorts alphabetically before "partition"?  Why?

-Scott
