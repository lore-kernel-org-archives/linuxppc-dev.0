Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C73241413C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 01:54:46 +1000 (EST)
Message-ID: <536905C2.1030206@suse.de>
Date: Tue, 06 May 2014 17:54:42 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
Subject: Re: [PATCH v2 1/4] KVM: PPC: e500mc: Revert "add load inst fixup"
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-2-git-send-email-mihai.caraman@freescale.com>
 <53636436.60002@suse.de> <1399072472827.57968@freescale.com>
 <76DD19C1-EBCD-485A-B847-21304903E139@suse.de>
 <887e9723335940fdae0073000ba2d299@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <887e9723335940fdae0073000ba2d299@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 05:48 PM, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Sunday, May 04, 2014 1:14 AM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH v2 1/4] KVM: PPC: e500mc: Revert "add load inst
>> fixup"
>>
>>
>>
>> Am 03.05.2014 um 01:14 schrieb "mihai.caraman@freescale.com"
>> <mihai.caraman@freescale.com>:
>>
>>>> From: Alexander Graf <agraf@suse.de>
>>>> Sent: Friday, May 2, 2014 12:24 PM
>>> This was the first idea that sprang to my mind inspired from how DO_KVM
>>> is hooked on PR. I actually did a simple POC for e500mc/e5500, but this
>> will
>>> not work on e6500 which has shared IVORs between HW threads.
>> What if we combine the ideas? On read we flip the IVOR to a separate
>> handler that checks for a field in the PACA. Only if that field is set,
>> we treat the fault as kvm fault, otherwise we jump into the normal
>> handler.
>>
>> I suppose we'd have to also take a lock to make sure we don't race with
>> the other thread when it wants to also read a guest instruction, but you
>> get the idea.
> This might be a solution for TLB eviction but not for execute-but-not-read
> entries which requires access from host context.

Good point :).

>
>> I have no idea whether this would be any faster, it's more of a
>> brainstorming thing really. But regardless this patch set would be a move
>> into the right direction.
>>
>> Btw, do we have any guarantees that we don't get scheduled away before we
>> run kvmppc_get_last_inst()? If we run on a different core we can't read
>> the inst anymore. Hrm.
> It was your suggestion to move the logic from kvmppc_handle_exit() irq
> disabled area to kvmppc_get_last_inst():
>
> http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/arch/powerpc/kvm/booke.c
>
> Still, what is wrong if we get scheduled on another core? We will emulate
> again and the guest will populate the TLB on the new core.

Yes, it means we have to get the EMULATE_AGAIN code paths correct :). It 
also means we lose some performance with preemptive kernel configurations.


Alex
