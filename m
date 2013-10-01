Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB13F2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 16:44:57 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 12:14:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E5CB1258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 12:15:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r916l51u46727270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 12:17:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r916ig9K019469
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 12:14:42 +0530
Message-ID: <524A6F59.9060004@linux.vnet.ibm.com>
Date: Tue, 01 Oct 2013 12:14:41 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kernel/sysfs: cleanup set up macros for pmc/non
 pmc sprs
References: <1380539849-6162-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20131001045035.GC17966@concordia>
In-Reply-To: <20131001045035.GC17966@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 01 October 2013 10:20 AM, Michael Ellerman wrote:
> On Mon, Sep 30, 2013 at 04:47:29PM +0530, Madhavan Srinivasan wrote:
>> Currently pmc setup macros are used for non pmc sprs. This patch
>> add new set of macros and cleans up the code to use the new setup macro
>> for non pmc sprs.
> 
> Hi Maddy,
> 
> Firstly you should use "PMC" not pmc, it's an acronym. You should also
> spell out what it means the first time you use it, eg:
> 
>   Currently the PMC (Performance Monitor Counter) macros are used ..
> 
> Secondly you need to say _why_ it is a bad idea to use the PMC macros
> for non-PMC SPRs.
> 
Will change it.
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 27a90b9..73b6f9f 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -139,6 +139,37 @@ static ssize_t __used \
>>  	return count; \
>>  }
>>
>> +#define SYSFS_SPRSETUP(NAME, ADDRESS) \
>> +static void read_##NAME(void *val) \
>> +{ \
>> +	*(unsigned long *)val = mfspr(ADDRESS);	\
>> +} \
>> +static void write_##NAME(void *val) \
>> +{ \
>> +	mtspr(ADDRESS, *(unsigned long *)val);	\
>> +} \
>> +static ssize_t show_##NAME(struct device *dev, \
>> +			struct device_attribute *attr, \
>> +			char *buf) \
>> +{ \
>> +	struct cpu *cpu = container_of(dev, struct cpu, dev); \
>> +	unsigned long val; \
>> +	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
>> +	return sprintf(buf, "%lx\n", val); \
>> +} \
>> +static ssize_t __used \
>> +	store_##NAME(struct device *dev, struct device_attribute *attr, \
>> +			const char *buf, size_t count) \
>> +{ \
>> +	struct cpu *cpu = container_of(dev, struct cpu, dev); \
>> +	unsigned long val; \
>> +	int ret = sscanf(buf, "%lx", &val); \
>> +	if (ret != 1) \
>> +		return -EINVAL; \
>> +	smp_call_function_single(cpu->dev.id, write_##NAME, &val, 1); \
>> +	return count; \
>> +}
> 
> This is basically a complete copy of the SYSFS_PMCSETUP() macro, except
> for the one line removal of the call to ppc_enable_pmcs().
> 
> You should be able to do better, by defining a macro that does all the
> boiler plate and takes an "extra" argument, which for PMCs is
> "ppc_enable_pmcs()" and for regular SPRs is empty.
>
Sorry about that. Will make the changes.

> cheers
> 
Thanks for the feedback
