Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 76BA2B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 09:54:14 +1100 (EST)
Message-ID: <4F0B700B.7020006@freescale.com>
Date: Mon, 9 Jan 2012 16:54:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point
 support
References: <20111221013445.GO8378@schlenkerla.am.freescale.net>
 <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
 <4F0B60A5.1040208@freescale.com>
 <08DCCAC0-82FA-46FC-974C-E7CCA53474A3@suse.de>
 <4F0B6C91.1090102@freescale.com>
 <96605829-1BD3-4668-AEB8-7D27775C2868@suse.de>
In-Reply-To: <96605829-1BD3-4668-AEB8-7D27775C2868@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 04:47 PM, Alexander Graf wrote:
> 
> On 09.01.2012, at 23:39, Scott Wood wrote:
> 
>> On 01/09/2012 04:17 PM, Alexander Graf wrote:
>>>
>>> On 09.01.2012, at 22:48, Scott Wood wrote:
>>>
>>>> On 01/09/2012 11:48 AM, Alexander Graf wrote:
>>>>> I'm having a hard time to grasp when shared->msr, shadow_msr and regs->msr is used in your code :).
>>>>
>>>> shadow_msr is the real MSR.
>>>>
>>>> shared->msr is the guest's view of MSR.
>>
>> Correction -- this applies to PR-mode (e500v2).
>>
>> In GS-mode, shadow_msr is not used.  The guest sees the real MSR (hw
>> silently prevents it from modifying certain bits), which gets saved on
>> exit into shared->msr.
> 
> Hrm. Can we maybe #ifdef out shadow_msr on HV then? I'm really getting confused with having 3 potential msr variables in the vcpu struct.

An ifdef would take us further down the road of not being able to
support both in the same kernel image (not sure whether that's a
long-term goal -- probably won't happen any time soon with e500v2+e500mc
even disregarding KVM, but maybe it'll be relevant on some other chips),
and in general increase the mess in the struct definition.  How about a
comment?

-Scott
