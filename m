Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8C68EDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 14:52:29 +1000 (EST)
Date: Tue, 8 May 2007 23:54:39 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 3/4] powerpc: EEH: capture and log pci state on error
Message-ID: <20070509045439.GB1771@lixom.net>
References: <20070508230952.GN4452@austin.ibm.com>
	<20070508233532.GR4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508233532.GR4452@austin.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, May 08, 2007 at 06:35:32PM -0500, Linas Vepstas wrote:

> Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c
> ===================================================================
> --- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 15:37:32.000000000 -0500
> +++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 16:19:28.000000000 -0500
> @@ -100,6 +100,9 @@ static unsigned char slot_errbuf[RTAS_ER
>  static DEFINE_SPINLOCK(slot_errbuf_lock);
>  static int eeh_error_buf_size;
>  
> +#define EEH_PCI_REGS_LOG_LEN 4096
> +static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
> +

I'm guessing this has to be in BSS because of the requrements of being
addressable in realmode for RTAS? Could be nice to document in a comment
so noone tries to make it a local variable later on.

> +void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
> +{
> +	size_t loglen = 0;
> +	memset(pci_regs_buf, 0, EEH_PCI_REGS_LOG_LEN);

Should be no need to do a full memset, just set the first character to 0?

> +	rtas_pci_enable(pdn, EEH_THAW_MMIO);
> +	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
> +
> +	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);


-Olof
