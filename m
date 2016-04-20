Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqRYD15gnzDqKG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:04:00 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 13:03:58 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C75D53578065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:03:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K33U2Q55115800
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:03:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K3310D018711
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:03:06 +1000
Date: Wed, 20 Apr 2016 12:38:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 39/45] powerpc/powernv: Select OF_DYNAMIC
Message-ID: <20160420023804.GA3754@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-40-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715FD69.3060302@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715FD69.3060302@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 19, 2016 at 07:42:01PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>The device tree will change dynamically in PowerNV PCI hotplug
>>driver. This enables CONFIG_OF_DYNAMIC to support that.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
>>index 604190c..e7b1ad7 100644
>>--- a/arch/powerpc/platforms/powernv/Kconfig
>>+++ b/arch/powerpc/platforms/powernv/Kconfig
>>@@ -18,6 +18,7 @@ config PPC_POWERNV
>>  	select CPU_FREQ_GOV_ONDEMAND
>>  	select CPU_FREQ_GOV_CONSERVATIVE
>>  	select PPC_DOORBELL
>>+	select OF_DYNAMIC
>
>
>Why not to enable it in 45/45 under config HOTPLUG_PCI_POWERNV? Is there any
>benefit of having it always on if HOTPLUG_PCI_POWERNV is not enabled?
>

Agree, I will move accordingly in next revision. Note that we have to move
it back here once something else depends on OF_DYNAMIC in future.

>>  	default y
>>
>>  config OPAL_PRD
>>
>
>
>-- 
>Alexey
>
