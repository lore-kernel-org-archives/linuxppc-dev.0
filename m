Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65F141A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:05:17 +1000 (EST)
Message-ID: <537F1D59.5090909@suse.de>
Date: Fri, 23 May 2014 12:05:13 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2 0/6] Implement split core for POWER8
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>	
 <537F1A8D.9000704@suse.de> <1400839224.28224.5.camel@ale.ozlabs.ibm.com>
In-Reply-To: <1400839224.28224.5.camel@ale.ozlabs.ibm.com>
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


On 23.05.14 12:00, Michael Neuling wrote:
> On Fri, 2014-05-23 at 11:53 +0200, Alexander Graf wrote:
>> On 23.05.14 10:15, Michael Neuling wrote:
>>> This patch series implements split core mode on POWER8.  This enables up to 4
>>> subcores per core which can each independently run guests (per guest SPRs like
>>> SDR1, LPIDR etc are replicated per subcore).  Lots more documentation on this
>>> feature in the code and commit messages.
>>>
>>> Most of this code is in the powernv platform but there's a couple of KVM
>>> specific patches too.
>>>
>>> Patch series authored by mpe and me with a few bug fixes from others.
>>>
>>> v2:
>>>     There are some minor updates based on comments and I've added the Acks by
>>>     Paulus and Alex for the KVM code.
>> I don't see changelogs inside the individual patches. Please make sure
>> to always mention what changed from one version to the next in a
>> particular patch, so that I have the chance to check whether that change
>> was good :).
> Sure, that was a bit sloppy
>
> Only the last patch was the only one that changed.  I changed the sysfs
> file from 600 permissions to 644 so that users can read it more easily
> as requested by Joel.
>
> The other change was to fix the possibility of a race when coming out of
> nap and checking if we need to split.  This fix was form paulus' (worked
> offline).
>
>> Also, is there any performance penalty associated with split core mode?
>> If not, could we just always default to split-by-4 on POWER8 bare metal?
> Yeah, there is a performance hit .  When you are split (ie
> subcores_per_core = 2 or 4), the core is stuck in SMT8 mode.  So if you
> only have 1 thread active (others napped), you won't get the benefit of
> ST mode in the core (more register renames per HW thread, more FXUs,
> more FPUs etc).

Ok, imagine I have 1 core with SMT8. I have one process running at 100% 
occupying one thread, the other 7 threads are idle.

Do I get performance benefits from having the other threads idle? Or do 
I have to configure the system into SMT1 mode to get my ST benefits?

If it's the latter, we could just have ppc64_cpu --smt=x also set the 
subcore amount in parallel to the thread count.

The reason I'm bringing this up is that I'm not quite sure who would be 
the instance doing these performance tweaks. So I'd guess the majority 
of users will simply miss out on them.


Alex
