Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 027D2679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 02:16:11 +1000 (EST)
In-Reply-To: <20060406020313.186a74ad.sfr@canb.auug.org.au>
References: <11442138494042-git-send-email-sfr@canb.auug.org.au>
	<C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
	<20060406020313.186a74ad.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C1CE62AD-7989-4DCA-B7B3-8A107ACBD153@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] powerpc: move some header files
Date: Wed, 5 Apr 2006 11:15:04 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2006, at 11:03 AM, Stephen Rothwell wrote:

> On Wed, 5 Apr 2006 09:28:55 -0500 Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> How about we do the following to remove the include hack:
>>
>> don't move the following (determine what needs them to build and
>> fixup, I dont believe any of these need to exist at this point in
>> arch/powerpc for it to build any supported arch/powerpc platform:
>
> I only moved the files that were actually required to build the  
> defconfigs
> for the three 32 bit builds in arch/powerpc ...
>
>>   b/include/asm-powerpc/amigappc.h  |    9 ++----
>>   b/include/asm-powerpc/bootinfo.h  |    8 ++---
>>   b/include/asm-powerpc/mpc8xx.h    |   10 +++---
>>   b/include/asm-powerpc/ocp.h       |    7 ++--
>>   b/include/asm-powerpc/ocp_ids.h   |    6 ++--
>>   b/include/asm-powerpc/open_pic.h  |   10 +++---
>
> So maybe I could attempt to remove the dependencies instead of  
> moving the
> files.  You are right that it is worth it if we can just get rid of  
> these
> files.
>
>> Duplicate these headers (then I'll go through and clean them up,
>> removing arch/ppc'ism):
>>
>>   b/include/asm-powerpc/mpc83xx.h   |    7 ++--
>>   b/include/asm-powerpc/mpc85xx.h   |    9 ++----
>
> I guess that would work, but Paulus is going to not like me as he  
> already
> put all these patches into the powerpc tree.  :-)

That's Paulus own doing for his premature pull :)

> Something to keep me entertained for another day.

I'm guessing you had to pull some of them in because of the following:

io.h:#include <asm-ppc/io.h>
mmu_context.h:#include <asm-ppc/mmu_context.h>
mmu.h:#include <asm-ppc/mmu.h>
pci-bridge.h:#include <asm-ppc/pci-bridge.h>
pgalloc.h:#include <asm-ppc/pgalloc.h>
pgtable.h:#include <asm-ppc/pgtable.h>

I think addressing these will make life easier with the other includes.

- kumar
