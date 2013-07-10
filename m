Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D5652C02CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 05:15:59 +1000 (EST)
Date: Wed, 10 Jul 2013 14:15:40 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][PATCH 1/1] KVM: PPC: disable preemption when using
 hard_irq_disable()
To: Tiejun Chen <tiejun.chen@windriver.com>
References: <1373436139-27998-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1373436139-27998-1-git-send-email-tiejun.chen@windriver.com>
 (from tiejun.chen@windriver.com on Wed Jul 10 01:02:19 2013)
Message-ID: <1373483740.8183.223@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 01:02:19 AM, Tiejun Chen wrote:
> We should ensure the preemption cannot occur while calling get_paca()
> insdide hard_irq_disable(), otherwise the paca_struct may be the
> wrong one just after. And btw, we may update timing stats in this =20
> case.

The soft-ee mechanism depends on accessing the PACA directly via r13 to =20
avoid this.  We probably should be using inline asm to read was_enabled =20
rather than hoping the compiler doesn't do anything silly.

Plus what Alex said, regarding this patch specifically.

-Scott=
