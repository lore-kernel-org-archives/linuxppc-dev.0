Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567921A0601
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2015 10:29:07 +1000 (AEST)
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B259C140295
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2015 10:29:00 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so47125981pdj.0
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2015 17:28:57 -0700 (PDT)
Message-ID: <1434241677.4003.4.camel@axtens.net>
Subject: Re: [PATCH] powerpc/powernv: Bump opal_init initcall priority
From: Daniel Axtens <dja@axtens.net>
To: Alistair Popple <alistair@popple.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org, Gavin
 Shan <gwshan@linux.vnet.ibm.com>
Date: Sun, 14 Jun 2015 10:27:57 +1000
In-Reply-To: <1434014729-12068-1-git-send-email-alistair@popple.id.au>
References: <1434014729-12068-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-06-11 at 19:25 +1000, Alistair Popple wrote:
> opal_init() is called via a machine_subsys_initcall(). Due to a hack
> in the eeh code the eeh driver is initialised with at the same
> initcall level. This means depending on link ordering the following
> error can occur because the opal irchip has not been initialised:
> 
> irq: XICS didn't like hwirq-0x9 to VIRQ17 mapping (rc=-22)
> pnv_eeh_post_init: Can't request OPAL event interrupt (0)
> 
> This patch solves the issue by making sure opal_init is called prior
> to the subsystems that may need it.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Daniel Axtens <dja@axtens.net>

This fixes the bug I was experiencing.
Tested-by: Daniel Axtens <dja@axtens.net>

-- 
Regards,
Daniel
