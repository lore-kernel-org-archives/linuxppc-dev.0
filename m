Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2B3DB6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 16:35:52 +1100 (EST)
Received: by pbaa7 with SMTP id a7so952019pba.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 21:35:49 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F1F5FE0.9090901@gmail.com>
References: <1327450719-25590-1-git-send-email-grant.likely@secretlab.ca>
 <4F1F5FE0.9090901@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Jan 2012 22:35:28 -0700
Message-ID: <CACxGe6s3R0fcBSf_YHTpXp15gtEBHRQg5-YM=cDO5UfY9cRGrQ@mail.gmail.com>
Subject: Re: [RFC 1/2] irq_domain: Create common xlate functions that device
 drivers can use
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2012 at 6:50 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>
> On 01/24/2012 06:18 PM, Grant Likely wrote:
>> Rather than having each interrupt controller driver creating its own bar=
ely
>> unique .xlate function for irq_domain, create a library of translators w=
hich
>> any driver can use directly.
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index e7379a3..5e497a0 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -110,6 +110,9 @@ struct irq_domain {
>> =A0 =A0 =A0 void *host_data;
>> =A0 =A0 =A0 irq_hw_number_t inval_irq;
>>
>> + =A0 =A0 /* Data for common irq xlate functions */
>> + =A0 =A0 unsigned int xlate_type;
>> +
>
> How does this get set? Do we want interrupt controllers messing with the
> domain struct directly long term?

It defaults to IRQ_TYPE_NONE in the alloc function and drivers can
override it.  Alternately it could be made part of the
irq_domain_add() arguments, but I'm not thrilled with adding a whole
bunch of arguments to the function prototype.

>
>> =A0 =A0 =A0 /* Optional device node pointer */
>> =A0 =A0 =A0 struct device_node *of_node;
>> =A0};
>> @@ -163,6 +166,18 @@ extern unsigned int irq_linear_revmap(struct irq_do=
main *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
irq_hw_number_t hwirq);
>>
>> =A0extern struct irq_domain_ops irq_domain_simple_ops;
>> +
>> +/* stock xlate functions */
>> +int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *=
ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, unsigned i=
nt intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t *out_hwirq, un=
signed int *out_type);
>> +int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *=
ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, unsigned i=
nt intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t *out_hwirq, un=
signed int *out_type);
>> +int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_nod=
e *ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, unsigned i=
nt intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t *out_hwirq, un=
signed int *out_type);
>> +
>> =A0#if defined(CONFIG_OF_IRQ)
>> =A0extern void irq_domain_generate_simple(const struct of_device_id *mat=
ch,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 u64 phys_base, unsigned int irq_start);
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index def8e7b..df80205 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -53,6 +53,7 @@ static struct irq_domain *irq_domain_alloc(struct devi=
ce_node *of_node,
>> =A0 =A0 =A0 domain->ops =3D ops;
>> =A0 =A0 =A0 domain->host_data =3D host_data;
>> =A0 =A0 =A0 domain->of_node =3D of_node_get(of_node);
>> + =A0 =A0 domain->xlate_type =3D IRQ_TYPE_NONE;
>>
>> =A0 =A0 =A0 if (domain->ops->match =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain->ops->match =3D default_irq_domain_ma=
tch;
>> @@ -690,25 +691,77 @@ int irq_domain_simple_map(struct irq_domain *d, un=
signed int irq,
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -int irq_domain_simple_xlate(struct irq_domain *d,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *co=
ntroller,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, un=
signed int intsize,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *out_hwi=
rq, unsigned int *out_type)
>> +/**
>> + * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindi=
ngs
>> + *
>> + * Device Tree IRQ specifier translation function which works with one =
cell
>> + * bindings where the cell value maps directly to the hwirq number.
>> + */
>> +int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *=
ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const u32 *intspec,=
 unsigned int intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *out_=
hwirq, unsigned int *out_type)
>> +{
>> + =A0 =A0 if (WARN(intsize < 1, "Bad intspec for %s: intsize=3D%i < 1\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrlr->full_name, intsize))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 *out_hwirq =3D intspec[0];
>> + =A0 =A0 *out_type =3D d->xlate_type;
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
>> +
>> +/**
>> + * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindi=
ngs
>> + *
>> + * Device Tree IRQ specifier translation function which works with two =
cell
>> + * bindings where the cell values map directly to the hwirq number
>> + * and linux irq flags.
>> + */
>> +int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *=
ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *intspec, unsigned i=
nt intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t *out_hwirq, un=
signed int *out_type)
>> =A0{
>> - =A0 =A0 if (d->of_node !=3D controller)
>> + =A0 =A0 if (WARN(intsize < 2, "Bad intspec for %s: intsize=3D%i < 2\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrlr->full_name, intsize))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 if (intsize < 2)
>
> You've already checked this...

cut-and-paste error.  Fixed.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 if (intsize < 1)
>> + =A0 =A0 *out_hwirq =3D intspec[0];
>> + =A0 =A0 *out_type =3D intspec[1] & IRQ_TYPE_SENSE_MASK;
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
>> +
>> +/**
>> + * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bi=
ndings
>> + *
>> + * Device Tree IRQ specifier translation function which works with eith=
er one
>> + * or two cell bindings where the cell values map directly to the hwirq=
 number
>> + * and linux irq flags.
>> + *
>> + * Note: don't use this function unless your interrupt controller expli=
citly
>> + * supports both one and two cell bindings. =A0For the majority of cont=
rollers
>> + * the _onecell() or _twocell() variants above should be used.
>
> This comment is confusing since you turn around and use it for simple
> ops below.

I intend to faze out the generic simple ops so that most drivers will
explicitly use _onecell or _twocell.

>> + */
>> +int irq_domain_xlate_onetwocell(struct irq_domain *d,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_=
node *ctrlr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *int=
spec, unsigned int intsize,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long =
*out_hwirq, unsigned int *out_type)
>> +{
>> + =A0 =A0 if (WARN(intsize < 1, "Bad intspec for %s: intsize=3D%i < 1\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrlr->full_name, intsize))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Isn't this check redundant with the check in of_irq_map_raw:
>
> =A0 =A0 =A0 =A0if (ointsize !=3D intsize)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;

No.  It's a different test.  The core code does indeed ensure that
intsize matches the #interrupt-cells value defined in the device tree,
but it does nothing to check if the #interrupt-cells value is set to
something sane.  This test ensures that the xlate function will not
dereference beyond the end of the intspec array.

Ideally the interrupt controller driver should already verify the
#interrupt-cells value at initialization, but I'm not going to rely on
it when this test is so cheap.  The intent is to be really noisy about
bad data in the device tree.

> The only diff in these functions is really checking the size. So I
> really don't think we need 3 versions if that can be factored out where
> you know value of #interrupt-cells.

There are subtleties here and #interrupt-cells is not always the
correct thing to test.  For example, some powerpc controllers has
#interrupt-cells =3D <2>, but the second cell must be ignored so the
_onecell version is the correct function.  I originally investigated
parameterizing a single function, but I didn't like how it ended up
looking because it would require adding something like irq_cells_min
and irq_cells_max to the irq_domain structure.  I think using
variations on the function ends up being cleaner.  I may also add
something like a ..._twocell_lookup() version that uses a lookup table
for the type values to handle the other type of xlate common in the
powerpc tree.

Thanks for the quick review.

g.
