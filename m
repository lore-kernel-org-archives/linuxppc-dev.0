Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F4AF1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 04:59:47 +1100 (EST)
Received: by dadz14 with SMTP id z14so3120332dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 09:59:45 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CACxGe6s3R0fcBSf_YHTpXp15gtEBHRQg5-YM=cDO5UfY9cRGrQ@mail.gmail.com>
References: <1327450719-25590-1-git-send-email-grant.likely@secretlab.ca>
 <4F1F5FE0.9090901@gmail.com>
 <CACxGe6s3R0fcBSf_YHTpXp15gtEBHRQg5-YM=cDO5UfY9cRGrQ@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Jan 2012 10:59:25 -0700
Message-ID: <CACxGe6tgGqQSThzVVEzwOdtYkjKHT1uQhZBOkCTwkutyKXDCAg@mail.gmail.com>
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

On Tue, Jan 24, 2012 at 10:35 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, Jan 24, 2012 at 6:50 PM, Rob Herring <robherring2@gmail.com> wrot=
e:
>>
>>
>> On 01/24/2012 06:18 PM, Grant Likely wrote:
>>> Rather than having each interrupt controller driver creating its own ba=
rely
>>> unique .xlate function for irq_domain, create a library of translators =
which
>>> any driver can use directly.
>>>
>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>> index e7379a3..5e497a0 100644
>>> --- a/include/linux/irqdomain.h
>>> +++ b/include/linux/irqdomain.h
>>> @@ -110,6 +110,9 @@ struct irq_domain {
>>> =A0 =A0 =A0 void *host_data;
>>> =A0 =A0 =A0 irq_hw_number_t inval_irq;
>>>
>>> + =A0 =A0 /* Data for common irq xlate functions */
>>> + =A0 =A0 unsigned int xlate_type;
>>> +
>>
>> How does this get set? Do we want interrupt controllers messing with the
>> domain struct directly long term?
>
> It defaults to IRQ_TYPE_NONE in the alloc function and drivers can
> override it. =A0Alternately it could be made part of the
> irq_domain_add() arguments, but I'm not thrilled with adding a whole
> bunch of arguments to the function prototype.

Do you like this better (built on top of this patch)?

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ef2b1fe..7856c04 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -701,12 +701,10 @@ int irq_domain_xlate_onecell(struct irq_domain
*d, struct device_node *ctrlr,
 			     const u32 *intspec, unsigned int intsize,
 			     unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 1, "Bad intspec for %s: intsize=3D%i < 1\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 1))
 		return -EINVAL;
-	*out_hwirq =3D intspec[0];
-	*out_type =3D d->xlate_type;
-	return 0;
+	return irq_domain_xlate_onetwocell(d, ctrlr, intspec, 1,
+					   out_hwirq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);

@@ -721,12 +719,10 @@ int irq_domain_xlate_twocell(struct irq_domain
*d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 2, "Bad intspec for %s: intsize=3D%i < 2\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 2))
 		return -EINVAL;
-	*out_hwirq =3D intspec[0];
-	*out_type =3D intspec[1] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+	return irq_domain_xlate_onetwocell(d, ctrlr, intspec, intsize,
+					   out_hwirq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);

@@ -746,8 +742,7 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN(intsize < 1, "Bad intspec for %s: intsize=3D%i < 1\n",
-		 ctrlr->full_name, intsize))
+	if (WARN_ON(intsize < 1))
 		return -EINVAL;
 	*out_hwirq =3D intspec[0];
 	*out_type =3D d->xlate_type;
