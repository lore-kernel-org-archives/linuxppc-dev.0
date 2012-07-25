Return-Path: <glikely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20F4B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 15:09:34 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so788407pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 22:09:32 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1343025161.2957.22.camel@pasglop>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop> <1343025161.2957.22.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Jul 2012 23:09:11 -0600
Message-ID: <CACxGe6vKUsUJnyef+DWfmQtpzGk8c6-Hta54VjCUWzss3Ej2gw@mail.gmail.com>
Subject: Re: More irqdomain problems (Was: next/mmotm unbootable on G5:
 irqdomain)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Paul Mundt <lethal@linux-sh.org>, Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2012 at 12:32 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Allright, another one Grant:
>
> unsigned int irq_find_mapping(struct irq_domain *domain,
>                               irq_hw_number_t hwirq)
> {
>         struct irq_data *data;
>
>         /* Look for default domain if nececssary */
>         if (domain == NULL)
>                 domain = irq_default_domain;
>         if (domain == NULL)
>                 return 0;
>
>         switch (domain->revmap_type) {
>         case IRQ_DOMAIN_MAP_LEGACY:
>                 return irq_domain_legacy_revmap(domain, hwirq);
>         case IRQ_DOMAIN_MAP_LINEAR:
>                 return irq_linear_revmap(domain, hwirq);
>         case IRQ_DOMAIN_MAP_TREE:
>                 rcu_read_lock();
>                 data = radix_tree_lookup(&domain->revmap_data.tree, hwirq);
>                 rcu_read_unlock();
>                 if (data)
>                         return data->irq;
> -               break;
> +               return 0;
>         case IRQ_DOMAIN_MAP_NOMAP:
>
> Please, stick a proper commit message and my s-o-b and see if you can fix
> your tree before you ask Linus to pull because that's not pretty on any
> pseries .... irq_find_mapping() does get called for all interrupt the
> first time it's mapped to check if there's a pre-existing mapping, so
> the case of the thing being unpopulated is absolutely legit.
>
> the NOMAP case has a similar dubious exit case but since I'm not that
> familiar with NOMAP I haven't touched it.

I've decided to rework the patch to simply omit the WARN statement. It
isn't really needed. I've merged in Linus' tree below the eliminate
slow-path patch and remove the WARN statement. It's been pushed out to
my irqdomain/next branch, so it should show up in tomorrow's
linux-next.

You can find it here if you want to give it a spin:

git://git.secretlab.ca/git/linux-2.6 irqdomain/next

I'll give it a bit more time in linux-next before I ask Linus to pull.

g.
