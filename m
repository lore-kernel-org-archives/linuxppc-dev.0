Return-Path: <rick.jones2@hp.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A51AB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 04:57:31 +1000 (EST)
Received: from g5t0008.atlanta.hp.com (g5t0008.atlanta.hp.com [15.192.0.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DABBDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 04:57:31 +1000 (EST)
Message-ID: <4A53984A.4050002@hp.com>
Date: Tue, 07 Jul 2009 11:47:38 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] ucc_geth: Add support for skb recycling
References: <20090707183842.GA8425@oksana.dev.rtsoft.ru>
In-Reply-To: <20090707183842.GA8425@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> We can reclaim transmitted skbs to use in the receive path, so-called
> skb recycling support.
> 
> Also reorder ucc_geth_poll() steps, so that we'll clean tx ring firstly,
> thus maybe reclaim some skbs for rx.

Admittedly, all the world is not TCP, but a big chunk is, so are you likely to 
have reference counts go to zero on the tx queue for anything other than small 
standalone TCP ACK segments?

rick jones
