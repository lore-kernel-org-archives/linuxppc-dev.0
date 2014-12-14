Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C01661A00EE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 22:52:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sun, 14 Dec 2014 17:22:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3C41C1258023
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:23:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBEBqxts60424210
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:22:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBEBqlqA012805
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Dec 2014 17:22:47 +0530
Message-ID: <548D7A0E.2060107@linux.vnet.ibm.com>
Date: Sun, 14 Dec 2014 17:22:46 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [v4,4/4] powernv: powerpc: Add winkle support for offline cpus
References: <20141214100600.3446B140119@ozlabs.org>
In-Reply-To: <20141214100600.3446B140119@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sunday 14 December 2014 03:35 PM, Michael Ellerman wrote:
> On Tue, 2014-09-12 at 18:56:53 UTC, "Shreyas B. Prabhu" wrote:
>> Winkle is a deep idle state supported in power8 chips. A core enters
>> winkle when all the threads of the core enter winkle. In this state
>> power supply to the entire chiplet i.e core, private L2 and private L3
>> is turned off. As a result it gives higher powersavings compared to
>> sleep.
> ...
> 
>> diff --git a/arch/powerpc/platforms/powernv/subcore.h b/arch/powerpc/platforms/powernv/subcore.h
>> index 148abc9..604eb40 100644
>> --- a/arch/powerpc/platforms/powernv/subcore.h
>> +++ b/arch/powerpc/platforms/powernv/subcore.h
>> @@ -15,4 +15,5 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  void split_core_secondary_loop(u8 *state);
>> +extern void update_subcore_sibling_mask(void);
>>  #endif
> 
> subcore.c isn't built for CONFIG_SMP=n, resulting in:
> 
>   setup.c:(.init.text+0x34b0): undefined reference to `.update_subcore_sibling_mask'
> 
> I needed to add:
> 
> +#else
> +static inline void update_subcore_sibling_mask(void) { };
> +#endif /* CONFIG_SMP */
> 
> 
Sorry I missed that.

> I also got quite a few conflicts, with this and the previous patch, mainly in
> the paca and asm-offsets. Please check I resolved them correctly:
> 
>   https://github.com/mpe/powerpc-merge/commits/test
>
This looks fine to me.

Thanks,
Shreyas
> cheers
> 
