Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BCC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:48:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6813821A7F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6813821A7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MVJp58MSzDqdS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 02:48:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MVGh4v06zDqXV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 02:46:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43MVGX45SFz9v0Cm;
 Sat, 22 Dec 2018 16:46:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xd344kZD--88; Sat, 22 Dec 2018 16:46:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43MVGX2bNnz9v0Cl;
 Sat, 22 Dec 2018 16:46:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A45588B785;
 Sat, 22 Dec 2018 16:46:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0FDwrz0oJeEe; Sat, 22 Dec 2018 16:46:31 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FEC08B74B;
 Sat, 22 Dec 2018 16:46:31 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/4xx/ocm: fix compilation error
To: Christian Lamparter <chunkeey@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20181222143538.21630-1-chunkeey@gmail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <9f57efc9-a18a-d49e-ab59-045336a6b768@c-s.fr>
Date: Sat, 22 Dec 2018 16:46:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181222143538.21630-1-chunkeey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 181222-2, 22/12/2018), Outbound message
X-Antivirus-Status: Clean
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
 Markus Elfring <elfring@users.sourceforge.net>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 22/12/2018 à 15:35, Christian Lamparter a écrit :
> This patch fixes a recent compilation regression in ocm:
> 
> | ocm.c: In function ‘ocm_init_node’:
> | ocm.c:182:18: error: invalid operands to binary |
> |       (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
> |       _PAGE_EXEC | PAGE_KERNEL_NCG);
> |                  ^
> |
> | ocm.c:197:17: error: invalid operands to binary |
> |       (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
> |        _PAGE_EXEC | PAGE_KERNEL);
> |                   ^
> 
> Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org

> ---
>   arch/powerpc/platforms/4xx/ocm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
> index 561b09de69bf..de3565353153 100644
> --- a/arch/powerpc/platforms/4xx/ocm.c
> +++ b/arch/powerpc/platforms/4xx/ocm.c
> @@ -179,7 +179,7 @@ static void __init ocm_init_node(int count, struct device_node *node)
>   	/* ioremap the non-cached region */
>   	if (ocm->nc.memtotal) {
>   		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
> -					 _PAGE_EXEC | PAGE_KERNEL_NCG);
> +			_PAGE_EXEC | pgprot_val(PAGE_KERNEL_NCG));
>   
>   		if (!ocm->nc.virt) {
>   			printk(KERN_ERR
> @@ -194,7 +194,7 @@ static void __init ocm_init_node(int count, struct device_node *node)
>   
>   	if (ocm->c.memtotal) {
>   		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
> -					_PAGE_EXEC | PAGE_KERNEL);
> +					_PAGE_EXEC | pgprot_val(PAGE_KERNEL));
>   
>   		if (!ocm->c.virt) {
>   			printk(KERN_ERR
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

