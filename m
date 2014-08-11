Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FAB91A0C1A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:15:42 +1000 (EST)
Message-ID: <53E889BA.40108@suse.de>
Date: Mon, 11 Aug 2014 11:15:38 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>	
 <53E87023.6080200@suse.de> <1407747061.4508.75.camel@pasglop>
In-Reply-To: <1407747061.4508.75.camel@pasglop>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.08.14 10:51, Benjamin Herrenschmidt wrote:
> On Mon, 2014-08-11 at 09:26 +0200, Alexander Graf wrote:
>>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>>> index da86d9b..d95014e 100644
>>> --- a/arch/powerpc/kvm/emulate.c
>>> +++ b/arch/powerpc/kvm/emulate.c
>> This should be book3s_emulate.c.
> Any reason we can't make that 00dddd00 opcode as breakpoint common to
> all powerpc variants ?

I can't think of a good reason. We use a hypercall on booke (which traps 
into an illegal instruction for pr) today, but I don't think it has to 
be that way.

Given that the user space API allows us to change it dynamically, there 
should be nothing blocking us from going with 00dddd00 always.


Alex
