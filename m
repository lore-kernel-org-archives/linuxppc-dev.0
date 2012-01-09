Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EB520B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 06:15:09 +1100 (EST)
Message-ID: <4F0B3CB3.6040909@freescale.com>
Date: Mon, 9 Jan 2012 13:14:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 01/16] powerpc/booke: Set CPU_FTR_DEBUG_LVL_EXC on
 32-bit
References: <20111221013412.GA8378@schlenkerla.am.freescale.net>
 <C57ECE6B-1040-40BC-B7C7-5107533A2DC2@suse.de>
In-Reply-To: <C57ECE6B-1040-40BC-B7C7-5107533A2DC2@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 09:21 AM, Alexander Graf wrote:
> 
> On 21.12.2011, at 02:34, Scott Wood wrote:
> 
>> Currently 32-bit only cares about this for choice of exception
>> vector, which is done in core-specific code.  However, KVM will
>> want to distinguish as well.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>> arch/powerpc/include/asm/cputable.h |    5 +++--
>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index e30442c..033ad30 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -375,7 +375,8 @@ extern const char *powerpc_base_platform;
>> #define CPU_FTRS_47X	(CPU_FTRS_440x6)
>> #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
>> 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
>> -	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
>> +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE | \
>> +	    CPU_FTR_DEBUG_LVL_EXC)
> 
> KVM on E200?

This isn't a KVM patch, it's a patch to make CPU_FTR_DEBUG_LVL_EXC be
set properly on 32-bit chips.  e200 has this CPU feature.

-Scott
