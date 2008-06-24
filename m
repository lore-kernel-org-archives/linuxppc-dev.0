Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0FD76DDF12
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:41:42 +1000 (EST)
Message-ID: <48616A0D.4000306@ru.mvista.com>
Date: Wed, 25 Jun 2008 01:41:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 8/8][Version 2] MPC5121 Hide pci bridge
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>	<1214342672-23536-2-git-send-email-jrigby@freescale.com>	<1214342672-23536-3-git-send-email-jrigby@freescale.com>	<1214342672-23536-4-git-send-email-jrigby@freescale.com>	<1214342672-23536-5-git-send-email-jrigby@freescale.com>	<1214342672-23536-6-git-send-email-jrigby@freescale.com>	<1214342672-23536-7-git-send-email-jrigby@freescale.com>	<1214342672-23536-8-git-send-email-jrigby@freescale.com>
	<1214342672-23536-9-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214342672-23536-9-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

John Rigby wrote:
> The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
> while other freescale host bridges have class set to
> PCI_CLASS_PROCESSOR_POWERPC.
>
> This patch makes fixup_hide_host_resource_fsl match
> PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
>
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 88db4ff..3d33935 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -54,11 +54,12 @@ LIST_HEAD(hose_list);
>  static int pci_bus_count;
>  
>  static void
> -fixup_hide_host_resource_fsl(struct pci_dev* dev)
> +fixup_hide_host_resource_fsl(struct pci_dev *dev)
>  {
>  	int i, class = dev->class >> 8;
>  
> -	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
> +	if ((class == PCI_CLASS_PROCESSOR_POWERPC
> +		    || class == PCI_CLASS_BRIDGE_OTHER) &&
>   

   Coding style nit: could you put || on the same line with first 
comparison (where && used to be BTW) and align the second comparison to 
start under 'class'?

WBR, Sergei
