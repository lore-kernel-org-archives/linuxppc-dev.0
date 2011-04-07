Return-Path: <matt@ozlabs.org>
Message-ID: <4D9D7308.4030405@ozlabs.org>
Date: Thu, 07 Apr 2011 18:17:12 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Free up some CPU feature bits by moving out
	MMU-related features
References: <4D9D5042.6080500@ozlabs.org>
	<D5DE7F16-B3E0-4F5C-9A2C-0052C6B6D2D1@kernel.crashing.org>
In-Reply-To: <D5DE7F16-B3E0-4F5C-9A2C-0052C6B6D2D1@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/11 17:06, Kumar Gala wrote:
> 
> On Apr 7, 2011, at 12:48 AM, Matt Evans wrote:
> 
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index be3cdf9..7b0fe7c 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -178,22 +178,15 @@ extern const char *powerpc_base_platform;
>> #define LONG_ASM_CONST(x)		0
>> #endif
>>
>> -#define CPU_FTR_SLB			LONG_ASM_CONST(0x0000000100000000)
>> -#define CPU_FTR_16M_PAGE		LONG_ASM_CONST(0x0000000200000000)
>> -#define CPU_FTR_TLBIEL			LONG_ASM_CONST(0x0000000400000000)
>> #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
>> #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
>> #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
>> #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000010000000000)
>> -#define CPU_FTR_LOCKLESS_TLBIE		LONG_ASM_CONST(0x0000040000000000)
>> -#define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
>> #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
>> #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
>> #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
>> #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
>> #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
>> -#define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
>> -#define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
>> #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
>> #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
>> #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
>> @@ -205,9 +198,10 @@ extern const char *powerpc_base_platform;
> 
> Seems like SAO should move into MMU features

I would argue it's the core/nest that orders/disorders things rather than the MMU.


Cheers,


Matt
