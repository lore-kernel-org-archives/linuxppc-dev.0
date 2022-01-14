Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA9AC433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jan 2022 17:50:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jb83F5vjXz3bZb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jan 2022 04:50:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jb82j6ZgRz2yLy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jan 2022 04:50:05 +1100 (AEDT)
Received: from [2601:449:8480:af0::946b]
 by baldur.buserror.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <oss@buserror.net>)
 id 1n8QhZ-0007hp-Gc; Fri, 14 Jan 2022 11:49:25 -0600
Message-ID: <c007c87b1c0c1c254815defd6ec06886d2b55f77.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Joachim Wiberg <troglobit@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Date: Fri, 14 Jan 2022 11:49:24 -0600
In-Reply-To: <20220112112459.1033754-1-troglobit@gmail.com>
References: <20220112112459.1033754-1-troglobit@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::946b
X-SA-Exim-Rcpt-To: troglobit@gmail.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 tobias@waldekranz.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 1/1] powerpc/e500/qemu-e500: allow core to idle without
 waiting
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2022-01-12 at 12:24 +0100, Joachim Wiberg wrote:
> From: Tobias Waldekranz <tobias@waldekranz.com>
> 
> This means an idle guest won't needlessly consume an entire core on
> the host, waiting for work to show up.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  arch/powerpc/platforms/85xx/qemu_e500.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c
> b/arch/powerpc/platforms/85xx/qemu_e500.c
> index a4127b0b161f..4c4d577effd9 100644
> --- a/arch/powerpc/platforms/85xx/qemu_e500.c
> +++ b/arch/powerpc/platforms/85xx/qemu_e500.c
> @@ -67,4 +67,9 @@ define_machine(qemu_e500) {
>         .get_irq                = mpic_get_coreint_irq,
>         .calibrate_decr         = generic_calibrate_decr,
>         .progress               = udbg_progress,
> +#ifdef CONFIG_PPC64
> +       .power_save             = book3e_idle,
> +#else
> +       .power_save             = e500_idle,
> +#endif
>  };

Acked-by: Scott Wood <oss@buserror.net>

-Scott


