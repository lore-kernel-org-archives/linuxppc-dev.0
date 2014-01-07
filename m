Return-Path: <w90p710@gmail.com>
Message-ID: <52CBAB24.9070804@gmail.com>
Date: Tue, 07 Jan 2014 15:22:12 +0800
From: wyang <w90p710@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [question] Can the execution of the atomtic operation instruction
 pair lwarx/stwcx be interrrupted by local HW interruptions?
References: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>	
 <52C0D251.2000400@gmail.com>	
 <CABiPGEcHxgmuLMcMN1ByutJC22RJPHSZf3n5gF9BgenbfQTJvA@mail.gmail.com>	
 <52CA3ED7.2020407@gmail.com>	
 <1389045939.11795.104.camel@snotra.buserror.net>	
 <52CB51A4.7080303@gmail.com> <1389076538.11795.120.camel@snotra.buserror.net>
In-Reply-To: <1389076538.11795.120.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@lists.ozlabs.org, Gavin Hu <gavin.hu.2010@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01/07/2014 02:35 PM, Scott Wood wrote:
> On Tue, 2014-01-07 at 09:00 +0800, wyang wrote:
>> Yeah, Can you provide more detail info about why they can handle that
>> case? The following is my understand:
>>
>> Let us assume that there is a atomic global variable(var_a) and its
>> initial value is 0.
>>
>> The kernel attempts to execute atomic_add(1, var_a), after lwarx a async
>> interrupt happens, and the ISR also accesses "var_a" variable and
>> executes atomic_add.
>>
>> static __inline__ void atomic_add(int a, atomic_t *v)
>> {
>>       int t;
>>
>>       __asm__ __volatile__(
>> "1:    lwarx    %0,0,%3        # atomic_add\n\
>> ----------------------------------  <----------- interrupt
>> happens------->        ISR also operates this global variable "var_a"
>> such as also executing atomic_add(1, var_a). so the
>>                 var_a would is 1.
>>       add    %0,%2,%0\n"
>>       PPC405_ERR77(0,%3)
>> "    stwcx.    %0,0,%3 \n\ <----- After interrupt code returns, the
>> reservation is cleared. so CR0 is not equal to 0, and then jump the 1
>> label. the var_a will be 2.
>>       bne-    1b"
>>       : "=&r" (t), "+m" (v->counter)
>>       : "r" (a), "r" (&v->counter)
>>       : "cc");
>> }
>>
>> So the value of var_a is 2 rather than 1. Thats why i said that
>> atomic_add does not handle such case. If I miss something, please
>> correct me.:-)
> 2 is the correct result, since atomic_add(1, var_a) was called twice
> (once in the ISR, once in the interrupted context).
Scott, thanks for your confirmation. I guess that Gavin thought that 1 
is a correct result. So thats why I said that if he wanna get 1,
he should have responsibility to disable local interrupts. I mean that 
atomic_add is not able to guarantee that 1 is a correct result.:-)

Wei
>
> -Scott
>
>
>
