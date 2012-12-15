Return-Path: <glikely@secretlab.ca>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 947C12C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2012 12:07:04 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so1593086dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2012 17:07:02 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20121212163749.GA17371@arm.com>
References: <20121212163749.GA17371@arm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 15 Dec 2012 01:06:41 +0000
Message-ID: <CACxGe6uZATX2uBjuDUsJ489-jmvFbLm-NQ6Q3SGqRVky9XGJYg@mail.gmail.com>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
To: Andrew Murray <Andrew.Murray@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>, linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu Dudau <liviu.dudau@arm.com>, Rob Herring <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2012 at 4:37 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
> DT bindings for PCI host bridges often use the ranges property to describe
> memory and IO ranges - this binding tends to be the same across architectures
> yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
> functionality provided by drivers/of/address.c.

Hi Andrew,

Thanks for looking into this. This definitely needs to be done.

However, I cannot merge this patch as-is because it actually makes
things worse by adding yet another implementation of the parsing code.
Plus it doesn't actually have any users.  :-)

Instead, move the existing code that you need out of
arch/powerpc/kernel/pci-common.c into a shared place and add in the
features you need. Bonus points if you fixup microblaze or others at
the same time.

g.
