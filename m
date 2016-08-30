Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNWs96LgYzDrh4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 11:58:53 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7U1wkgD110461
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 21:58:51 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 253714c8c2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 21:58:50 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 30 Aug 2016 11:58:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6534A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 11:58:46 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7U1wkKI48824464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 11:58:46 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7U1wjZi004480
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 11:58:46 +1000
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing
 vPHBs
To: linuxppc-dev@lists.ozlabs.org
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Cc: clombard@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com,
 helgaas@kernel.org, imunsie@au1.ibm.com, felix@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, stable@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 30 Aug 2016 11:58:44 +1000
MIME-Version: 1.0
In-Reply-To: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3049096a-97ea-9549-ee29-ae937708cf45@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi stable team,

The following patch, which ended up upstream as 
6f38a8b9a45833495dc878c335c5431cd98a16ed:

On 18/08/16 17:35, Andrew Donnellan wrote:
> When cxl removes a vPHB, it's possible that the pci_controller may be freed
> before all references to the devices on the vPHB have been released. This
> in turn causes an invalid memory access when the devices are eventually
> released, as pcibios_release_device() attempts to call the phb's
> release_device hook.
>
> In cxl_pci_vphb_remove(), remove the existing call to
> pcibios_free_controller(). Instead, use
> pcibios_free_controller_deferred() to free the pci_controller after all
> devices have been released. Export pci_set_host_bridge_release() so we can
> do this.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> This patch requires http://patchwork.ozlabs.org/patch/658324/. It should go
> through the powerpc tree.

This depends on 2dd9c11b9d4dfbd6c070eab7b81197f65e82f1a0 which didn't 
end up being tagged as cc: stable. It also ended up being applied in the 
wrong order in the powerpc/fixes tree...


Thanks,
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
