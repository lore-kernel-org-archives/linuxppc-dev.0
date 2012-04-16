Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79529B7020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 23:22:10 +1000 (EST)
Subject: Re: [PATCH v2] KVM: PPC: Use clockevent multiplier and shifter for
 decrementer
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1333946027-20674-1-git-send-email-bharat.bhushan@freescale.com>
Date: Mon, 16 Apr 2012 15:22:05 +0200
Message-Id: <C97BA032-96CE-4A02-862A-AB77C84D53A8@suse.de>
References: <1333946027-20674-1-git-send-email-bharat.bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.04.2012, at 06:33, Bharat Bhushan wrote:

> Time for which the hrtimer is started for decrementer emulation is =
calculated using tb_ticks_per_usec. While hrtimer uses the clockevent =
for DEC reprogramming (if needed) and which calculate timebase ticks =
using the multiplier and shifter mechanism implemented within clockevent =
layer. It was observed that this conversion (timebase->time->timebase) =
are not correct because the mechanism are not consistent. In our setup =
it adds 2% jitter.
>=20
> With this patch clockevent multiplier and shifter mechanism are used =
when starting hrtimer for decrementer emulation. Now the jitter is < =
0.5%.
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v2:
> - decrementer_clockevent is made non-static rather than a seprate API =
to get mult/shift
>=20
> arch/powerpc/include/asm/time.h |    1 +
> arch/powerpc/kernel/time.c      |    2 +-
> arch/powerpc/kvm/emulate.c      |    5 +++--
> 3 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/time.h =
b/arch/powerpc/include/asm/time.h
> index 7eb10fb..b3c7959 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -28,6 +28,7 @@
> extern unsigned long tb_ticks_per_jiffy;
> extern unsigned long tb_ticks_per_usec;
> extern unsigned long tb_ticks_per_sec;
> +extern struct clock_event_device decrementer_clockevent;
>=20
> struct rtc_time;
> extern void to_tm(int tim, struct rtc_time * tm);
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 567dd7c..e237225 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -105,7 +105,7 @@ static int decrementer_set_next_event(unsigned =
long evt,
> static void decrementer_set_mode(enum clock_event_mode mode,
> 				 struct clock_event_device *dev);
>=20
> -static struct clock_event_device decrementer_clockevent =3D {
> +struct clock_event_device decrementer_clockevent =3D {

This one also needs a EXPORT_SYMBOL ...

> 	.name           =3D "decrementer",
> 	.rating         =3D 200,
> 	.irq            =3D 0,
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index afc9154..c8b5206 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -23,6 +23,7 @@
> #include <linux/types.h>
> #include <linux/string.h>
> #include <linux/kvm_host.h>
> +#include <linux/clockchips.h>
>=20
> #include <asm/reg.h>
> #include <asm/time.h>
> @@ -104,8 +105,8 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
> 	 */
>=20
> 	dec_time =3D vcpu->arch.dec;
> -	dec_time *=3D 1000;
> -	do_div(dec_time, tb_ticks_per_usec);
> +	dec_time =3D dec_time << decrementer_clockevent.shift;
> +	do_div(dec_time, decrementer_clockevent.mult);

... because emulate.c can be built as a module.


Alex
