Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7C43EB6FDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 09:47:29 +1100 (EST)
Subject: Re: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point
 support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F0B6C91.1090102@freescale.com>
Date: Mon, 9 Jan 2012 23:47:21 +0100
Message-Id: <96605829-1BD3-4668-AEB8-7D27775C2868@suse.de>
References: <20111221013445.GO8378@schlenkerla.am.freescale.net>
 <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
 <4F0B60A5.1040208@freescale.com>
 <08DCCAC0-82FA-46FC-974C-E7CCA53474A3@suse.de>
 <4F0B6C91.1090102@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.01.2012, at 23:39, Scott Wood wrote:

> On 01/09/2012 04:17 PM, Alexander Graf wrote:
>>=20
>> On 09.01.2012, at 22:48, Scott Wood wrote:
>>=20
>>> On 01/09/2012 11:48 AM, Alexander Graf wrote:
>>>>=20
>>>> Do you think it's possible to combine this with the book3s_pr code, =
so we don't duplicate too much here?
>>>=20
>>> book3s_pr is a bit different in that it can trap when the guest sets
>>> MSR[FP].
>>=20
>> Ah, there's no doorbell? So you always have to swap fpu registers? =
You still have to enable it manually when preempting in, right? IIRC =
ppc32 does lazy fpu activation.
>=20
> Right.
>=20
> Preempting in is handled by calling kvmppc_load_guest_fp() (which =
should
> be renamed to be booke-specific, since the semantics are tied to
> booke.c) from kvmppc_core_vcpu_load() in e500mc.c.

Ah, and that one's called on sched_in. All is well then :).

>=20
>>>> I'm having a hard time to grasp when shared->msr, shadow_msr and =
regs->msr is used in your code :).
>>>=20
>>> shadow_msr is the real MSR.
>>>=20
>>> shared->msr is the guest's view of MSR.
>=20
> Correction -- this applies to PR-mode (e500v2).
>=20
> In GS-mode, shadow_msr is not used.  The guest sees the real MSR (hw
> silently prevents it from modifying certain bits), which gets saved on
> exit into shared->msr.

Hrm. Can we maybe #ifdef out shadow_msr on HV then? I'm really getting =
confused with having 3 potential msr variables in the vcpu struct.


Alex
