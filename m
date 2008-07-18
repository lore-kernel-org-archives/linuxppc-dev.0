Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5294ADE2B1
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 02:59:02 +1000 (EST)
In-Reply-To: <48802AE0.30105@in.ibm.com>
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d8d07a180aaf59d25936ad03c7287f5a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC v3 PATCH 1/4] Extract list of relocation offsets
Date: Fri, 18 Jul 2008 12:00:49 -0500
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: paulus@samba.org, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jul 18, 2008, at 12:32 AM, Mohan Kumar M wrote:
> Benjamin Herrenschmidt wrote:
>> On Fri, 2008-07-18 at 00:10 +0530, Mohan Kumar M wrote:
>>> Extract list of relocation offsets
>>>
>> Please, provide an indication of what changed since the previous
>> version of the patch to make the reviewer's life easier !
>>
> Hi,
>
> Oops, I missed out the detailed change description. Thanks Ben for 
> pointing this.
>
> Here is a change summary from v2 to v3:


Last night I was trying the patches on the current upstream git, but 
was not able to get the dump kernel to user space.   Part of the 
problem was my own making (my default kernel is patched to crash dump 
to 16M instead of 32M among other patches, so I needed to go to a 
normal kernel first, but couldn't use the reloc kernel because the 
slaves would stick and then the code would wait in the IPI).

I now understand why the remaining cpus do not make it into the crash 
kernel.   In fact they don't make it from kexec of a good kernel into a 
reloc kernel.  I'm ignoring that for now because, as I told you via 
chat, I realize from looking at the patches that the reloc_apply code 
needs to move from the external wrapper to inside the kernel init 
section or maybe the head, even if the reloc data is applied after the 
link of vmlinux.  While I still need to work out the details to supply 
it with the data, I'm convinced its the best way to eliminate the extra 
move of the kernel image.  (My current guess is to count the 
relocations on the first vmlinux and supply a dummy section of the 
correct size that can be replaced with objcopy once the link is 
complete).

If I don't get this done, we should change the build to just use the 
slave hold loop from the kernel directly,
similar to what I put in kexec-tools with purgatory.

> PATCH 1:
> The difference is relocs.c is moved to arch/powerpc/boot from 
> arch/powerpc/
>
> PATCH 2:
> Relocation build support is now 90% integrated with kernel build 
> process. Earlier one has to run separately different make to build 
> vmlinux.reloc image. Required linker scripts are moved to 
> arch/powerpc/boot from arch/powerpc

vmlinux-reloc.scr was missing.  I found it in v2.   Also, I had to find 
it in $(srctree)/$(src) since it is not generated like lds files.


>
> PATCH 3:
> The difference is reloc_apply.S is moved to arch/powerpc/boot from 
> arch/powerpc/
>
> PATCH 4:
> Enough care is taken when creating bolted mapping for kdump kernel. 
> Now it creates bolted mapping from 32MB to of size "crash kernel size" 
> in case of crash kernel.

The patch does not apply anymore because create_trampoline has changed.

There seem to be way too many places we have RELOC and the relocation 
offset applied.   While I expected the uses of PHYSICAL_OFFSET and 
existing uses of CONFIG_CRASH_DUMP, there seem to be lots of other 
changes, and to me it feels like trying to make up for missing 
relocation processing with code.  That is precisely what we were trying 
to avoid when we selected the emit_relocs and process them approach.


I might give another go at using the existing patches, but if you 
rediff, can you sepearte patch 4 into two parts, one that does stuff 
around PHYSICAL_START or CRASH_DUMP, and one that does the rest?

Thanks,
milton
