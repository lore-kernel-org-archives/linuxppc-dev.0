Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D8472C0094
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2013 14:55:17 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 7 Jan 2013 22:55:14 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 57FF56E803C
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2013 22:55:11 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r083tCeM31391792
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2013 22:55:12 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r083tB5R002940
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2013 01:55:12 -0200
Message-ID: <50EB989D.70807@linux.vnet.ibm.com>
Date: Mon, 07 Jan 2013 21:55:09 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] lsprop: Fixes to work correctly when built little endian
References: <1357532610-19416-1-git-send-email-michael@ellerman.id.au>
 <1357611149.16285.54.camel@pasglop>
In-Reply-To: <1357611149.16285.54.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/07/2013 08:12 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-01-07 at 15:23 +1100, Michael Ellerman wrote:
>> Add and use dt_swap_int() to byte swap on little endian.
>>
>> Also declare buf as unsigned char, so that we don't sign extend when
>> printing values from it.
>>
>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>> ---
>>
>> Ben, based on your patch, can you add your s-o-b? :
>>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2008-May/056088.html
> 
> I didn't know powerpc-utils required sob's :-)

Not technically, it's more a CYA thing. It (hopefully) keeps big blue legal
happy, which keeps me happy.

-Nathan

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>> ---
>>  src/lsprop.c |   17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/lsprop.c b/src/lsprop.c
>> index 5969a97..38a8fa5 100644
>> --- a/src/lsprop.c
>> +++ b/src/lsprop.c
>> @@ -13,11 +13,22 @@
>>  #include <sys/stat.h>
>>  #include <sys/types.h>
>>  #include <dirent.h>
>> +#include <endian.h>
>> +#include <byteswap.h>
>> +
>> +static inline unsigned int dt_swap_int(unsigned int data)
>> +{
>> +#if __BYTE_ORDER == __LITTLE_ENDIAN
>> +	return bswap_32(data);
>> +#else
>> +	return data;
>> +#endif
>> +}
>>  
>>  int recurse;
>>  int maxbytes = 128;
>>  int words_per_line = 0;
>> -char *buf;
>> +unsigned char *buf;
>>  
>>  void lsprop(FILE *f, char *name);
>>  void lsdir(char *name);
>> @@ -183,7 +194,7 @@ void lsprop(FILE *f, char *name)
>>      } else if ((n & 3) == 0) {
>>  	nw = n >> 2;
>>  	if (nw == 1) {
>> -	    i = *(int *)buf;
>> +	    i = dt_swap_int(*(int *)buf);
>>  	    printf(" %.8x", i);
>>  	    if (i > -0x10000 && !(i >= 0 && i <= 9))
>>  		printf(" (%d)", i);
>> @@ -201,7 +212,7 @@ void lsprop(FILE *f, char *name)
>>  		if (i != 0)
>>  		    printf("\n\t\t");
>>  		for (j = 0; j < npl && i + j < nw; ++j)
>> -		    printf(" %.8x", ((unsigned int *)buf)[i+j]);
>> +		    printf(" %.8x", dt_swap_int(((unsigned int *)buf)[i+j]));
>>  	    }
>>  	}
>>      } else {
> 
> 


-- 
-Nathan
