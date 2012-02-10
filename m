Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7ECEFB6FA0
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Feb 2012 05:42:03 +1100 (EST)
Message-ID: <4F3564EA.9060005@freescale.com>
Date: Fri, 10 Feb 2012 12:41:46 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v3 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
 <1328868141-17364-2-git-send-email-yu.liu@freescale.com>
 <1328868141-17364-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1328868141-17364-3-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, B07421@freescale.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/10/2012 04:02 AM, Liu Yu wrote:
> +_GLOBAL(epapr_ev_idle)
> +epapr_ev_idle:
> +#ifdef CONFIG_E500
> +	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
> +	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
> +	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
> +	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
> +#endif
> +	wrteei	1

On what hardware would you not need to use _TLF_NAPPING?

-Scott
