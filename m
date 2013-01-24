Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 391942C0080
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 05:22:33 +1100 (EST)
Date: Thu, 24 Jan 2013 12:22:20 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] KVM: PPC: add paravirt idle loop for 64-bit book E
To: Stuart Yoder <stuart.yoder@freescale.com>
References: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
In-Reply-To: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
 (from stuart.yoder@freescale.com on Tue Jan 22 17:54:43 2013)
Message-ID: <1359051740.24865.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Stuart Yoder <stuart.yoder@freescale.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2013 05:54:43 PM, Stuart Yoder wrote:
> +.macro BOOK3E_IDLE_LOOP
> +1:
> +	PPC_WAIT(0)
>  	b	1b
> +.endm
> +
> +.macro EPAPR_EV_IDLE_LOOP
> +idle_loop:
> +       LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
> +
> +.global epapr_ev_idle_start
> +epapr_ev_idle_start:
> +       li      r3, -1
> +       nop
> +       nop
> +       nop
> +       b       idle_loop
> +.endm
> +
> +BOOK3E_IDLE epapr_ev_idle, EPAPR_EV_IDLE_LOOP
> +
> +BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP

Why the comma after epapr_ev_idle but not after book3e_idle?

Also you have spaces where there should be tabs.

Otherwise looks good.

-Scott=
