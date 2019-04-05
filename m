Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0604C282DC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:06:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A7F2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqhWLj8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A7F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bb6F4jC7zDqV4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 10:06:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZqhWLj8u"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bb4K3LrpzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 10:04:48 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A7192175B;
 Fri,  5 Apr 2019 23:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554505486;
 bh=B/VUhNvhr91k6lbYbAfhAz7J78aF270M2nTme/nZQfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZqhWLj8uOAwlcKN+ANFOCpxxDXW6uV3ip2PtIdEPhd+9jbUAmRHBDUWFQ7+8EFsF/
 z1bMZUy4i3R5ZSXWIs+DW2ABn8QiWdTU7bsUYyuYvgOrq9fhVsn9oGc8R2Z7oz2OMV
 xpC6FMF518Jzk3qExZHI+tsWVvUZz3+STC/u1lT4=
Date: Fri, 5 Apr 2019 18:04:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pci: rpadlpar: fix leaked device_node references in
 add/remove paths
Message-ID: <20190405230443.GA200379@google.com>
References: <20190322182722.8255-1-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322182722.8255-1-tyreld@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 22, 2019 at 01:27:21PM -0500, Tyrel Datwyler wrote:
> The find_dlpar_node() helper returns a device node with its reference
> incremented. Both the add and remove paths use this helper for find the
> appropriate node, but fail to release the reference when done.
> 
> Annotate the find_dlpar_node() helper with a comment about the incremented
> reference count, and call of_node_put() on the obtained device_node in the
> add and remove paths. Also, fixup a reference leak in the find_vio_slot()
> helper where we fail to call of_node_put() on the vdevice node after we
> iterate over its children.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Both applied to pci/hotplug for v5.2, thanks!

> ---
>  drivers/pci/hotplug/rpadlpar_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index e2356a9c7088..182f9e3443ee 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -51,6 +51,7 @@ static struct device_node *find_vio_slot_node(char *drc_name)
>  		if (rc == 0)
>  			break;
>  	}
> +	of_node_put(parent);
>  
>  	return dn;
>  }
> @@ -71,6 +72,7 @@ static struct device_node *find_php_slot_pci_node(char *drc_name,
>  	return np;
>  }
>  
> +/* Returns a device_node with its reference count incremented */
>  static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
>  {
>  	struct device_node *dn;
> @@ -306,6 +308,7 @@ int dlpar_add_slot(char *drc_name)
>  			rc = dlpar_add_phb(drc_name, dn);
>  			break;
>  	}
> +	of_node_put(dn);
>  
>  	printk(KERN_INFO "%s: slot %s added\n", DLPAR_MODULE_NAME, drc_name);
>  exit:
> @@ -439,6 +442,7 @@ int dlpar_remove_slot(char *drc_name)
>  			rc = dlpar_remove_pci_slot(drc_name, dn);
>  			break;
>  	}
> +	of_node_put(dn);
>  	vm_unmap_aliases();
>  
>  	printk(KERN_INFO "%s: slot %s removed\n", DLPAR_MODULE_NAME, drc_name);
> -- 
> 2.12.3
> 
