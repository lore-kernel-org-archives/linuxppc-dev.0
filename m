Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47000C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B964C2075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E5egL1ew";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jsj15c9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B964C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tq7w6DZGzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 00:47:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="E5egL1ew"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="jsj15c9n"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tnf04HYYzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:40:23 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0402760FED; Wed, 27 Mar 2019 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553690422;
 bh=gu22IK+ceBqf34ra5I+e64bhENf1yfc3lQmxCHMao8c=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=E5egL1ewRefEhKWlIZ0zdflnBQHQsD5pb3Pft2dLD+FfoFr+fzy0Ev/Q3+ibzlmmo
 VCdEsCNsy5IbjMvgSPjUmt/2rQ6hSWMzUD7pG6M0og9/9mqudCIjzW3w+QT3firLPI
 /z+X8D2ULMgMbxZo3FZ+iqKjxaNYdl5c3SZ7Yzgw=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 44CD460A42;
 Wed, 27 Mar 2019 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553690419;
 bh=gu22IK+ceBqf34ra5I+e64bhENf1yfc3lQmxCHMao8c=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jsj15c9nOE1FSkXziPQKwSGDu2V+K7LHYL2BVRGA4Tuy4kxGqnZpgamAbL2DGUYfq
 29M+s5I819Kx5AAmb2L0jsigS9Anu6J88FU8aapywkSTMDU7dOPAPnG57b1a2UUfeT
 Oy78DiHokmHo6rrytYVzkfxWm1QNe1a/eHG6e59c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44CD460A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 1/2] powerpc: Make some functions static
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190312203140.31785-1-malat@debian.org>
 <20190326204720.18882-1-malat@debian.org>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <144a0b47-184c-94ab-caa7-fbf15cfb3b4d@codeaurora.org>
Date: Wed, 27 Mar 2019 18:10:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326204720.18882-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Thu, 28 Mar 2019 00:44:34 +1100
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 3/27/2019 2:17 AM, Mathieu Malaterre wrote:
> In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
> new functions were added. Since most of these functions can be made static,
> make it so.
>
> Both holly_power_off and holly_halt functions were not changed since they
> are unused, making them static would have triggered the following warning
> (treated as error):
>
>    arch/powerpc/platforms/embedded6xx/holly.c:244:13: error: 'holly_halt' defined but not used [-Werror=unused-function]
>
> Silence the following warnings triggered using W=1:
>
>    arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

> ---
> v2: Split the patch in two operations
>
>   arch/powerpc/platforms/embedded6xx/holly.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
> index 0409714e8070..9d2eefef7b7b 100644
> --- a/arch/powerpc/platforms/embedded6xx/holly.c
> +++ b/arch/powerpc/platforms/embedded6xx/holly.c
> @@ -44,7 +44,8 @@
>   
>   #define HOLLY_PCI_CFG_PHYS 0x7c000000
>   
> -int holly_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
> +static int holly_exclude_device(struct pci_controller *hose, u_char bus,
> +				u_char devfn)
>   {
>   	if (bus == 0 && PCI_SLOT(devfn) == 0)
>   		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -187,13 +188,13 @@ static void __init holly_init_IRQ(void)
>   	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
>   }
>   
> -void holly_show_cpuinfo(struct seq_file *m)
> +static void holly_show_cpuinfo(struct seq_file *m)
>   {
>   	seq_printf(m, "vendor\t\t: IBM\n");
>   	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
>   }
>   
> -void __noreturn holly_restart(char *cmd)
> +static void __noreturn holly_restart(char *cmd)
>   {
>   	__be32 __iomem *ocn_bar1 = NULL;
>   	unsigned long bar;
