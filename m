Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 185A22C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 01:20:29 +1000 (EST)
Message-ID: <1366730340.12131.3.camel@pasglop>
Subject: Re: [PATCH 1/5] powerpc/powernv: Supports PHB3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 01:19:00 +1000
In-Reply-To: <1366715034-24594-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-2-git-send-email-shangw@linux.vnet.ibm.com>
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

On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
> -/* Fixup wrong class code in p7ioc root complex */
> +/* Fixup wrong class code in p7ioc and p8 root complex */
>  static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>  {
>         dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x2da, pnv_p7ioc_rc_quirk);
>  
This can go away from the normal patch, it is only necessary to work
around a problem in the simulator. The real PHB3 doesn't need the
workaround (p7ioc still does).

Cheers,
Ben.
