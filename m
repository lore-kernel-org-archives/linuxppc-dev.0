Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762AC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:30:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59593213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59593213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qjg927nkzF3F0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:30:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjK932gXzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjK90z60z9sRp; Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8139046a5a34787849df81f4a5875cf4b404a7a1
In-Reply-To: <20180907073448.6908-1-vaibhav@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3] powerpc/powernv: Make possible for user to force a full ipl
 cec reboot
Message-Id: <42QjK90z60z9sRp@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
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
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-09-07 at 07:34:48 UTC, Vaibhav Jain wrote:
> Ever since fast reboot is enabled by default in opal,
> opal_cec_reboot() will use fast-reset instead of full IPL to perform
> system reboot. This leaves the user with no direct way to force a full
> IPL reboot except changing an nvram setting that persistently disables
> fast-reset for all subsequent reboots.
> 
> This patch provides a more direct way for the user to force a one-shot
> full IPL reboot by passing the command line argument 'full' to the
> reboot command. So the user will be able to tweak the reboot behavior
> via:
> 
>   $ sudo reboot full	# Force a full ipl reboot skipping fast-reset
> 
>   or
>   $ sudo reboot  	# default reboot path (usually fast-reset)
> 
> The reboot command passes the un-parsed command argument to the kernel
> via the 'Reboot' syscall which is then passed on to the arch function
> pnv_restart(). The patch updates pnv_restart() to handle this cmd-arg
> and issues opal_cec_reboot2 with OPAL_REBOOT_FULL_IPL to force a full
> IPL reset.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8139046a5a34787849df81f4a5875c

cheers
