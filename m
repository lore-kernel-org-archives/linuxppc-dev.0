Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26DE01A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 13:28:22 +1100 (AEDT)
Message-ID: <1422844101.11325.4.camel@ellerman.id.au>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 02 Feb 2015 13:28:21 +1100
In-Reply-To: <1422712065-9403-2-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> So we can avoid the ugly #ifdef in some drivers.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)


Hi Bjorn,

Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
you prefer.

cheers

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8323cbf93913..421eb6a9e600 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1863,6 +1863,8 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> +static inline struct device_node *
> +pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
>  #endif  /* CONFIG_OF */
>  
>  #ifdef CONFIG_EEH
