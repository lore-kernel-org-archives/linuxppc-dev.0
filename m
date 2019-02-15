Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:57:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C826D21934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUdbCGXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C826D21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440vx304QWzDq8F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sUdbCGXP"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vj52402zDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:46:49 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id v72so19445977itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sykMABnLwzupsohU8f3pCEA7JuXHGn0g0KRuG7B9HHo=;
 b=sUdbCGXPWSr4AAzA/sdePP6j0oQA0Wam48Vjmf2VG4pueru0uzcWvQYCyI/ryByGRb
 ZBoFZ0U5PIEtuAGTQ0EXfWSkemn+1CYxnz9adhVD4Dc6BHR5/2n9igs0BtjQFhLy7tDX
 GNV5L2z48yGdj2lPxQusmn88jSRjNDrL9J+T4/2LUaUeUWfhareLprTREKPZCDtPzm1I
 VUMhKCh32C8g5wSO9IjDYURwI/BQ3FBbYmfjGUm2k4JuFgwadMQbxSVaE3mtJEG2aiOB
 X6/I8f0L5XWqreJ5dx9He/LsgcAoX+I0iPlGQELGgsdl2+S6U9f3WgPF4hMnzCjx0lqv
 PLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sykMABnLwzupsohU8f3pCEA7JuXHGn0g0KRuG7B9HHo=;
 b=F6Zrv5mGZaF39tTeRcLvr1eBI3cSUirZpN7LD65noihe1sBR/vwQw6HCht+R0nDmSw
 FHCZ1MrFumyPWXS8YxlxRyf2gehZicvt+kfU1MNaaKVdC+hDJRXlNxkPivJSa40UxPqN
 SGhGdYa+cZTeOJF44HAqrNGR8HYmhaGDIbaoQzBrvJHfnr9tY4JrthXZ7Totmll1Uref
 xeNY77J8ck62mEcDRmE8vw1TqNBmbwfwZB42fl0VJS/M7UJcZ1OMA0763AfQ+TiVFlWF
 aqk0CvjgUy/ga1mLOtAIKzkJQdKVHuLcy1wIyeQyqQKvfGG17qLY91jh9FOcKU0kgfSN
 +9yg==
X-Gm-Message-State: AHQUAuYhbyQRn5y/ceKz1P/N0HdSEPfTyTBrsMstgFlTI8nAh/k4Ldz5
 lzKTHsnHnfEJkdIxZO8ktdx+WJNgwyukEWsoKgo5Ow==
X-Google-Smtp-Source: AHgI3IZD7hx5WgCl5mhy1zgepA5ztokoYxoiwCk5tgOfiiY2Gyv+IXT/XzYneMfkXbQvYR0nAqf2EJwa/tFEkc121vU=
X-Received: by 2002:a24:7c58:: with SMTP id a85mr3893627itd.9.1550191605420;
 Thu, 14 Feb 2019 16:46:45 -0800 (PST)
MIME-Version: 1.0
References: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
In-Reply-To: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 15 Feb 2019 11:46:34 +1100
Message-ID: <CAOSf1CHnCiykoAZ_qAfNGTXmVUL=BMQkYkV33sQWXDgeeUvL0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/64: Adjust order in pcibios_init()
To: Sam Bobroff <sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 4:14 PM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> The pcibios_init() function for 64 bit PowerPC currently calls
> pci_bus_add_devices() before pcibios_resource_survey(), which seems
> incorrect because it adds devices and attempts to bind their drivers
> before allocating their resources (although no problems seem to be
> apparent).
>
> So move the call to pci_bus_add_devices() to after
> pcibios_resource_survey().
>
> This will also allow the ppc_md.pcibios_bus_add_device() hooks to
> perform actions that depend on PCI resources, both during rescanning
> (where this is already the case) and at boot time, which should
> support improvements and refactoring.
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> ---
> Hi everyone,
>
> I've tested this on a P9 for both the host and a KVM guest, and the change
> hasn't caused any differences in PCI resource assignments or the general boot
> messages.
>
> I've also had a go at inspecting most of the code used by pci_bus_add_devices()
> and pcibios_resource_survey() and it doesn't look like there are going to be
> any changes in behaviour caused by reordering.  It might be worth mentioning
> that the hotplug path (see pcibios_finish_adding_to_bus()) already does
> resource allocation before calling pci_bus_add_devices().
>
> However, it would be great if someone could test this change on some older
> hardware or comment on wether we should make the same change on 32 bit machines.
>
> Cheers,
> Sam.
>
>  arch/powerpc/kernel/pci_64.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 9d8c10d55407..1ce28888dbdb 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -58,14 +58,16 @@ static int __init pcibios_init(void)
>         pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
>
>         /* Scan all of the recorded PCI controllers.  */
> -       list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +       list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
>                 pcibios_scan_phb(hose);
> -               pci_bus_add_devices(hose->bus);
> -       }
>
>         /* Call common code to handle resource allocation */
>         pcibios_resource_survey();
>
> +       /* Add devices. */
> +       list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> +               pci_bus_add_devices(hose->bus);
> +
>         printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
>
>         return 0;
> --
> 2.19.0.2.gcad72f5712
>
