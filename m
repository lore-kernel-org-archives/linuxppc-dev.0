Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F765B6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 01:39:15 +1000 (EST)
In-Reply-To: <1306059295-25806-1-git-send-email-dbaryshkov@gmail.com>
References: <1306059295-25806-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <41281836ef63fbd23f9f01cee34078bc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V2 1/2] Maple: register CPC925 EDAC device on all boards
	with CPC925
Date: Mon, 23 May 2011 17:40:40 +0200
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Currently Maple setup code creates cpc925_edac device only on
> Motorola ATCA-6101 blade. Make setup code check bridge revision
> and enable EDAC on all U3H bridges.
>
> Verified on Momentum MapleD (ppc970fx kit) board.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

One tiny thing:

> +	if (rev >= 0x34 && rev <= 0x3f) { /* U3H */
> +		printk(KERN_ERR "%s: Non-CPC925(U3H) bridge revision: %02x\n",
> +			__func__, rev);
> +		return -ENODEV;
> +	}

That's not really an error, is it?


Segher
