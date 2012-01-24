Return-Path: <robherring2@gmail.com>
Message-ID: <4F1F2CA5.1070701@gmail.com>
Date: Tue, 24 Jan 2012 16:11:49 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFCv2 03/14] irq_domain: Make irq_domain structure match
 powerpc's irq_host
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <1327352870-14687-4-git-send-email-grant.likely@secretlab.ca>
 <4F1F24DD.5030904@gmail.com>
 <CACxGe6sO-3LHbimBGaWFY98QtK5tiK8uiDodmgO1kVQoi4jDTQ@mail.gmail.com>
In-Reply-To: <CACxGe6sO-3LHbimBGaWFY98QtK5tiK8uiDodmgO1kVQoi4jDTQ@mail.gmail.com>
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

On 01/24/2012 04:08 PM, Grant Likely wrote:
> On Tue, Jan 24, 2012 at 2:38 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On 01/23/2012 03:07 PM, Grant Likely wrote:
>>> Part of the series to unify the irq remapping mechanisms in the
>>> kernel.  A follow up patch will copy the powerpc implementation into
>>> kernel/irq/irqdomain.c, which will be a lot easier if the structures
>>> are identical.
>>>
>>> Where they differ, I've chose to use the powerpc names since there is
>>> a lot more code using those names.
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>>  arch/arm/common/gic.c     |   14 ++++----
>>>  include/linux/irqdomain.h |   84 ++++++++++++++++++++++++++++++++++-----------
>>>  kernel/irq/irqdomain.c    |   14 ++++----
>>>  3 files changed, 78 insertions(+), 34 deletions(-)
>>>
>>
>> snip...
>>
>>> @@ -126,7 +126,7 @@ void irq_dispose_mapping(unsigned int irq)
>>>  }
>>>  EXPORT_SYMBOL_GPL(irq_dispose_mapping);
>>>
>>> -int irq_domain_simple_dt_translate(struct irq_domain *d,
>>> +int irq_domain_simple_xlate(struct irq_domain *d,
>>>                           struct device_node *controller,
>>>                           const u32 *intspec, unsigned int intsize,
>>>                           unsigned long *out_hwirq, unsigned int *out_type)
>>
>> This needs a declaration in irqdomain.h (as well as EXPORT?). There
>> could be others as well, but this is the one I'm using for generic irq chip.
> 
> Fine by me.  I'll add that as a follow-on patch since nothing in-tree
> currently depends on that.  It will be in the next version of the
> patch series.  Also, are you okay if I rename it to
> irq_domain_generic_xlate()?  Simple doesn't really describe it well,
> and it can be used for any interrupt controller implementing the
> binding we've settled on as recommended for new device support.
> 

Okay.

Rob
