Return-Path: <haren@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E1422C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 11:52:41 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Mon, 26 Nov 2012 17:52:39 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6818C1FF0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 17:52:32 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAR0qaBm272944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 17:52:36 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAR0sU0v003751
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 17:54:31 -0700
Message-ID: <50B40ED3.2070808@linux.vnet.ibm.com>
Date: Mon, 26 Nov 2012 16:52:35 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
References: <1351666334.32304.13.camel@hbabu-laptop>
 <28905.1353643302@neuling.org>
In-Reply-To: <28905.1353643302@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2012 08:01 PM, Michael Neuling wrote:
> Heaven Myneni <haren@linux.vnet.ibm.com> wrote:
> 
>> [PATCH 2/6] powerpc: Define CPU_FTR_HAS_PPR
>>
>> CPU_FTR_HAS_PPR is defined for POWER7.
>>
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>> ---
>>  arch/powerpc/include/asm/cputable.h |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index 21a0687..12e3a1d 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -171,6 +171,7 @@ extern const char *powerpc_base_platform;
>>  #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
>>  #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
>>  #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
>> +#define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x4000000000000000)
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> @@ -400,7 +401,8 @@ extern const char *powerpc_base_platform;
>>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
>>  	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
>>  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
>> -	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
>> +	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
>> +	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR)
>>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
>> @@ -422,7 +424,7 @@ extern const char *powerpc_base_platform;
>>  	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
>>  	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
>>  	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
>> -	    CPU_FTR_VSX)
>> +	    CPU_FTR_VSX | CPU_FTR_HAS_PPR)
> 
> FYI, there is no need to add this to POSSIBLE, since you are adding it
> to POWER7 anyway.

Will remove CPU_FTR_HAS_PPR for POSSIBLE macro. Added this in second
version for enabling this feature with command parameter, but forgot to
remove it.

Thanks
Haren


> 
> Mikey
> 
