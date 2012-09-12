Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 089042C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 06:31:35 +1000 (EST)
Received: by qcse14 with SMTP id e14so1380922qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:31:32 -0700 (PDT)
Date: Wed, 12 Sep 2012 16:31:29 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050EF3F.6030003@gmail.com>
Message-ID: <alpine.LFD.2.02.1209121629260.28681@xanadu.home>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <5050EF3F.6030003@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, x86@kernel.org, david.daney@cavium.com,
 bigeasy@linutronix.de, paul.gortmaker@windriver.com, paulus@samba.org,
 hpa@zytor.com, m.szyprowski@samsung.com, jonas@southpole.se,
 linus.walleij@linaro.org, linux@arm.linux.org.uk, linux-c6x-dev@linux-c6x.org,
 a-jacquiot@ti.com, mahesh@linux.vnet.ibm.com, mingo@redhat.com,
 suzuki@in.ibm.com, Cyril Chemparathy <cyril@ti.com>, linux@openrisc.net,
 arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
 devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
 rob.herring@calxeda.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, blogic@openwrt.org, dhowells@redhat.com,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 tj@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Sep 2012, Rob Herring wrote:

> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> 
> S-o-B?
> 
> > ---
> >  arch/arm/mm/init.c            |    2 +-
> >  arch/c6x/kernel/devicetree.c  |    3 +--
> >  arch/microblaze/kernel/prom.c |    3 +--
> >  arch/mips/kernel/prom.c       |    3 +--
> >  arch/openrisc/kernel/prom.c   |    3 +--
> >  arch/powerpc/kernel/prom.c    |    3 +--
> >  arch/x86/kernel/devicetree.c  |    3 +--
> >  drivers/of/fdt.c              |   10 ++++++----
> >  include/linux/of_fdt.h        |    3 +--
> >  9 files changed, 14 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index ad722f1..579792c 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
> >  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
> >  
> >  #ifdef CONFIG_OF_FLATTREE
> > -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> > +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
> 
> phys_initrd_start/size need to change too. Not sure about similar things
> on other arches.

size ?


Nicolas
