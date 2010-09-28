Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9DED9B7115
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 04:21:35 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SI5tZP031671
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:05:55 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SILWnd121688
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 14:21:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8SILTWO007632
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 15:21:32 -0300
Message-ID: <4CA231FA.4070907@austin.ibm.com>
Date: Tue, 28 Sep 2010 13:20:42 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 4/8] v2 Allow memory block to span multiple memory sections
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA0EFAA.8050000@austin.ibm.com>
	<20100928124810.GI14068@sgi.com>
In-Reply-To: <20100928124810.GI14068@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2010 07:48 AM, Robin Holt wrote:
>> +u32 __weak memory_block_size_bytes(void)
>> +{
>> +	return MIN_MEMORY_BLOCK_SIZE;
>> +}
>> +
>> +static u32 get_memory_block_size(void)
> 
> Can we make this an unsigned long?  We are testing on a system whose
> smallest possible configuration is 4GB per socket with 512 sockets.
> We would like to be able to specify this as 2GB by default (results
> in the least lost memory) and suggest we add a command line option
> which overrides this value.  We have many installations where 16GB may
> be optimal.  Large configurations will certainly become more prevalent.

Works for me.

> 
> ...
>> @@ -551,12 +608,16 @@
>>  	unsigned int i;
>>  	int ret;
>>  	int err;
>> +	int block_sz;
> 
> This one needs to match the return above.  In our tests, we ended up
> with a negative sections_per_block which caused very unexpected results.

Oh, nice catch.  I'll update both of these.

-Nathan
