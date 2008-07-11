Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id AA552DE028
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 04:23:26 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3993105wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 11:23:25 -0700 (PDT)
Date: Fri, 11 Jul 2008 12:23:23 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711182323.GB15321@secretlab.ca>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080711174859.GA24260@polina.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
> Firstly kernel warns at set_irq_chip, and then dies completely:
> 
> Trying to install chip for IRQ-1
>
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index b2ccdcb..95a24de 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  		if (info.irq == NO_IRQ)
>  			info.irq = -1;

What is the reason that info.irq is set to -1 in the first place?  This
looks like another bug to me.  Does something in the i2c layer depend on
the -1 value?

g.
