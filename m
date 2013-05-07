Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EE842C012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 12:06:56 +1000 (EST)
Date: Mon, 6 May 2013 21:06:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
To: tiejun.chen <tiejun.chen@windriver.com>
In-Reply-To: <51885F49.6060605@windriver.com> (from
 tiejun.chen@windriver.com on Mon May  6 20:56:25 2013)
Message-ID: <1367892390.3398.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2013 08:56:25 PM, tiejun.chen wrote:
> On 05/07/2013 07:50 AM, Scott Wood wrote:
>> On 05/05/2013 10:13:17 PM, tiejun.chen wrote:
>>> On 05/06/2013 11:10 AM, Tiejun Chen wrote:
>>>> For the external interrupt, the decrementer exception and the =20
>>>> doorbell
>>>> excpetion, we also need to soft-disable interrupts while doing as =20
>>>> host
>>>> interrupt handlers since the DO_KVM hook is always performed to =20
>>>> skip
>>>> EXCEPTION_COMMON then miss this original chance with the 'ints' =20
>>>> (INTS_DISABLE).
>>=20
>> http://patchwork.ozlabs.org/patch/241344/
>> http://patchwork.ozlabs.org/patch/241412/
>>=20
>> :-)
>=20
> I'm observing the same behaviour as well:
>=20
> 	WARN_ON_ONCE(!irqs_disabled());

So, could you explain the benefits of your approach over what's being =20
discussed in those threads?

>> Why wouldn't we always disable them?  kvmppc_handle_exit() will =20
>> enable
>> interrupts when it's ready.
>=20
> This only disable soft interrupt for kvmppc_restart_interrupt() that =20
> restarts interrupts if they were meant for the host:
>=20
> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL | =20
> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL

Those aren't the only exceptions that can end up going to the host.  We =20
could get a TLB miss that results in a heavyweight MMIO exit, etc.

And I'd rather see any fix for this problem stay out of the asm code.

> b. bl      kvmppc_handle_exit
>=20
> c. kvmppc_handle_exit()
> {
>         int r =3D RESUME_HOST;
>         int s;
>=20
>         /* update before a new last_exit_type is rewritten */
>         kvmppc_update_timing_stats(vcpu);
>=20
>         /* restart interrupts if they were meant for the host */
>         kvmppc_restart_interrupt(vcpu, exit_nr);
>=20
>         local_irq_enable();	=3D=3D> Enable again.
> ....
>=20
> And shouldn't we handle kvmppc_restart_interrupt() like the original =20
> HOST flow?
>=20
> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, =20
> ack)           \
>         =20
> START_EXCEPTION(label);                                         \
>         NORMAL_EXCEPTION_PROLOG(trapnum, intnum, =20
> PROLOG_ADDITION_MASKABLE)\
>         EXCEPTION_COMMON(trapnum, PACA_EXGEN, =20
> *INTS_DISABLE*)             \
> 	...

Could you elaborate on what you mean?

-Scott=
