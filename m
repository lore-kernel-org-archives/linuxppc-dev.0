Return-Path: <mohan@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71F11DDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 15:32:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6I5YqtH014587
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:34:52 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6I5WPUB234450
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:32:25 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6I5WOuu032445
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:32:25 -0400
Message-ID: <48802AE0.30105@in.ibm.com>
Date: Fri, 18 Jul 2008 11:02:16 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC v3 PATCH 1/4] Extract list of relocation offsets
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop>
In-Reply-To: <1216325187.7740.353.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-07-18 at 00:10 +0530, Mohan Kumar M wrote:
>> Extract list of relocation offsets
>>
>> Extract list of offsets in the vmlinux file for which the relocation
>> delta has to be patched. Currently only following type of relocation
>> types are considered: R_PPC64_ADDR16_HI, R_PPC64_TOC and R_PPC64_ADDR64
>>
>> The offsets are sorted according to the relocation type and this
>> information is appended to the normal vmlinux file by using the patch
>> relocation_build.patch
> 
> Please, provide an indication of what changed since the previous
> version of the patch to make the reviewer's life easier !
>
Hi,

Oops, I missed out the detailed change description. Thanks Ben for 
pointing this.

Here is a change summary from v2 to v3:

PATCH 1:
The difference is relocs.c is moved to arch/powerpc/boot from arch/powerpc/

PATCH 2:
Relocation build support is now 90% integrated with kernel build 
process. Earlier one has to run separately different make to build 
vmlinux.reloc image. Required linker scripts are moved to 
arch/powerpc/boot from arch/powerpc

PATCH 3:
The difference is reloc_apply.S is moved to arch/powerpc/boot from 
arch/powerpc/

PATCH 4:
Enough care is taken when creating bolted mapping for kdump kernel. Now 
it creates bolted mapping from 32MB to of size "crash kernel size" in 
case of crash kernel.

Regards,
Mohan.
