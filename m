Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D576DDE46
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 00:55:16 +1100 (EST)
In-Reply-To: <200701021238.36297.m.kozlowski@tuxland.pl>
References: <200701021238.36297.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: vio of_node_put cleanup
Date: Tue, 2 Jan 2007 14:55:40 +0100
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  static void __devinit vio_dev_release(struct device *dev)
>  {
> -	if (dev->archdata.of_node) {
> -		/* XXX should free TCE table */
> -		of_node_put(dev->archdata.of_node);
> -	}
> +	/* XXX should free TCE table */
> +	of_node_put(dev->archdata.of_node);
>  	kfree(to_vio_dev(dev));
>  }

The comment used to be inside the "if" block, is this
change correct?

[And, do we want all these changes anyway?  I don't care
either way, both sides have their pros and their cons --
just asking :-) ]


Segher
