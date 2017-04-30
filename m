Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFyxj1L81zDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 16:55:53 +1000 (AEST)
Date: Sun, 30 Apr 2017 01:55:43 -0500
From: Scott Wood <oss@buserror.net>
To: Juergen Schindele <schindele@nentec.de>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <20170430065543.iamwy5yvk7tcpmc7@home.buserror.net>
References: <2666241.ms6yMRjznt@sherry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2666241.ms6yMRjznt@sherry>
Subject: Re: Freescale mpc8315 IRQ0 setup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 04:53:18PM +0200, Juergen Schindele wrote:
> Dear mailing list,
> i found out on our platform with freescale mpc8315 SOC that in
> linux kernel code the setup of IRQ0 which we use is not correct.
> One should be able to use falling EDGE interrupt capabilities like on
> IRQ1-IRQ7. These setups are fixed in "arch/powerpc/sysdev/ipic.c"
> The internal interrupt number of IRQ0 is not like IRQ1-IRQ7 in one block
> but on number 48. To verify details please consult MPC8315ERM.pdf
> developpers manual.
> 
> To correct these "EDGE" capabilities of IRQ0 i suggest the following 
> patch:
> please consider integrating it to your patches.
> 
> 
> Thank you for your attention
> 
> --- arch/powerpc/sysdev/ipic.c  (Revision correct)
> +++ arch/powerpc/sysdev/ipic.c  (Arbeitskopie)
> @@ -316,6 +316,7 @@
>                 .prio_mask = 7,
>         },
>         [48] = {
> +               .ack    = IPIC_SEPNR,
>                 .mask   = IPIC_SEMSR,
>                 .prio   = IPIC_SMPRR_A,
>                 .force  = IPIC_SEFCR,

Could you send this with a signoff and a commit message intended for
merging?

-Scott
