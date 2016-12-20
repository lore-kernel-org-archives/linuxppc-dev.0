Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjX026Q2vzDwTb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 20:04:02 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so8705563pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:04:02 -0800 (PST)
Subject: Re: [PATCH v4 02/12] powerpc: move set_soft_enabled() and rename
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-3-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
Date: Tue, 20 Dec 2016 20:03:39 +1100
MIME-Version: 1.0
In-Reply-To: <1482134828-18811-3-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/12/16 19:06, Madhavan Srinivasan wrote:
> Move set_soft_enabled() from powerpc/kernel/irq.c to
> asm/hw_irq.c, to force updates to paca-soft_enabled
> done via these access function. Add "memory" clobber
> to hint compiler since paca->soft_enabled memory is the target
> here
> +static inline notrace void soft_enabled_set(unsigned long enable)
> +{
> +	__asm__ __volatile__("stb %0,%1(13)"
> +	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled))
> +	: "memory");
> +}
> +

Can't we just rewrite this in "C"?

local_paca->soft_enabled = enable

Balbir Singh.
