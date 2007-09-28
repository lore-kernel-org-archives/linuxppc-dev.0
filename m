Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F65ADDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:11:29 +1000 (EST)
Message-ID: <46FD5FCB.4010908@freescale.com>
Date: Fri, 28 Sep 2007 15:10:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929000621.2d332e86@kernel.crashing.org>
In-Reply-To: <20070929000621.2d332e86@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> Hello Scott,
> 
> Looks good, only one note:
> 
> On Fri, 28 Sep 2007 14:06:16 -0500
> Scott Wood wrote:
> 
>> +	im_dprambase = cpm2_immr->im_dprambase;
>> +
>>  	/* Attach the usable dpmem area */
>>  	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
>>  	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
>>  	 * varies with the processor and the microcode patches activated.
>>  	 * But the following should be at least safe.
>>  	 */
>> -	rh_attach_region(&cpm_dpmem_info, 0, r.end - r.start + 1);
>> +	rh_attach_region(&cpm_dpmem_info, CPM_MAP_ADDR + CPM_DATAONLY_BASE,
>> +	                 CPM_DATAONLY_SIZE);
>>  }
>>  
 >
> Can we have something to address upper comment? I mean,any way to
> have dpram beginning and size encoded in the device tree? We seem to
> be adding new bus, and still pulling the information from the
> defines. Maybe I miss something here, but it looks a bit odd.

This bit is #ifndef CONFIG_PPC_CPM_NEW_BINDING (and can come out once 
all arch/powerpc boards are converted and tested -- I think it's just 
mpc866ads and CPM mpc85xx left to go).  The new code in 
arch/powerpc/sysdev/cpm_common.c does get it from the device tree.

-Scott
