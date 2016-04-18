Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpPK23KDXzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:19:50 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 15:49:47 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IAJiIi25297070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:49:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IAJfMh004238
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:49:43 +0530
Message-ID: <5714B4B7.2050005@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 18:19:35 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
CC: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160412143023.GH1087@worktop> <570E2A45.9080702@linux.vnet.ibm.com>
 <10192543.Wmc5qtLitu@wuerfel>
In-Reply-To: <10192543.Wmc5qtLitu@wuerfel>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年04月17日 03:43, Arnd Bergmann wrote:
> On Wednesday 13 April 2016 19:15:17 Pan Xinhui wrote:
>> Hello Peter,
>>
>> On 2016年04月12日 22:30, Peter Zijlstra wrote:
>>> On Sun, Apr 10, 2016 at 10:17:28PM +0800, Pan Xinhui wrote:
>>>>
>>>> On 2016年04月08日 15:47, Peter Zijlstra wrote:
>>>>> On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
>>>>>> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
>>>>>>
>>>>>> Implement xchg{u8,u16}{local,relaxed}, and
>>>>>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>>>>>>
>>>>>> Atomic operation on 8-bit and 16-bit data type is supported from power7
>>>>>
>>>>> And yes I see nothing P7 specific here, this implementation is for
>>>>> everything PPC64 afaict, no?
>>>>>
>>>> Hello Peter,
>>>> 	No, it's not for every ppc. So yes, I need add #ifdef here. Thanks for pointing it out.
>>>> We might need a new config option and let it depend on POWER7/POWER8_CPU or even POWER9...
>>>
>>> Right, I'm not sure if PPC has alternatives, but you could of course
>>> runtime patch the code from emulated with 32bit ll/sc to native 8/16bit
>>> ll/sc if present on the current CPU if you have infrastructure for these
>>> things.
>>>
>> seems interesting. I have no idea about how to runtime patch the code. I will try to learn that.
>> If so, we need change {cmp}xchg into uninline functions?
> 
> I think you don't need to, see do_feature_fixups()/patch_feature_section()
> 
Hello, Arnd
	thanks for your tips :) I will take a look at them.
This time I will make generic functions for all ppc. But in future, We will runtime patch the code.

> Note that an #ifdef by itself has to worry about any combination of
> architectures, so in a kernel that has both POWER6 and POWER7 enabled,
> you cannot call the POWER7-only function.
> 
seems your are right.
While I think it's not a good idea to enable several cpu types. just select the minimum supported cpu in real world. :)

thanks
xinhui
> 	Arnd
> 
