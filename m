Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F1F2C3A.3060607@gmail.com>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <1327352870-14687-14-git-send-email-grant.likely@secretlab.ca>
 <4F1F2C3A.3060607@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Jan 2012 17:26:37 -0700
Message-ID: <CACxGe6sP0p1r6u6uG5fhTf0jC85F=vX7Nj_YezQFE65caH+2Zg@mail.gmail.com>
Subject: Re: [RFCv2 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2012 at 3:10 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 01/23/2012 03:07 PM, Grant Likely wrote:
>> This patch removes the simplistic implementation of irq_domains and enab=
les
>> the powerpc infrastructure for all irq_domain users. =A0The powerpc
>> infrastructure includes support for complex mappings between Linux and
>> hardware irq numbers, and can manage allocation of irq_descs.
>>
>> This patch also converts the few users of irq_domain_add()/irq_domain_de=
l()
>> to call irq_domain_add_legacy() instead.
>>
>> v2: Fix removal of irq_alloc_descs() call in gic driver
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 85 ++++++++--=
---------
>> =A0arch/arm/common/vic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 +---
>> =A0arch/arm/include/asm/hardware/gic.h | =A0 =A04 +-
>> =A0arch/arm/include/asm/hardware/vic.h | =A0 =A02 +
>> =A0arch/arm/mach-exynos/common.c =A0 =A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/mach-versatile/core.c =A0 =A0 =A0| =A0 =A05 +-
>> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12 +--
>> =A0include/linux/irqdomain.h =A0 =A0 =A0 =A0 =A0 | =A0 45 +---------
>> =A0kernel/irq/irqdomain.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0159 +++-------=
-------------------------
>> =A09 files changed, 69 insertions(+), 261 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>
> snip
>
>> @@ -716,17 +708,17 @@ void __init gic_init_bases(unsigned int gic_nr, in=
t irq_start,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gic_irqs =3D 1020;
>> =A0 =A0 =A0 gic->gic_irqs =3D gic_irqs;
>>
>> - =A0 =A0 domain->nr_irq =3D gic_irqs - domain->hwirq_base;
>> - =A0 =A0 domain->irq_base =3D irq_alloc_descs(irq_start, 16, domain->nr=
_irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0numa_node_id());
>> - =A0 =A0 if (IS_ERR_VALUE(domain->irq_base)) {
>> + =A0 =A0 irq_base =3D irq_alloc_descs(irq_start, 16, gic_irqs - hwirq_b=
ase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0numa_no=
de_id());
>> + =A0 =A0 if (IS_ERR_VALUE(irq_base)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Cannot allocate irq_descs @ IRQ%d, =
assuming pre-allocated\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_start);
>> - =A0 =A0 =A0 =A0 =A0 =A0 domain->irq_base =3D irq_start;
>> + =A0 =A0 =A0 =A0 =A0 =A0 irq_base =3D irq_start;
>> =A0 =A0 =A0 }
>> - =A0 =A0 domain->host_data =3D gic;
>> - =A0 =A0 domain->ops =3D &gic_irq_domain_ops;
>> - =A0 =A0 irq_domain_add(domain);
>> + =A0 =A0 gic->domain =3D irq_domain_add_legacy(node, gic_irqs, irq_base=
,
>
> gic_irqs is wrong here. It needs 16 or 32 subtracted off. This patch
> will fix things:

Good catch, I've integrated this into my series.

g.
