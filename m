Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DB48B71AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 23:07:49 +1000 (EST)
In-Reply-To: <1305973871-28244-1-git-send-email-dbaryshkov@gmail.com>
References: <1305973871-28244-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2825c3704d46eca735f20b01be7e33f9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Maple: register CPC925 EDAC device on all boards with
	CPC925
Date: Sat, 21 May 2011 15:09:19 +0200
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
> and enable EDAC on all U3 bridges.

But the EDAC code only works on U3H (CPC925), not old U3.

> +	if ((rev & 0xf0) != 0x30) { /* U3 */
> +		printk(KERN_ERR "%s: Non-CPC925(U3) bridge revision: %02x\n",

Should be:  if (rev >= 0x34 && rev <= 0x3f)


Segher
