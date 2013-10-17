Return-Path: <prarit@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7C2FC2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 22:50:34 +1100 (EST)
Message-ID: <525FCEFF.9060702@redhat.com>
Date: Thu, 17 Oct 2013 07:50:23 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] powerpc/vio: Fix modalias_show return values
References: <1381982024.3267.14.camel@deadeye.wl.decadent.org.uk>
In-Reply-To: <1381982024.3267.14.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/16/2013 11:53 PM, Ben Hutchings wrote:
> Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 introduces a trivial
> local denial of service.
> 
>> --- a/arch/powerpc/kernel/vio.c
>> +++ b/arch/powerpc/kernel/vio.c
>> @@ -1351,11 +1351,15 @@ static ssize_t modalias_show(struct devi
>>  	const char *cp;
>>  
>>  	dn = dev->of_node;
>> -	if (!dn)
>> -		return -ENODEV;
>> +	if (!dn) {
>> +		strcat(buf, "\n");
> 
> Every read from the same sysfs file handle uses the same buffer, which
> gets zero-initialised just once.  So if I open the file, read it and
> seek back to 0 repeatedly, I can make modalias_show() write arbitrary
> numbers of newlines into *and beyond* that page-sized buffer.
> 
> Obviously strcat() should be strcpy().
> 

D'oh!  Of course -- I wasn't thinking clearly about that.  I'll send out a new
patch.

P.

> Ben.
> 
>> +		return strlen(buf);
>> +	}
>>  	cp = of_get_property(dn, "compatible", NULL);
>> -	if (!cp)
>> -		return -ENODEV;
>> +	if (!cp) {
>> +		strcat(buf, "\n");
>> +		return strlen(buf);
>> +	}
>>  
>>  	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
>>  }
> 
