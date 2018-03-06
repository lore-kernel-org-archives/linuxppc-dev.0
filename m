Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwjb34HsfzF1WD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 03:55:59 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w26GnMJi084603
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 11:55:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghx672a33-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 11:55:53 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 6 Mar 2018 16:55:52 -0000
Subject: Re: [PATCH v10 1/2] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 6 Mar 2018 17:55:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0cb5e445-79a9-5845-edde-ab72a2125c28@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 02/03/2018 à 10:56, Philippe Bergheaud a écrit :
> P9 supports PCI tunneled operations (atomics and as_notify). This
> patch adds support for tunneled operations on powernv, with a new
> API, to be called by device drivers:
> 
> pnv_pci_enable_tunnel()
>     Enable tunnel operations, tell driver the 16-bit ASN indication
>     used by kernel.
> 
> pnv_pci_disable_tunnel()
>     Disable tunnel operations.
> 
> pnv_pci_set_tunnel_bar()
>     Tell kernel the Tunnel BAR Response address used by driver.
>     This function uses two new OPAL calls, as the PBCQ Tunnel BAR
>     register is configured by skiboot.
> 
> pnv_pci_get_as_notify_info()
>     Return the ASN info of the thread to be woken up.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: Do not set the ASN indication. Get it from the device tree.
> 
> v3: Make pnv_pci_get_phb_node() available when compiling without cxl.
> 
> v4: Add pnv_pci_get_as_notify_info().
>      Rebase opal call numbers on skiboot 5.9.6.
> 
> v5: pnv_pci_get_tunnel_ind():
>        - fix node reference count
>      pnv_pci_get_as_notify_info():
>        - fail if task == NULL
>        - read pid from mm->context.id
>        - explain that thread.tidr require CONFIG_PPC64
> 
> v6: pnv_pci_get_tunnel_ind():
>        - check if radix is enabled, or else return an error
>      pnv_pci_get_as_notify_info():
>        - remove a capi-specific comment, irrelevant for pci
> 
> v7: pnv_pci_set_tunnel_bar():
>        - setting the tunnel bar more than once with the same value
>          is not an error
> 
> v8: No change
> 
> v9: Rename pnv_pci_get_tunnel_ind() into pnv_pci_enable_tunnel():
>        - Increase real window size to accept as_notify messages.
>      New api pnv_pci_disable_tunnel():
>        - Restore real window size to its default value.
>      Adjust opal call numbers.
> 
> v10: Adjust opal call numbers to their final values.
> ---

Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
