Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D7281A0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:27:28 +1000 (EST)
Message-ID: <537F228B.1030308@suse.de>
Date: Fri, 23 May 2014 12:27:23 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>		
 <537F1A8D.9000704@suse.de> <1400839224.28224.5.camel@ale.ozlabs.ibm.com>	
 <537F1D59.5090909@suse.de> <1400839918.28224.11.camel@ale.ozlabs.ibm.com>
In-Reply-To: <1400839918.28224.11.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.05.14 12:11, Michael Neuling wrote:
>>>> Also, is there any performance penalty associated with split core mode?
>>>> If not, could we just always default to split-by-4 on POWER8 bare metal?
>>> Yeah, there is a performance hit .  When you are split (ie
>>> subcores_per_core = 2 or 4), the core is stuck in SMT8 mode.  So if you
>>> only have 1 thread active (others napped), you won't get the benefit of
>>> ST mode in the core (more register renames per HW thread, more FXUs,
>>> more FPUs etc).
>> Ok, imagine I have 1 core with SMT8. I have one process running at 100%
>> occupying one thread, the other 7 threads are idle.
>>
>> Do I get performance benefits from having the other threads idle? Or do
>> I have to configure the system into SMT1 mode to get my ST benefits?
> You automatically get the performance benefit when they are idle.  When
> threads enter nap, the core is able to reduce it's SMT mode
> automatically.

Unless in split core mode - meh. That's a real bummer then, yeah.


>
>> If it's the latter, we could just have ppc64_cpu --smt=x also set the
>> subcore amount in parallel to the thread count.
> FWIW on powernv we just nap the threads on hotplug.
>
>> The reason I'm bringing this up is that I'm not quite sure who would be
>> the instance doing these performance tweaks. So I'd guess the majority
>> of users will simply miss out on them.
> Everyone, it's automatic on idle... except for split core mode
> unfortunately.

Oh I meant when you want to use a POWER system as VM host, you have to 
know about split core mode and configure it accordingly. That's 
something someone needs to do. And it's different from x86 which means 
people may miss out on it for their performance benchmarks.

But if we impose a general performance penalty for everyone with it, I 
don't think split core mode should be enabled by default.


Alex
