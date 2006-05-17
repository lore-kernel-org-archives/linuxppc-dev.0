Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE08367B2A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 04:31:36 +1000 (EST)
In-Reply-To: <20060517160053.GE10310@localdomain>
References: <4025245D-6BAB-41D3-ADB6-2748741F223E@watson.ibm.com>
	<20060517160053.GE10310@localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2D34BC49-D5FE-437C-9874-F551A5F8CA6A@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch] udb_printf() formatting attribute
Date: Wed, 17 May 2006 14:30:07 -0400
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2006, at 12:00 PM, Nathan Lynch wrote:

> Jimi Xenidis wrote:
>> This patch allows the compiler to catch any printf-like mismatches
>> for udbg_printf().
>> After some brute force building I've only found issues with my own
>> code and lparcfg.c
>> It could break some developers, but IMHO that would be goodness.
>>
>> Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
>> ---
>> diff -r 0163968f7fce arch/powerpc/kernel/lparcfg.c
>> --- a/arch/powerpc/kernel/lparcfg.c	Tue May 16 15:55:19 2006 -0400
>> +++ b/arch/powerpc/kernel/lparcfg.c	Wed May 17 10:43:55 2006 -0400
>> @@ -521,10 +521,10 @@ static ssize_t lparcfg_write(struct file
>> 	current_weight = (resource >> 5 * 8) & 0xFF;
>> -	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
>> +	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
>> 		 __FUNCTION__, current_entitled, current_weight);
>> -	pr_debug("%s: new_entitled = %lu, new_weight = %lu\n",
>> +	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
>> 		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
>> 	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
>
> Does this really fix a bug?  What warnings are you able to get gcc to
> emit?
>
My sniff test that resulted in this patch was a manual build of all  
arch/powerpc dirs with -DDEBUG added to CFLAGS.
To see these particular warnings simply add a #define DEBUG before  
the includes of this file you will get:
.../linux-2.6/arch/powerpc/kernel/lparcfg.c: In function  
`lparcfg_write':
.../linux-2.6/arch/powerpc/kernel/lparcfg.c:524: warning: long  
unsigned int format, different type arg (arg 4)
.../linux-2.6/arch/powerpc/kernel/lparcfg.c:527: warning: long  
unsigned int format, different type arg (arg 4)
