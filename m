Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF162B6F13
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:18:56 +1100 (EST)
Subject: Re: [PATCH v4 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3D359E.6030209@freescale.com>
Date: Thu, 16 Feb 2012 18:18:52 +0100
Message-Id: <9A00D501-8965-478F-8356-6199F5572600@suse.de>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-3-git-send-email-yu.liu@freescale.com>
 <EAC043A1-A04F-4A27-8488-3C42D99D175E@suse.de>
 <4F3D359E.6030209@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 Liu Yu <yu.liu@freescale.com>, "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<B07421@freescale.com>" <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16.02.2012, at 17:58, Scott Wood wrote:

> On 02/16/2012 04:24 AM, Alexander Graf wrote:
>> On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:
>>> +_GLOBAL(epapr_ev_idle)
>>> +epapr_ev_idle:
>>> +    rlwinm    r3,r1,0,0,31-THREAD_SHIFT    /* current thread_info =
*/
>>> +    lwz    r4,TI_LOCAL_FLAGS(r3)    /* set napping bit */
>>> +    ori    r4,r4,_TLF_NAPPING    /* so when we take an exception */
>>> +    stw    r4,TI_LOCAL_FLAGS(r3)    /* it will return to our caller =
*/
>>> +
>>> +    wrteei    1
>>> +
>>> +idle_loop:
>>> +    LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)
>>> +
>>> +.global epapr_ev_idle_start
>>> +epapr_ev_idle_start:
>>> +    li    r3, -1
>>> +    nop
>>> +    nop
>>> +    nop
>>=20
>> Can't you just bl into epapr_hypercall_start? You don't even have to =
save the old lr. because we never return anyways :)
>=20
> The interrupt will branch to LR, so no, we can't trash it or put it
> anywhere else.

Hrm. But we can clobber ctr, right? So how about we make the generic =
version do a bctr and then just do a small C wrapper that takes lr, =
moves it to ctr and branches to the generic one?

Then we don't have to replicate the hypercall code all over again for =
every invocation.

Alex
