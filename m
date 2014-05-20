Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078181A0852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:04:06 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 20 May 2014 13:34:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C192A125804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:33:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K84Cu1196912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:34:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K840nC023115
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 13:34:01 +0530
Message-ID: <537B0C6E.4030501@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 13:33:58 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 2/2] powerpc/pseries: init fault_around_order for
 pseries
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
 <20140520002834.aefb5a90.akpm@linux-foundation.org>
In-Reply-To: <20140520002834.aefb5a90.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com,
 paulus@samba.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 20 May 2014 12:58 PM, Andrew Morton wrote:
> On Thu,  8 May 2014 14:58:16 +0530 Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> 
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -17,6 +17,8 @@ struct device_node;
>>  extern void request_event_sources_irqs(struct device_node *np,
>>  				       irq_handler_t handler, const char *name);
>>  
>> +extern unsigned int fault_around_order;
> 
> This isn't an appropriate header file for exporting something from core
> mm - what happens if arch/mn10300 wants it?.
>
> I guess include/linux/mm.h is the place.
> 

Rusty already suggested this. My bad.  Reason for adding it here was
that, I did the performance test for this platform. Will change and send
it out.

Thanks for review
Regards
Maddy
