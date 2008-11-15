Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3662ADDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 18:12:50 +1100 (EST)
Subject: Re: [PATCH 01/11] async_tx: don't use src_list argument of
	async_xor() for dma addresses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <e9c3a7c20811141642q7608e642sd14b3021223a2d3c@mail.gmail.com>
References: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
	<1226589364-5619-2-git-send-email-yanok@emcraft.com>
	<e9c3a7c20811141642q7608e642sd14b3021223a2d3c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 15 Nov 2008 18:12:22 +1100
Message-Id: <1226733142.7178.162.camel@pasglop>
Mime-Version: 1.0
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-14 at 17:42 -0700, Dan Williams wrote:
> I don't like the stack space implications of this change.  Especially
> for large arrays we will be carrying two 'src_cnt' size arrays on the
> stack, one from MD and one from async_tx.  However, I think the
> current scheme of overwriting input parameters is pretty ugly. 

Well, it's also broken :-) On a number of architectures, dma_addr_t can
be 64 bit while page * is 32 bit

>  So, I
> want to benchmark the performance implications of adding a GFP_NOIO
> allocation here, with the idea being that if the allocation fails we
> can still fallback to the synchronous code path.
