Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 23AE2DE077
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:22:02 +1000 (EST)
Date: Tue, 29 May 2007 09:27:15 -0500
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix compile warning in pseries xics
Message-ID: <20070529142715.GA29108@lixom.net>
References: <27973.1180417829@neuling.org>
	<1180417937.5313.6.camel@concordia.ozlabs.ibm.com>
	<4564.1180422112@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4564.1180422112@neuling.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 05:01:52PM +1000, Michael Neuling wrote:
> @@ -762,11 +763,12 @@ void xics_request_IPIs(void)
>  	 */
>  	set_irq_handler(ipi, handle_percpu_irq);
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
> -		request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> -			    "IPI", NULL);
> +		rc = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> +				"IPI", NULL);
>  	else
> -		request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> -			    "IPI", NULL);
> +		rc = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> +				"IPI", NULL);
> +	BUG_ON(rc);

Is this late enough during boot that you actually get useful information
out of a BUG()?  It might be better to spit out an error and keep on
going if that's the case (I'm afraid I don't have hardware at hand to
test with right now).


-Olof
