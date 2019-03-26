Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EADC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:04:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8800920823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8HV9xZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8800920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TCYk5CVzzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 01:04:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="X8HV9xZ8"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TCWZ41dbzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:02:49 +1100 (AEDT)
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3261620823;
 Tue, 26 Mar 2019 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553608967;
 bh=u6J3N8G4McKoYticzOIMr82nI7RafK01af2n4VtOxLA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X8HV9xZ8iT6C0KjWZwcctJG7WDzIAHFBxr5t+3J2fIsjKlYZcCWLMbeJJlZukyaYR
 ywhfTwjRw3fFETvZxTBpI1V8B61HvfAaT2In6i6B5b4Sooe1JgCyu7LJAIkdkJyuuq
 htrg5wDp70KbEkWhaFCjnavVdUOcUafWTPSoXbMk=
Date: Tue, 26 Mar 2019 09:02:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 01/21] PCI: Fix writing invalid BARs during
 pci_restore_state()
Message-ID: <20190326140246.GH24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-2-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-2-s.miroshnichenko@yadro.com>
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sergey,

Thanks for all your work here.  This is a long-standing problem, and
I'm glad you're working on it.

On Mon, Mar 11, 2019 at 04:31:02PM +0300, Sergey Miroshnichenko wrote:
> If BAR movement has happened (due to PCIe hotplug) after pci_save_state(),
> the saved addresses will become outdated. Restore them the most recently
> calculated values, not the ones stored in an arbitrary moment.

Maybe pci_save_state() should not even save BAR values, since we have
no mechanism to determine whether those saved values are valid?

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c1b362f599a..f006068be209 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1376,7 +1376,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>  	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
>  		pci_restore_config_space_range(pdev, 10, 15, 0, false);
>  		/* Restore BARs before the command register. */
> -		pci_restore_config_space_range(pdev, 4, 9, 10, false);
> +		pci_restore_bars(pdev);

pci_restore_bars() is a much longer call path than
pci_restore_config_space_range(), so it's a little bit scary just from
the complexity point of view, but I think this does make sense.

But I am concerned that we don't handle bridge BARs the same way (this
is an existing problem, not something you're introducing).

Bridge BARs (if implemented) are dwords 4 and 5, so they are currently
restored as part of this range:

  pci_restore_config_space_range(pdev, 0, 8, 0, false);

If we followed the same pattern as for type 0 devices, this would look
like:

  pci_restore_config_space_range(pdev, 6, 8, 0, false);
  pci_restore_config_space_range(pdev, 4, 5, 10, false);  /* BARs */
  pci_restore_config_space_range(pdev, 0, 3, 0, false);

And after your patch, it would look like:

  pci_restore_config_space_range(pdev, 6, 8, 0, false);
  pci_restore_bars(pdev);
  pci_restore_config_space_range(pdev, 0, 3, 0, false);

I think this would require a little enhancement in pci_restore_bars()
to filter the BAR range based on the hdr_type.

I would propose

  - adding a new patch to split up the bridge restore so the (0, 8)
    range is split into (6, 8); (4, 5); (0, 3), so it matches the type
    0 restore.

  - adding another new patch to filter the BAR range in
    pci_restore_bars().

  - updating this patch to use pci_restore_bars() in both the type 0
    and type 1 paths.

  - possibly adding a patch to make pci_save_state() not save BAR
    values in dev->saved_config_space, and any other changes needed to
    stop reading BARs from that area.

What do you think?

>  		pci_restore_config_space_range(pdev, 0, 3, 0, false);
>  	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>  		pci_restore_config_space_range(pdev, 12, 15, 0, false);
> -- 
> 2.20.1
> 
