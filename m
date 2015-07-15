Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EB861A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:17:12 +1000 (AEST)
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1BAB1402BA
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 16:17:11 +1000 (AEST)
Received: by pdbqm3 with SMTP id qm3so19094772pdb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 23:17:08 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
Message-ID: <1436941021.17171.12.camel@jms.id.au>
Subject: Re: [PATCH v4 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
From: Joel Stanley <joel@jms.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Wed, 15 Jul 2015 15:47:01 +0930
In-Reply-To: <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

Hello,

On Mon, 2015-07-13 at 19:39 +0530, Shilpasri G Bhat wrote:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d0c18c9..1f59958 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -414,6 +415,71 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> +static char throttle_reason[][30] = {
> +					"No throttling",
> +					"Power Cap",
> +					"Processor Over Temperature",
> +					"Power Supply Failure",
> +					"Over Current",
> +					"OCC Reset"
> +				     };
> +
> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +				   unsigned long msg_type, void *_msg)
> +{
> +	struct opal_msg *msg = _msg;
> +	struct opal_occ_msg omsg;
> +
> +	if (msg_type != OPAL_MSG_OCC)
> +		return 0;
> +
> +	memcpy(&omsg, msg->params, sizeof(omsg));

You need to ensure the of the members of struct opal_occ_msg are in the
correct byte order when copying them over.

Have you tested this code with in a little endian configuration?

Do the messages you're sending make sense for a system that has a BMC
instead of a FSP?

Cheers,

Joel

> +
> +	switch (omsg.type) {
