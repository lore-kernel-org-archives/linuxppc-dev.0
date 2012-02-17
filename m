Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A865B6F62
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 05:59:09 +1100 (EST)
Message-ID: <4F3EA36E.50109@freescale.com>
Date: Fri, 17 Feb 2012 12:58:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu-B13201 <B13201@freescale.com>
Subject: Re: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <4F3D3933.3020501@freescale.com>
 <4CA99838F21AB847ACC344051E2317090571F056@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <4CA99838F21AB847ACC344051E2317090571F056@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 04:03 AM, Liu Yu-B13201 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Friday, February 17, 2012 1:13 AM
>> To: Liu Yu-B13201
>> Cc: agraf@suse.de; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
>> linuxppc-dev@ozlabs.org; Wood Scott-B07421
>> Subject: Re: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
>>
>> On 02/16/2012 03:26 AM, Liu Yu wrote:
>>> from the kvm guest paravirt init code.
>>>
>>> Signed-off-by: Liu Yu <yu.liu@freescale.com>
>>> ---
>>> v4:
>>> 1. code cleanup
>>> 2. move kvm_hypercall_start() to epapr_hypercall_start()
>>>
>>>  arch/powerpc/Kconfig                    |    4 ++
>>>  arch/powerpc/include/asm/epapr_hcalls.h |    2 +
>>>  arch/powerpc/kernel/Makefile            |    1 +
>>>  arch/powerpc/kernel/epapr.S             |   25 ++++++++++++++++
>>>  arch/powerpc/kernel/epapr_para.c        |   49
>> +++++++++++++++++++++++++++++++
>>>  arch/powerpc/kernel/kvm.c               |   28 ++----------------
>>>  arch/powerpc/kernel/kvm_emul.S          |   10 ------
>>>  arch/powerpc/kvm/Kconfig                |    1 +
>>>  8 files changed, 85 insertions(+), 35 deletions(-)  create mode
>>> 100644 arch/powerpc/kernel/epapr.S  create mode 100644
>>> arch/powerpc/kernel/epapr_para.c
>>
>> The comment about spelling out "paravirt" wasnn't meant to be restricted
>> to the kconfig symbol.  There are lots of words that begin with "para",
>> and ePAPR isn't just about virtualization.
> 
> What do you mean? Do you suggest that we should name it epapr_paravirt.c?

Yes, and likewise with variables and functions and such (at least
anything that is exposed outside a single file).

-Scott
