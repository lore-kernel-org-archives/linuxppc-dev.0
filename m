Return-Path: <danielwa@cisco.com>
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFB231A0D0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 05:58:20 +1100 (AEDT)
To: Jia Hongtao <B38951@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "David Beazley (dbeazley)" <dbeazley@cisco.com>,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
From: Daniel Walker <danielwa@cisco.com>
Subject: Re: powerpc/fsl-pci: Unify pci/pcie initialization code
Message-ID: <563BA46C.8000202@cisco.com>
Date: Thu, 5 Nov 2015 10:48:12 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

905e75c46dba5f3061049277e4eb7110beedba43:arch/powerpc/platforms/85xx/mpc85xx_ads.c

This commit seems to cause problems with PCI devices doing DMA, just 
with mpc85xx ads. If you do the "fsl_add_bridge()" after you setup the 
ppc_md.pci_exclude_device to mpc85xx_exclude_device, then the 
early_read_config_word() calls in 
arch/powerpc/sysdev/fsl_pci.c:setup_pci_cmd() are like no-ops.

This issue was found by David Beazley (on the CC), he can respond to 
more detailed questions on it. The fix he came up with was to remove the 
"pci_exclude_device".

Daniel
