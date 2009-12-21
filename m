Return-Path: <jschopp@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80C49B6F1A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 05:22:17 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBLIFNwY012742
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 13:15:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBLIMDDB132072
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 13:22:13 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBLIMDG9008646
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 13:22:13 -0500
Message-ID: <4B2FBCD1.7080306@austin.ibm.com>
Date: Mon, 21 Dec 2009 12:22:09 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Joel Schopp <jschopp@austin.ibm.com>, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
References: <1261170452.8134.13.camel@jschopp-laptop>
	<20091221004458.GI30375@ozlabs.org>
In-Reply-To: <20091221004458.GI30375@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Fri, Dec 18, 2009 at 03:07:32PM -0600, Joel Schopp wrote:
>   
>> In order to boot with more than 64 cores on machines that support the
>> ibm,client-architecture RTAS call a new field has been added to the
>> structure.  This patch updates that field and adds a few others in the
>> process.  It would be good if this could go in as a bugfix.  
>>     
>
> But it's not really is it? What does it fix?
>   
It fixes kernels compiled with NR_CPUS where NR_CPUS > 256. 
>
>>  	/* option vector 5: PAPR/OF options */
>> -	5 - 2,				/* length */
>> +	13 - 2,				/* length */
>>  	0,				/* don't ignore, don't halt */
>>  	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
>>  	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
>>  	0,
>>  	OV5_CMO,
>> +	0,				/* reserved */
>> +	0,				/* reserved */
>> +	0,				/* reserved */
>> +	0,				/* reserved */
>>     
>
> Not so much reserved, as unused by us.
>   
They were all reserved until recently, and the last 2 of the 4 are still 
reserved, while we just don't use the first two yet.  I'll remove the 
comments from the first 2.

>   
>> +	W(NR_CPUS/4),			/* max cores supported */
>>     
>
> 4?  I can see a case for 2 or just plain NR_CPUS, but 4 is wrong.
>   
4 is the new 2.  Since the actual threads per core is unknown at this 
point in boot you have to be conservative and go with the maximum number 
of any processor.  See page 4 of these charts:
http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf
>   
>> +	/* option vector 6: IBM PAPR hints */
>> +	4 - 2,
>>     
>
> We all know this is a length, but please follow the style in this structure.
>   
OK.
>   
>> +	0,				/* reserved */
>> +	0,				/* 1 == no secondary pteg */
>>     
>
> I think the "1 == " confuses things.
>   
I'll remove it then.
>   
>> +	OV6_LINUX,
>>     
>
> Does filling in the vector actually let us boot on systems where we do not already?
>   
Will add description to the email body on this one.
>   
>> +
>> +	/* option vector 7: IBM PAPR OS identification */
>> +	/* a human readable ascii string will go here */
>>     
>
> Either fill it in or leave the comments out.  
>   
I'll leave the comment out.
