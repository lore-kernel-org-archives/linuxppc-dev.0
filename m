Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAB23B7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 07:06:49 +1100 (EST)
Received: by iye19 with SMTP id 19so448295iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 12:06:45 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110215060158.GG1727@mail.wantstofly.org>
References: <20110211125213.GE1240@mail.wantstofly.org>
	<20110214180715.GA30647@angua.secretlab.ca>
	<20110215060158.GG1727@mail.wantstofly.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 15 Feb 2011 13:06:25 -0700
Message-ID: <AANLkTik0dfSEjBko5gQbHu3kgrGby3NhQjNrU78mkmWz@mail.gmail.com>
Subject: Re: [PATCH] powerpc: irq_data conversion
To: Lennert Buytenhek <buytenh@wantstofly.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 11:01 PM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> On Mon, Feb 14, 2011 at 11:07:15AM -0700, Grant Likely wrote:
>
>> > This patch converts powerpc over to the new irq_data based irq_chip
>> > functions, as was done earlier for ARM and some other architectures.
>> >
>> > struct irq_data is described here:
>> >
>> > =A0 =A0 http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6=
.git;a=3Dcommit;h=3Dff7dcd44dd446db2c3e13bdedf2d52b8e0127f16
>> >
>> > The new irq_chip functions are described here:
>> >
>> > =A0 =A0 http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6=
.git;a=3Dcommit;h=3Df8822657e799b02c55556c99a601261e207a299d
>> >
>> > As I don't have powerpc hardware myself, this hasn't been well-tested
>> > at all -- build and run-time testing would be much appreciated.
>>
>> Apply warning:
>>
>> /home/grant/hacking/linux-2.6/.git/rebase-apply/patch:3470: space before=
 tab in indent.
>> =A0 =A0 =A0 .irq_mask_ack =A0 =3D uic_mask_ack_irq,
>> warning: 1 line adds whitespace errors.
>
> The original uic.c already had the space there, but yes, there's no
> reason not to fix that while we're at it -- thanks.

Particularly when you're touching that particular line.  :-)

More errors with ppc64_defconfig:

02/15 12:55:39 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/sysdev/mpic.c: In
function 'mpic_from_ipi': 02/15 12:55:39 ERROR|base_utils:0106|
[stderr] /home/autotest/data/kernelcross/linux/arch/powerpc/sysdev/mpic.c:6=
41:
error: 'struct irq_desc' has no member named 'chip_data' 02/15
12:55:39 ERROR|base_utils:0106| [stderr] make[2]: ***
[arch/powerpc/sysdev/mpic.o] Error 1


02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_virq_setup':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:205:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_irq_plug_destroy':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:299:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_event_receive_port_destroy':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:360:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_io_irq_destroy':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:495:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_vuart_irq_destroy':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:556:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:
In function 'ps3_spe_irq_destroy':
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:608:
error: passing argument 1 of 'ps3_chip_mask' makes pointer from
integer without a cast
02/15 12:55:58 ERROR|base_utils:0106| [stderr]
/home/autotest/data/kernelcross/linux/arch/powerpc/platforms/ps3/interrupt.=
c:102:
note: expected 'struct irq_data *' but argument is of type 'unsigned
int'
02/15 12:55:58 ERROR|base_utils:0106| [stderr] make[3]: ***
[arch/powerpc/platforms/ps3/interrupt.o] Error 1

Also running it through the ozlabs build tester again:

http://kisskb.ellerman.id.au/kisskb/branch/13/

Results should be available there sometime in the next 6-12 hours

g.

>
>
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platfor=
ms/pasemi/setup.c
> index f372ec1..a6067b3 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -240,7 +240,7 @@ static __init void pas_init_IRQ(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nmi_virq =3D irq_create_mapping(NULL, *nmi=
prop);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpic_irq_set_priority(nmi_virq, 15);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISIN=
G);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpic_unmask_irq(nmi_virq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpic_unmask_irq(irq_get_irq_data(nmi_virq))=
;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0of_node_put(mpic_node);
> @@ -266,7 +266,7 @@ static int pas_machine_check_handler(struct pt_regs *=
regs)
> =A0 =A0 =A0 =A0if (nmi_virq !=3D NO_IRQ && mpic_get_mcirq() =3D=3D nmi_vi=
rq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "NMI delivered\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0debugger(regs);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpic_end_irq(nmi_virq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpic_end_irq(irq_get_irq_data(nmi_virq));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
>
>> I'm running it through the ozlabs build tester:
>>
>> http://kisskb.ellerman.id.au/kisskb/branch/13/
>>
>> Results should be available there sometime in the next 6-12 hours
>
> Great, thanks.
>
>
> thanks,
> Lennert
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
