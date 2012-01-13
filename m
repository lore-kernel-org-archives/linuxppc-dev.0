Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6757B6FDB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 11:54:20 +1100 (EST)
Received: by dadv40 with SMTP id v40so1614423dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 16:54:18 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F0F7CC5.5080900@gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-13-git-send-email-grant.likely@secretlab.ca>
 <4F0F7CC5.5080900@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Jan 2012 17:53:57 -0700
Message-ID: <CACxGe6tQ2U-u6-=3qGFTxXFViPAS2Y1g4i8MUNhPJdE_WzkA3A@mail.gmail.com>
Subject: Re: [RFC 12/14] irq_domain: Add support for base irq and hwirq in
 legacy mappings
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2012 at 5:37 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 01/11/2012 02:22 PM, Grant Likely wrote:
>> Add support for a legacy mapping where irq =3D (hwirq - first_hwirq + fi=
rst_irq)
>> so that a controller driver can allocate a fixed range of irq_descs and =
use
>> a simple calculation to translate back and forth between linux and hw ir=
q
>> numbers. =A0This is needed to use an irq_domain with many of the ARM int=
errupt
>> controller drivers that manage their own irq_desc allocations. =A0Ultima=
tely
>> the goal is to migrate those drivers to use the linear revmap, but doing=
 it
>> this way allows each driver to be converted separately which makes the
>> migration path easier.
>>
>> This patch generalizes the IRQ_DOMAIN_MAP_LEGACY method to use
>> (first_irq-first_hwirq) as the offset between hwirq and linux irq number=
,
>> and adds checks to make sure that the hwirq number does not exceed range
>> assigned to the controller.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>> =A0arch/powerpc/include/asm/irq.h =A0 | =A0 =A03 -
>> =A0arch/powerpc/sysdev/i8259.c =A0 =A0 =A0| =A0 =A02 +-
>> =A0arch/powerpc/sysdev/tsi108_pci.c | =A0 =A02 +-
>> =A0include/linux/irqdomain.h =A0 =A0 =A0 =A0| =A0 20 +++++++++-
>> =A0kernel/irq/irqdomain.c =A0 =A0 =A0 =A0 =A0 | =A0 78 +++++++++++++++++=
++++++++-------------
>> =A05 files changed, 73 insertions(+), 32 deletions(-)
>>
>
> snip...
>
>> @@ -454,8 +477,11 @@ unsigned int irq_find_mapping(struct irq_domain *do=
main,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 /* legacy -> bail early */
>> - =A0 =A0 if (domain->revmap_type =3D=3D IRQ_DOMAIN_MAP_LEGACY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return hwirq;
>> + =A0 =A0 if (domain->revmap_type =3D=3D IRQ_DOMAIN_MAP_LEGACY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hwirq > domain->revmap_data.legacy.size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return domain->revmap_data.legacy.first_irq + =
hwirq;
>
> This needs a "- domain->revmap_data.legacy.first_hwirq"

Good catch, thanks.
g.
