Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w93Nr6wQRzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:58:52 +1000 (AEST)
Subject: Re: [PATCH v2 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>
References: <cover.1492778567.git.christophe.leroy@c-s.fr>
 <97d45054364142af48b8767f9f9e115504d7568b.1492778567.git.christophe.leroy@c-s.fr>
 <1492781365.w4t118903f.astroid@naverao1-tp.none>
 <87fuh1ynxd.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <ad2d30c6-d9ba-e188-e6dc-2afbc90af77a@c-s.fr>
Date: Sat, 22 Apr 2017 08:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <87fuh1ynxd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/04/2017 à 08:08, Michael Ellerman a écrit :
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Excerpts from Christophe Leroy's message of April 21, 2017 18:32:
>>> diff --git a/arch/powerpc/kernel/ftrace.c
>>> b/arch/powerpc/kernel/ftrace.c
>>> index 32509de6ce4c..06d2ac53f471 100644
>>> --- a/arch/powerpc/kernel/ftrace.c
>>> +++ b/arch/powerpc/kernel/ftrace.c
>>> @@ -46,6 +46,7 @@ static int
>>> @@ -67,10 +68,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
>>>  	}
>>>
>>>  	/* replace the text with the new text */
>>> -	if (patch_instruction((unsigned int *)ip, new))
>>> -		return -EPERM;
>>> +	set_kernel_text_rw(ip);
>>> +	err = patch_instruction((unsigned int *)ip, new);
>>> +	set_kernel_text_ro(ip);
>>
>> Is there a reason to not put those inside patch_instruction()?
>
> Yes and no.
>
> patch_instruction() is called quite early from apply_feature_fixups(), I
> haven't looked closely but I suspect the set_kernel_text_rx() routines
> won't work that early.
>
> But on the other hand patch_instruction() is used by things other than
> ftrace, like jump labels, so we probably want the rw/ro setting in there
> so that we don't have to go and fixup jump labels etc.
>
> So probably we need a raw_patch_instruction() which does just the
> patching (what patch_instruction() does now), and can be used early in
> boot. And then patch_instruction() would have the rw/ro change in it, so
> that all users of it are OK.
>
> eg ~=:
>
> int raw_patch_instruction(unsigned int *addr, unsigned int instr)
> {
>   ...
> }
>
> int patch_instruction(unsigned int *addr, unsigned int instr)
> {
> 	int err;
>
> 	set_kernel_text_rw(ip);
> 	err = raw_patch_instruction((unsigned int *)ip, new);
> 	set_kernel_text_ro(ip);
>
> 	return err;
> }
>

Shouldn't we then also have some kind of protection against parallel use 
of patch_instruction() like a spin_lock_irqsave(), or is it garantied 
not to happen for other reasons ?

Otherwise, we might end up with one instance setting back the kernel 
text to RO while the other one has just put it RW and is about to patch 
the instruction.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
