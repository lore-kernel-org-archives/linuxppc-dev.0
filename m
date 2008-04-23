Return-Path: <super.firetwister@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 222A6DDF3F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 15:05:38 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so314691uge.0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 22:05:36 -0700 (PDT)
To: benh@kernel.crashing.org
Subject: Re: Phy read timeout in ibm_new_emac driver
Date: Wed, 23 Apr 2008 07:06:31 +0200
References: <6a6049b80804160349q42120b4bs1c0db49ea5ad055d@mail.gmail.com>
	<1208347791.6958.279.camel@pasglop>
In-Reply-To: <1208347791.6958.279.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804230706.32641.super.firetwister@gmail.com>
From: Markus Brunner <super.firetwister@googlemail.com>
Cc: netdev@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 April 2008, Benjamin Herrenschmidt wrote:

> Somebody knows off hand what the standard says the timeout should be ?

Anyone?

I didn't find any documentation on the standard, but I had a look at other 
drivers. 
au1000_eth.c waits 20 ms (20 * 1ms) in mdio_read.
bfin_mac.c waits 500 * 1us in mdio_poll. 
In both functions the last delay before the timeout is useless, like in 
new_emac. Not nice, but timeouts shouldn't occur anyway.

new emac probably doesn't wait long enough, but 20ms seems to be a bit too 
long.

Regards
Markus
