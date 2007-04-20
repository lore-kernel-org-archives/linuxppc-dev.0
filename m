Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20D5BDDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 05:26:07 +1000 (EST)
In-Reply-To: <20070420005616.GA14382@localhost.localdomain>
References: <20070419065430.GA5862@localhost.localdomain>
	<CE8B1295-3D26-4495-99B9-3448E3CE69D9@kernel.crashing.org>
	<20070420005616.GA14382@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF8B20FF-04EA-4656-8CF6-EAB28932D424@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: powerpc: Start splitting up mmu.h by MMU type
Date: Fri, 20 Apr 2007 14:26:02 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2007, at 7:56 PM, David Gibson wrote:

> On Thu, Apr 19, 2007 at 07:11:07AM -0500, Kumar Gala wrote:
>>
>> On Apr 19, 2007, at 1:54 AM, David Gibson wrote:
>>
>>> This patch makes a start to sorting out the tangled mess of MMU
>>> related header files in asm-powerpc, and weaning arch/powerpc off  
>>> the
>>> remaining asm-ppc headers it uses.
>>>
>>> Specifically it splits the ppc64 specific (or more strictly, the
>>> 64-bit hash table specific) parts of asm-powerpc/mmu.h into its own
>>> file, asm-powerpc/mmu-hash64/mmu.h.  Similarly, PowerPC 44x
>>> definitions are taken from asm-ppc/mmu.h, trimmed down for use in
>>> arch/powerpc and place in their own file, asm-powerpc/mmu-44x/mmu.h.
>>>
>>> mmu.h definitions for other 32-bit MMU types remain in asm-ppc/mmu.h
>>> for now, but should be likewise split into their own files.
>>
>> I asked this before, but why the need for a separate directory per
>> mmu type?  why not just include/asm-powerpc/mmu-44x.h?
>
> Because I have further patches in the works that add MMU specific
> versions of tlbflush.h, pgtable.h and so forth to the same
> directories.

Well I agree pgtable.h getting split wouldn't be a bad idea.  But  
tlbflush.h is only 146 lines, splitting it doesn't seem worth the  
trouble.  So having a mmu-44x, mmu-hash32, mmu-hash64, mmu-8xx, mmu- 
fsl_booke, mmu-40x for just two files seems a bit much.

> I'm not wedded to the idea, but it seemed like a reasonable way to
> organize things.

- k
