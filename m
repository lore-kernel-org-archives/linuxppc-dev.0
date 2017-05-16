Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRw5d46cFzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 21:22:13 +1000 (AEST)
Message-ID: <1494933722.21847.47.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: Add __hard_irqs_disabled()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 May 2017 21:22:02 +1000
In-Reply-To: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
>  
> +static inline bool __hard_irqs_disabled(void)
> +{
> +       unsigned long flags = mfmsr();
> +       return (flags & MSR_EE) == 0;
> +}
> +

Reading the MSR has a cost. Can't we rely on paca->irq_happened being
non-0 ?

(If you are paranoid, add a test of msr as well and warn if there's
a mismatch ...)

Cheers,
Ben.
