Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 06CEBB6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 09:56:23 +1100 (EST)
Subject: Re: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point
 support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F0B700B.7020006@freescale.com>
Date: Mon, 9 Jan 2012 23:56:15 +0100
Message-Id: <71600EC1-EE7C-417D-93DD-C1BBC9E5E760@suse.de>
References: <20111221013445.GO8378@schlenkerla.am.freescale.net>
 <F0432B7A-E742-48B0-8016-3F2D0A800553@suse.de>
 <4F0B60A5.1040208@freescale.com>
 <08DCCAC0-82FA-46FC-974C-E7CCA53474A3@suse.de>
 <4F0B6C91.1090102@freescale.com>
 <96605829-1BD3-4668-AEB8-7D27775C2868@suse.de>
 <4F0B700B.7020006@freescale.com>
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


On 09.01.2012, at 23:54, Scott Wood wrote:

> On 01/09/2012 04:47 PM, Alexander Graf wrote:
>>=20
>> On 09.01.2012, at 23:39, Scott Wood wrote:
>>=20
>>> On 01/09/2012 04:17 PM, Alexander Graf wrote:
>>>>=20
>>>> On 09.01.2012, at 22:48, Scott Wood wrote:
>>>>=20
>>>>> On 01/09/2012 11:48 AM, Alexander Graf wrote:
>>>>>> I'm having a hard time to grasp when shared->msr, shadow_msr and =
regs->msr is used in your code :).
>>>>>=20
>>>>> shadow_msr is the real MSR.
>>>>>=20
>>>>> shared->msr is the guest's view of MSR.
>>>=20
>>> Correction -- this applies to PR-mode (e500v2).
>>>=20
>>> In GS-mode, shadow_msr is not used.  The guest sees the real MSR (hw
>>> silently prevents it from modifying certain bits), which gets saved =
on
>>> exit into shared->msr.
>>=20
>> Hrm. Can we maybe #ifdef out shadow_msr on HV then? I'm really =
getting confused with having 3 potential msr variables in the vcpu =
struct.
>=20
> An ifdef would take us further down the road of not being able to
> support both in the same kernel image (not sure whether that's a
> long-term goal -- probably won't happen any time soon with =
e500v2+e500mc
> even disregarding KVM, but maybe it'll be relevant on some other =
chips),
> and in general increase the mess in the struct definition.  How about =
a
> comment?

Well, I'd like to make sure we don't accidentally access the wrong =
field. But yes, a comment should be ok.

Alex
