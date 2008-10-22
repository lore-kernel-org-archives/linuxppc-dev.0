Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BE809DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:31:54 +1100 (EST)
In-Reply-To: <20081022163632.2c67a53d@bull.net>
References: <20081022163632.2c67a53d@bull.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42ab1a117d74e33d84cb037bfe79fae0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: XICS - fix getting the server number size
Date: Wed, 22 Oct 2008 15:34:52 -0500
To: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 9:36 AM, Sebastien Dugue wrote:

>
>   The 'ibm,interrupt-server#-size' properties are not cpu nodes 
> properties,
> but rather live under the interrupt source controller nodes (compatible
> ibm,ppc-xics).
>
>   Therefore, this patch moves the detection of this property outside of
> xics_update_irq_servers() and into xics_init_IRQ().
>

yes, PAPR says its on one of the interrupt nodes.   I am too tired to
decipher if it on the presentation or source.


Acked-by: Milton Miller <miltonm@bga.com>

>   Also this adds a check for mismatched sizes across the interrupt 
> source
> controller nodes. Not sure this is necessary as in this case the 
> firmware
> might be seriously busted.

I am hoping you have tested this?  A POWER6 box?

Last time I looked (POWER5 timeframe) firmware was ignoring the 
parameter
to set-indicator(gqirm) which is the only use of this property.

milton
