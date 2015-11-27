Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BF821A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:43:40 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 22:43:39 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0D6513E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:43:37 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5ha3f27197648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:43:36 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5haw0002756
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:43:36 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/powernv: panic() on OPAL < V3
In-Reply-To: <5657EBF5.2030602@au1.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
 <5657EBF5.2030602@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:43:26 +1100
Message-ID: <m3lh9km1z5.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -103,11 +103,8 @@ int __init early_init_dt_scan_opal(unsigned long node,
>>   		powerpc_firmware_features |= FW_FEATURE_OPALv2;
>>   		powerpc_firmware_features |= FW_FEATURE_OPALv3;
>>   		pr_info("OPAL V3 detected !\n");
>> -	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
>> -		powerpc_firmware_features |= FW_FEATURE_OPALv2;
>> -		pr_info("OPAL V2 detected !\n");
>>   	} else {
>> -		pr_info("OPAL V1 detected !\n");
>> +		panic("OPAL != V3 detected, no longer supported.\n")
>
> In the event of an OPAL v4 that is for some reason not backwards 
> compatible with V3, "*no longer* supported" might not make sense. This 
> isn't a huge problem of course.

Considering you need kernel support for any new POWER processor, and we're not
about to do an OPALv4 on POWER8 or earlier - we're going to be safe :)
