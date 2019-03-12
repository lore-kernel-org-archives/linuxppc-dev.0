Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B3C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF4A2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="I4qhPtiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF4A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jnzf1p5BzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="I4qhPtiL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JnmB1b4YzDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 08:14:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jnm66yR3z9tykP;
 Tue, 12 Mar 2019 22:14:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=I4qhPtiL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id lCEITzC1FPmS; Tue, 12 Mar 2019 22:14:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jnm65c6mz9tykN;
 Tue, 12 Mar 2019 22:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552425270; bh=myaZ5cjF+AZUedFgq74ulobNWZ/W+DgEDgTZxPOdRWY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=I4qhPtiLKc4oIT6/G4INmOFf3a5zMYYs1JIrSbXFKj0rSdqMXZIofpKf8VIZub8L6
 aIi08UiX09HEsztI8Vl5te0rGumiktPp7Xyr7+tRNC5z6TVjUsPSFVqjgmsxtSUlzm
 S5F3ZKDdalggioruCIHQCsb+uUKySuCmbW1DzIvw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E8BC88B8B1;
 Tue, 12 Mar 2019 22:14:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id by-G1yVrH3PR; Tue, 12 Mar 2019 22:14:30 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 819118B8A7;
 Tue, 12 Mar 2019 22:14:30 +0100 (CET)
Subject: Re: [PATCH] powerpc: Make some functions static
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190312203140.31785-1-malat@debian.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
Date: Tue, 12 Mar 2019 22:14:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312203140.31785-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/03/2019 à 21:31, Mathieu Malaterre a écrit :
> In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
> new functions were added. Since these functions can be made static,
> make it so. While doing so, it turns out that holly_power_off and
> holly_halt are unused, so remove them.

I would have said 'since these functions are only used in this C file, 
make them static'.

I think this could be split in two patches:
1/ Remove unused functions, ie holly_halt() and holly_power_off().
2/ Make the other ones static.

Christophe

> 
> Silence the following warnings triggered using W=1:
> 
>    arch/powerpc/platforms/embedded6xx/holly.c:47:5: error: no previous prototype for 'holly_exclude_device' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:190:6: error: no previous prototype for 'holly_show_cpuinfo' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:196:17: error: no previous prototype for 'holly_restart' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/platforms/embedded6xx/holly.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
> index 0409714e8070..829bf3697dc9 100644
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
> @@ -233,18 +234,6 @@ void __noreturn holly_restart(char *cmd)
>   	for (;;) ;
>   }
>   
> -void holly_power_off(void)
> -{
> -	local_irq_disable();
> -	/* No way to shut power off with software */
> -	for (;;) ;
> -}
> -
> -void holly_halt(void)
> -{
> -	holly_power_off();
> -}
> -
>   /*
>    * Called very early, device-tree isn't unflattened
>    */
> 
