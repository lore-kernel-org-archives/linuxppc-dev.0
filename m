Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC951C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 15:51:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9252020CC7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 15:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9252020CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KBXF29K1zDqf1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 01:51:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KBTn5dQJzDr3D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 01:49:44 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49KBTY630YzB09b3;
 Sat,  9 May 2020 17:49:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 099NYsCV6Cpu; Sat,  9 May 2020 17:49:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49KBTY4L2qzB09b2;
 Sat,  9 May 2020 17:49:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B63538B775;
 Sat,  9 May 2020 17:49:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0AQC4Nh5-Sma; Sat,  9 May 2020 17:49:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C14678B75F;
 Sat,  9 May 2020 17:49:37 +0200 (CEST)
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To: Qian Cai <cai@lca.pw>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
 <229E1896-0C06-418A-B7DE-40AEBFB44F85@lca.pw>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a4ae5c50-f317-4224-a5f2-6e1030e62d2b@csgroup.eu>
Date: Sat, 9 May 2020 17:49:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <229E1896-0C06-418A-B7DE-40AEBFB44F85@lca.pw>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/05/2020 à 19:41, Qian Cai a écrit :
> 
> 
>> On May 8, 2020, at 10:39 AM, Qian Cai <cai@lca.pw> wrote:
>>
>> Booting POWER9 PowerNV has this message,
>>
>> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use early_ioremap() instead”
>>
>> but use the patch below will result in leaks because it will never call early_iounmap() anywhere. However, it looks me it was by design that phb->regs mapping would be there forever where it would be used in pnv_ioda_get_inval_reg(), so is just that check_early_ioremap_leak() initcall too strong?
>>
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -36,6 +36,7 @@
>> #include <asm/firmware.h>
>> #include <asm/pnv-pci.h>
>> #include <asm/mmzone.h>
>> +#include <asm/early_ioremap.h>
>>
>> #include <misc/cxl-base.h>
>>
>> @@ -3827,7 +3828,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>         /* Get registers */
>>         if (!of_address_to_resource(np, 0, &r)) {
>>                 phb->regs_phys = r.start;
>> -               phb->regs = ioremap(r.start, resource_size(&r));
>> +               phb->regs = early_ioremap(r.start, resource_size(&r));
>>                 if (phb->regs == NULL)
>>                         pr_err("  Failed to map registers !\n”);
> 
> This will also trigger a panic with debugfs reads, so isn’t that this commit bogus at least for powerpc64?
> 
> d538aadc2718 (“powerpc/ioremap: warn on early use of ioremap()")

No d538aadc2718 is not bogus. That's the point, we want to remove all 
early usages of ioremap() in order to remove the hack with the 
ioremap_bot stuff and all, and stick to the generic ioremap logic.

In order to do so, all early use of ioremap() has to be converted to 
early_ioremap() or to fixmap or anything else that allows to do ioremaps 
before the slab is ready.

early_ioremap() is for temporary mappings necessary at boottime. For 
long lasting mappings, another method is to be used.

Now, the point is that other architectures like for instance x86 don't 
seem to have to use early_ioremap() much. Powerpc is for instance doing 
early mappings for PCI. Seems like x86 initialises PCI once slab is 
ready. Can't powerpc do the same ?

Christophe
