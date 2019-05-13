Return-Path: <SRS0=ygHD=TN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D66DC04AB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 07:14:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73A820578
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 07:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73A820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 452XBC0Ln6zDq9Z
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 17:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.34.195; helo=11.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 2133 seconds by postgrey-1.36 at bilbo;
 Mon, 13 May 2019 17:12:47 AEST
Received: from 11.mo4.mail-out.ovh.net (11.mo4.mail-out.ovh.net
 [46.105.34.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452X8H2tbwzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 17:12:43 +1000 (AEST)
Received: from player776.ha.ovh.net (unknown [10.109.159.159])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 57CEC1EC192
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 08:37:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id 695205A45567;
 Mon, 13 May 2019 06:36:59 +0000 (UTC)
Subject: Re: [PATCH] powerpc: Document xive=off option
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
References: <20190513053910.19227-1-mikey@neuling.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <db3a3289-1c5f-f744-1314-fb1fc19e8287@kaod.org>
Date: Mon, 13 May 2019 08:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513053910.19227-1-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1193735380038880153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
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
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/13/19 7:39 AM, Michael Neuling wrote:
> commit 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE
> interrupt controller") added an option to turn off Linux native XIVE
> usage via the xive=off kernel command line option.
> 
> This documents this option.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>



Reviewed-by: Cédric Le Goater <clg@kaod.org>


But,

We should fix the behavior because xive=off does not work on pseries. 
This is not handled correctly in prom when CAS negotiates with the 
hypervisor which interrupt mode is to be used. 

I haven't tried this option on PowerNV.

Cheers,

C.


> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c45a19d654..ee410d0ef4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5177,6 +5177,15 @@
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
>  
> +	xive=		[PPC]
> +			By default on POWER9 and above, the kernel will
> +			natively use the XIVE interrupt controller. This option
> +			allows the fallback firmware mode to be used:
> +
> +			off       Fallback to firmware control of XIVE interrupt
> +				  controller on both pseries and powernv
> +				  platforms. Only useful on POWER9 and above.
> +
>  	xhci-hcd.quirks		[USB,KNL]
>  			A hex value specifying bitmask with supplemental xhci
>  			host controller quirks. Meaning of each bit can be
> 

