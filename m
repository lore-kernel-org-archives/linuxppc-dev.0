Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2pX25MkzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:36:19 +1000 (AEST)
Received: by mail-vk0-x244.google.com with SMTP id y70-v6so2839824vkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 09:36:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180718024944.577-2-bhe@redhat.com>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-2-bhe@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 19:36:17 +0300
Message-ID: <CAHp75VdO88ydJQ9GHdaDUmAmzL6QHR=US6JiXZ1R_EEA-xWR1Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
To: Baoquan He <bhe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>, Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>, Borislav Petkov <bp@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 David Airlie <airlied@linux.ie>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 brijesh.singh@amd.com,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
 devel@linuxdriverproject.org, linux-input <linux-input@vger.kernel.org>,
 linux-nvdimm@lists.01.org, devicetree <devicetree@vger.kernel.org>,
 linux-pci@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>,
 Michal Simek <monstr@monstr.eu>, "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>, linux-parisc@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 5:49 AM, Baoquan He <bhe@redhat.com> wrote:
> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> so that it's shared.

Some minor stuff.

> +/**
> + * reparent_resources - reparent resource children of parent that res covers
> + * @parent: parent resource descriptor
> + * @res: resource descriptor desired by caller
> + *
> + * Returns 0 on success, -ENOTSUPP if child resource is not completely
> + * contained by 'res', -ECANCELED if no any conflicting entry found.

'res' -> @res

> + *
> + * Reparent resource children of 'parent' that conflict with 'res'

Ditto + 'parent' -> @parent

> + * under 'res', and make 'res' replace those children.

Ditto.

> + */
> +int reparent_resources(struct resource *parent, struct resource *res)
> +{
> +       struct resource *p, **pp;
> +       struct resource **firstpp = NULL;
> +
> +       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> +               if (p->end < res->start)
> +                       continue;
> +               if (res->end < p->start)
> +                       break;
> +               if (p->start < res->start || p->end > res->end)
> +                       return -ENOTSUPP;       /* not completely contained */
> +               if (firstpp == NULL)
> +                       firstpp = pp;
> +       }
> +       if (firstpp == NULL)
> +               return -ECANCELED; /* didn't find any conflicting entries? */
> +       res->parent = parent;
> +       res->child = *firstpp;
> +       res->sibling = *pp;
> +       *firstpp = res;
> +       *pp = NULL;
> +       for (p = res->child; p != NULL; p = p->sibling) {
> +               p->parent = res;

> +               pr_debug("PCI: Reparented %s %pR under %s\n",
> +                        p->name, p, res->name);

Now, PCI is a bit confusing here.

> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL(reparent_resources);
> +
>  static void __init __reserve_region_with_split(struct resource *root,
>                 resource_size_t start, resource_size_t end,
>                 const char *name)
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
