Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414jhw086yzF494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 18:29:03 +1000 (AEST)
Received: by mail-ua0-x242.google.com with SMTP id k14-v6so15360352uao.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 01:29:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612032831.29747-2-bhe@redhat.com>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Jun 2018 11:29:00 +0300
Message-ID: <CAHp75Vd6v4+RTq-5uw_BJpT6=w2KGjTfU+rEst6+8igs2cyntw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
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
 kexec@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>,
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

On Tue, Jun 12, 2018 at 6:28 AM, Baoquan He <bhe@redhat.com> wrote:
> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> so that it's shared. Later its code also need be updated using list_head
> to replace singly linked list.

While this is a good deduplication of the code, some requirements for
public functions would be good to satisfy.

> +/*
> + * Reparent resource children of pr that conflict with res
> + * under res, and make res replace those children.
> + */

kernel doc format, though...

> +static int reparent_resources(struct resource *parent,
> +                                    struct resource *res)

...is it really public with static keyword?!



> +{

> +       for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
> +               if (p->end < res->start)
> +                       continue;
> +               if (res->end < p->start)
> +                       break;

> +               if (p->start < res->start || p->end > res->end)
> +                       return -1;      /* not completely contained */

Usually we are expecting real eeror codes.

> +               if (firstpp == NULL)
> +                       firstpp = pp;
> +       }

> +       if (firstpp == NULL)
> +               return -1;      /* didn't find any conflicting entries? */

Ditto.

> +}
> +EXPORT_SYMBOL(reparent_resources);

-- 
With Best Regards,
Andy Shevchenko
