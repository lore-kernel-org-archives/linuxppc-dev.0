Return-Path: <avolkov@varma-el.com>
Message-ID: <4BE6BA7D.7030700@varma-el.com>
Date: Sun, 09 May 2010 17:37:01 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: Fix [e]glibc build process
References: <4BE5C203.6060509@varma-el.com>
	<1273375269.5312.4.camel@norville.austin.ibm.com>
In-Reply-To: <1273375269.5312.4.camel@norville.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dave Kleikamp wrote:
> On Sat, 2010-05-08 at 23:56 +0400, Andrey Volkov wrote:
>   
>> This patch fix [e]glibc build process destruction (more precisely _assembler_
>> is die when try to compile getcontext.S since stdint.h coldn't be assembled)
>> intruduced by patch:
>>
>> commit: 162d92dfb79a0b5fc03380b8819fa5f870ebf1e
>> Date: Mon, 8 Feb 2010 11:51:05 +0000 (11:51 +0000)
>> from: Dave Kleikamp
>>
>> Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
>>
>> ---
>>
>>  arch/powerpc/include/asm/ptrace.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>>
>> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
>> index 9e2d84c..025912b 100644
>> --- a/arch/powerpc/include/asm/ptrace.h
>> +++ b/arch/powerpc/include/asm/ptrace.h
>> @@ -27,8 +27,10 @@
>>  #ifdef __KERNEL__
>>  #include <linux/types.h>
>>  #else
>> +#ifndef __ASSEMBLY__
>>  #include <stdint.h>
>>  #endif
>> +#endif
>>
>>  #ifndef __ASSEMBLY__
>>     
>
> Assembly code won't need to pull in linux/types.h either, so this would
> be simpler:
>   
Questionable assertion. "linux/types.h" contain (indirectly) not only 
types definitions, but some useful, for assembly, defines too.
So patch, which Sam Ravnborg offered, is better for me (if it will work 
certainly ;)).

--
Andrey Volkov

> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 9e2d84c..0ed710e 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -24,14 +24,14 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> +#ifndef __ASSEMBLY__
> +
>  #ifdef __KERNEL__
>  #include <linux/types.h>
>  #else
>  #include <stdint.h>
>  #endif
>  
> -#ifndef __ASSEMBLY__
> -
>  struct pt_regs {
>  	unsigned long gpr[32];
>  	unsigned long nip;
>
>   
