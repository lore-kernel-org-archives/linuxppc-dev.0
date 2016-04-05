Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfLFD4jkxzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 17:33:36 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q129so608418pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 00:33:36 -0700 (PDT)
Subject: Re: [PATCH] spapr: Don't set the TM ibm,pa-features bit in PR KVM mode
To: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <20160405021201.GA2663@yogo.paulus.ozlabs.org>
 <20160405040941.GT16485@voom.fritz.box>
Cc: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, Alexander Graf <agraf@suse.de>,
 linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57036A47.8060707@ozlabs.ru>
Date: Tue, 5 Apr 2016 17:33:27 +1000
MIME-Version: 1.0
In-Reply-To: <20160405040941.GT16485@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2016 02:09 PM, David Gibson wrote:
> On Tue, Apr 05, 2016 at 12:12:01PM +1000, Paul Mackerras wrote:
>> On Mon, Apr 04, 2016 at 09:09:28PM +1000, Anton Blanchard wrote:
>>> We don't support transactional memory in PR KVM, so don't tell
>>> the OS that we do.
>>
>> This assumes PR KVM won't ever support TM, which is hopefully not
>> true.  If PR KVM does get TM support in future, then QEMU will have no
>> clear way to know whether it needs to clear the pa-features bit or
>> not.  I think we need to define some way for the KVM implementation to
>> tell qemu which of these kinds of CPU features it supports.
>
> Yeah, I think we need some sort of capability flag for this.  We also
> need to isolate this KVM capability testing better into the KVM code,
> so we won't break things on TCG.
>
> Speaking of which... I don't imagine we implement TM instructions in
> TCG either, so we should probably make sure TM isn't advertised there
> either.

TM is "supported" in TCG:

56a846157 "target-ppc: Introduce TM Noops"
===
     Add degenerate implementations of the non-privileged Transactional
     Memory instructions tend., tabort*. and tsr.  This implementation
     simply checks the MSR[TM] bit and then sets CR0 to 0b0000.  This
     is a reasonable degenerate implementation since transactions are
     never allowed to begin and hence MSR[TS] is always 0b00.

     Signed-off-by: Tom Musta <tommusta@gmail.com>
     Signed-off-by: Alexander Graf <agraf@suse.de>
===


-- 
Alexey
