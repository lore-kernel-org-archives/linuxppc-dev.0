Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB7AB2C0312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:13:46 +1000 (EST)
Date: Thu, 11 Jul 2013 09:13:36 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][PATCH 1/1] KVM: PPC: disable preemption when using
 hard_irq_disable()
To: tiejun.chen <tiejun.chen@windriver.com>
References: <1373436139-27998-1-git-send-email-tiejun.chen@windriver.com>
 <1373483740.8183.223@snotra> <51DE1FD1.90609@windriver.com>
In-Reply-To: <51DE1FD1.90609@windriver.com> (from tiejun.chen@windriver.com
 on Wed Jul 10 22:00:33 2013)
Message-ID: <1373552016.8183.242@snotra>
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

On 07/10/2013 10:00:33 PM, tiejun.chen wrote:
> On 07/11/2013 03:15 AM, Scott Wood wrote:
>> On 07/10/2013 01:02:19 AM, Tiejun Chen wrote:
>>> We should ensure the preemption cannot occur while calling =20
>>> get_paca()
>>> insdide hard_irq_disable(), otherwise the paca_struct may be the
>>> wrong one just after. And btw, we may update timing stats in this =20
>>> case.
>>=20
>> The soft-ee mechanism depends on accessing the PACA directly via r13 =20
>> to avoid
>> this.  We probably should be using inline asm to read was_enabled =20
>> rather than
>=20
> Yes.
>=20
>> hoping the compiler doesn't do anything silly.
>=20
> Do you recommend I should directly replace get_paca() with local_paca =20
> inside hard_irq_disable()?
>=20
> #define hard_irq_disable()      do {                    \
>         u8 _was_enabled =3D get_paca()->soft_enabled;     \
>=20
> ->	u8 _was_enabled =3D local_paca->soft_enabled;
>=20
> But is this safe for all scenarios?

get_paca() is just a #define for local_paca.  It won't make a =20
difference, other than to evade the debug check.

In practice, it's unlikely that GCC would do anything other than a load =20
directly from r13, but to be sure we should use inline asm to do the =20
load, just like arch_local_save_flags and arch_local_irq_disable do.

-Scott=
