Return-Path: <prarit@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id EF2B42C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 23:29:10 +1100 (EST)
Message-ID: <525FD80C.4070001@redhat.com>
Date: Thu, 17 Oct 2013 08:29:00 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] [PATCH] powerpc/vio: use strcpy in modalias_show
References: <1382011211-15272-1-git-send-email-prarit@redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7393@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7393@saturn3.aculab.com>
Content-Type: text/plain; charset=windows-1252
Cc: ben@decadent.org.uk, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/17/2013 08:22 AM, David Laight wrote:
>> Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 used strcat instead of
>> strcpy which can result in an overflow of newlines on the buffer.
> ...
>> --- a/arch/powerpc/kernel/vio.c
>> +++ b/arch/powerpc/kernel/vio.c
>> @@ -1531,12 +1531,12 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute
>> *attr,
>>
>>  	dn = dev->of_node;
>>  	if (!dn) {
>> -		strcat(buf, "\n");
>> +		strcpy(buf, "\n");
>>  		return strlen(buf);
>>  	}
>>  	cp = of_get_property(dn, "compatible", NULL);
>>  	if (!cp) {
>> -		strcat(buf, "\n");
>> +		strcpy(buf, "\n");
>>  		return strlen(buf);
>>  	}
> 
> Why not just:
> 		buf[0] = '\n';
> 		buf[1] = 0;
> 		return 1;
> 
> The assignment to buf[1] might not even be needed.

Sure, I guess that'd work too.  But it really seems like 1/2 a dozen of one and
six of the other.  I'll defer to the preference of the maintainers to see what
they want.

P.

> 
> 	David
> 
> 
> 
