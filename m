Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C5C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 10:32:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07706195C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 10:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07706195C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8m3g6v5Dz30QR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8m3K4JKLz2yyM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 21:32:10 +1100 (AEDT)
Received: from [192.168.0.2] (ip5f5aef3e.dynamic.kabel-deutschland.de
 [95.90.239.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3A6522064AF3E;
 Tue, 30 Mar 2021 12:32:04 +0200 (CEST)
Subject: Re: [PATCH] powerpc/pseries: Only register vio drivers if vio bus
 exists
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20210316010938.525657-1-mpe@ellerman.id.au>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <37664153-c31e-bd20-71b4-9afa049dc60a@molgen.mpg.de>
Date: Tue, 30 Mar 2021 12:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210316010938.525657-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Michael,


Am 16.03.21 um 02:09 schrieb Michael Ellerman:
> The vio bus is a fake bus, which we use on pseries LPARs (guests) to
> discover devices provided by the hypervisor. There's no need or sense
> in creating the vio bus on bare metal systems.
> 
> Which is why commit 4336b9337824 ("powerpc/pseries: Make vio and
> ibmebus initcalls pseries specific") made the initialisation of the
> vio bus only happen in LPARs.
> 
> However as a result of that commit we now see errors at boot on bare
> metal systems:
> 
>    Driver 'hvc_console' was unable to register with bus_type 'vio' because the bus was not initialized.
>    Driver 'tpm_ibmvtpm' was unable to register with bus_type 'vio' because the bus was not initialized.
> 
> This happens because those drivers are built-in, and are calling
> vio_register_driver(). It in turn calls driver_register() with a
> reference to vio_bus_type, but we haven't registered vio_bus_type with
> the driver core.
> 
> Fix it by also guarding vio_register_driver() with a check to see if
> we are on pseries.
> 
> Fixes: 4336b9337824 ("powerpc/pseries: Make vio and ibmebus initcalls pseries specific")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/platforms/pseries/vio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 9cb4fc839fd5..429053d0402a 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1285,6 +1285,10 @@ static int vio_bus_remove(struct device *dev)
>   int __vio_register_driver(struct vio_driver *viodrv, struct module *owner,
>   			  const char *mod_name)
>   {
> +	// vio_bus_type is only initialised for pseries
> +	if (!machine_is(pseries))
> +		return -ENODEV;
> +
>   	pr_debug("%s: driver %s registering\n", __func__, viodrv->name);
>   
>   	/* fill in 'struct driver' fields */

Thank you. The errors are gone now.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # IBM S822L (POWER8)

As it fixes a commit from Linux 5.8, should it be tagged for the stable 
releases, or is it going to be picked up automatically due to the Fixes tag?


Kind regards,

Paul
