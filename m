Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF1y90n88zDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 14:07:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1333WB6067002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 22:07:42 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28c10un7ub-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 22:07:42 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Thu, 2 Feb 2017 20:07:41 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1DCB91FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 20:07:17 -0700 (MST)
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1337cvs43712596
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 03:07:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B150112047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:07:38 -0500 (EST)
Received: from oc5780617838.ibm.com (unknown [9.80.99.213])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id 4F4B8112040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:07:38 -0500 (EST)
Subject: Re: xmon memory dump does not handle LE
To: linuxppc-dev@lists.ozlabs.org
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
 <87a8a4avx3.fsf@concordia.ellerman.id.au>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Thu, 2 Feb 2017 21:07:37 -0600
MIME-Version: 1.0
In-Reply-To: <87a8a4avx3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm referring to the three commands listed in the help:

d     dump bytes

df    dump float values

dd    dump double values

As it turns out, all three of these commands do exactly the same thing, 
and it's certainly not what I'd expect based on experience with other 
debuggers. Maybe the original intent was only to simply output bytes of 
memory, but to me the help implies otherwise and certainly something 
more is needed.

I'll take a look at Balbir's patch and see if I can help move it along.

Thanks,

Doug

On 02/02/2017 07:46 PM, Michael Ellerman wrote:
> Douglas Miller <dougmill@linux.vnet.ibm.com> writes:
>
>> I was hoping this would be any easy fix, but now it looks like it will
>> be more difficult.
>>
>> The basic problem is that xmon memory commands like 'dd' do not properly
>> display the data on LE instances. This means that not only is it
>> difficult to read but one cannot copy-paste addresses from the output.
>> This severely encumbers debugging using xmon on LE systems.
> What do you mean by "properly"?
>
> I think what you're saying is that dumping bytes of memory on LE doesn't
> give you nice u64 pointers, but that's not a bug, that's just how memory
> is laid out on LE.
>
> Also memory isn't always filled with u64 pointers, so just byte swapping
> at that size is not correct. Sometimes you'll be looking at ints, in
> which case you need to swap 4 bytes at a time.
>
> What we need is dump commands that do a byte swap of a given size.
> Balbir was working on this but I think he got diverted.
>
> His first attempt was here: https://patchwork.ozlabs.org/patch/696348/
>
> But as I said in my reply:
>
>    So as discussed, lets add d1, d2, d4, d8, which dump 1/2/4/8 bytes at a
>    time, in cpu endian, and which each value separated by space.
>
>
> Here's a quick hack to get it going. Let me know if that works for you,
> it's not pretty, but we could probably merge it with a bit of cleanup.
>
> cheers
>
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a44b049b9cf6..3903af5fe276 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2334,10 +2334,43 @@ static void dump_pacas(void)
>   }
>   #endif
>
> +static void dump_by_size(unsigned long addr, long count, int size)
> +{
> +	unsigned char temp[16];
> +	int i, j;
> +	u64 val;
> +
> +	count = ALIGN(count, 16);
> +
> +	for (i = 0; i < count; i += 16, addr += 16) {
> +		printf(REG, addr);
> +
> +		if (mread(addr, temp, 16) != 16) {
> +			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
> +			return;
> +		}
> +
> +		for (j = 0; j < 16; j += size) {
> +			putchar(' ');
> +			switch (size) {
> +			case 1: val = temp[j]; break;
> +			case 2: val = *(u16 *)&temp[j]; break;
> +			case 4: val = *(u32 *)&temp[j]; break;
> +			case 8: val = *(u64 *)&temp[j]; break;
> +			default: val = 0;
> +			}
> +
> +			printf("%0*lx", size * 2, val);
> +		}
> +
> +		printf("\n");
> +	}
> +}
> +
>   static void
>   dump(void)
>   {
> -	int c;
> +	int size, c;
>
>   	c = inchar();
>
> @@ -2350,8 +2383,9 @@ dump(void)
>   	}
>   #endif
>
> -	if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
> +	if (c == '\n')
>   		termch = c;
> +
>   	scanhex((void *)&adrs);
>   	if (termch != '\n')
>   		termch = 0;
> @@ -2383,9 +2417,21 @@ dump(void)
>   			ndump = 64;
>   		else if (ndump > MAX_DUMP)
>   			ndump = MAX_DUMP;
> -		prdump(adrs, ndump);
> +
> +		size = 0;
> +		switch (c) {
> +		case '8': size += 4;
> +		case '4': size += 2;
> +		case '2': size += 1;
> +		case '1': size += 1;
> +			dump_by_size(adrs, ndump, size);
> +			break;
> +		default:
> +			prdump(adrs, ndump);
> +			last_cmd = "d\n";
> +		}
> +
>   		adrs += ndump;
> -		last_cmd = "d\n";
>   	}
>   }
>
>
