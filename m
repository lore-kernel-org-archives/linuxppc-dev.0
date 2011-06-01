Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5CFAB6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 00:55:38 +1000 (EST)
Received: by vxi40 with SMTP id 40so4649518vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 07:55:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110601132519.GA16125@oksana.dev.rtsoft.ru>
References: <1306931292-2313-1-git-send-email-dbaryshkov@gmail.com>
	<20110601132519.GA16125@oksana.dev.rtsoft.ru>
Date: Wed, 1 Jun 2011 18:55:35 +0400
Message-ID: <BANLkTi=xFcZRd4x1FQSKJzmt3A7_tZs+sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Anton Vorontsov <avorontsov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/1/11, Anton Vorontsov <avorontsov@mvista.com> wrote:
> On Wed, Jun 01, 2011 at 04:28:11PM +0400, Dmitry Eremin-Solenikov wrote:
> [...]
>> --- a/arch/powerpc/sysdev/fsl_pci.h
>> +++ b/arch/powerpc/sysdev/fsl_pci.h
>> @@ -92,6 +92,7 @@ extern int fsl_add_bridge(struct device_node *dev, int
>> is_primary);
>>  extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
>>  extern int mpc83xx_add_bridge(struct device_node *dev);
>>  u64 fsl_pci_immrbar_base(struct pci_controller *hose);
>> +int fsl_add_pci_err(void);
>
> With
>
> #ifdef CONFIG_PCI
> int fsl_add_pci_err(void);
> #else
> static inline int fsl_add_pci_err(void) { return -ENODEV; }
> #endif
>
> You won't need endless ifdefs in the board files:

OK, will redo this patch.

>
> #ifdef CONFIG_PCI
> 	fsl_add_pci_err();
> #endif
>
> Also, why not add this call to the fsl_add_bridge(), so you
> won't need to touch board files at all.

Because fsl_add_bridge is called too early, so allocation
of platform device fails.

-- 
With best wishes
Dmitry
