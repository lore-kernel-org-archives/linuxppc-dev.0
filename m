Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C35C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1656F2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYJcHiou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1656F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DhZ36F6KzDqbx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 01:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IYJcHiou";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IYJcHiou"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DhSp5KwLzDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 01:01:46 +1100 (AEDT)
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AC0A2082F;
 Tue, 11 Dec 2018 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544536904;
 bh=BrPCIYw4y3W3jjjxvy14qmwei0MW0x6KeI0SPMGcEfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IYJcHiouudMefyK2+ftBv4ygnhtWrjBASJZ2+b39da1AoxIV9eMyIbVglsmQ21zVl
 P9ABEhOghbslkvWKe0VIFQJQ1eyje/h9sgocdfEjWBhvcy2/L4N+WCTNVLEkHx0iQc
 t0JLdTPENVgofOobfER9jqD79nEpCk+H2FDby0yg=
Date: Tue, 11 Dec 2018 08:01:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20181211140143.GD99796@google.com>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206041951.22413-1-david@gibson.dropbear.id.au>
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
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbest@redhat.com, saeedm@mellanox.com,
 alex.williamson@redhat.com, paulus@samba.org, linux-pci@vger.kernel.org,
 ogerlitz@mellanox.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi David,

I see you're still working on this, but if you do end up going this
direction eventually, would you mind splitting this into two patches:
1) rename the quirk to make it more generic (but not changing any
behavior), and 2) add the ConnectX devices to the quirk.  That way
the ConnectX change is smaller and more easily understood/reverted/etc.

On Thu, Dec 06, 2018 at 03:19:51PM +1100, David Gibson wrote:
> Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
> unbound from their regular driver and attached to vfio-pci in order to pass
> them through to a guest.
> 
> This goes away if the disable_idle_d3 option is used, so it looks like a
> problem with the hardware handling D3 state.  To fix that more permanently,
> use a device quirk to disable D3 state for these devices.
> 
> We do this by renaming the existing quirk_no_ata_d3() more generally and
> attaching it to the ConnectX-[45] devices (0x15b3:0x1013).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/pci/quirks.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..add3f516ca12 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1315,23 +1315,24 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>  
> -/* Some ATA devices break if put into D3 */
> -static void quirk_no_ata_d3(struct pci_dev *pdev)
> +/* Some devices (including a number of ATA cards) break if put into D3 */
> +static void quirk_no_d3(struct pci_dev *pdev)
>  {
>  	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>  }
> +
>  /* Quirk the legacy ATA devices only. The AHCI ones are ok */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  /* ALi loses some register settings that we cannot then restore */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
>     occur when mode detecting */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  
>  /*
>   * This was originally an Alpha-specific thing, but it really fits here.
> @@ -3367,6 +3368,10 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>  			mellanox_check_broken_intx_masking);
>  
> +/* Mellanox MT27800 (ConnectX-5) IB card seems to break with D3
> + * In particular this shows up when the device is bound to the vfio-pci driver */

Follow usual multiline comment style, i.e.,

  /*
   * text ...
   * more text ...
   */

> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTX4, quirk_no_d3)
> +
>  static void quirk_no_bus_reset(struct pci_dev *dev)
>  {
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> -- 
> 2.19.2
> 
