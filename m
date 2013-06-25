Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BA6772C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 21:58:14 +1000 (EST)
Message-ID: <1372161366.3944.202.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 21:56:06 +1000
In-Reply-To: <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 18:00 +0800, Gavin Shan wrote:
> +               pci_regs_buf[0] = 0;
> +               eeh_pe_for_each_dev(pe, edev) {
> +                       loglen += eeh_gather_pci_data(edev, pci_regs_buf,
> +                                                     EEH_PCI_REGS_LOG_LEN);
> +               }
> +       }

Unless I'm mistaken, this is buggy and will overwrite the content of
pci_regs_buf for every device (they will all write over the same
portion of the log).

Ben.
