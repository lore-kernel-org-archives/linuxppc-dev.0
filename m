Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FFE0DDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:01:25 +1100 (EST)
Subject: Re: [PATCH 1/2 v2] OF: new helper: of_parse_phandles_with_args()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081010144317.GA2634@oksana.dev.rtsoft.ru>
References: <20080925183641.GA20037@oksana.dev.rtsoft.ru>
	<20080925183710.GA25627@oksana.dev.rtsoft.ru>
	<1223609849.8157.135.camel@pasglop>
	<20081010144317.GA2634@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 10:31:23 +1100
Message-Id: <1223854283.8157.202.camel@pasglop>
Mime-Version: 1.0
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-10 at 18:43 +0400, Anton Vorontsov wrote:
> The helper is factored out of of_get_gpio(). Will be used by the QE
> pin multiplexing functions (they need to parse the gpios = <> too).
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

> +	while (list < list_end) {
> +		const u32 *cells;
> +		const phandle *phandle;
> +
> +		phandle = list;
> +		args = list + 1;
> +
> +		/* one cell hole in the list = <>; */
> +		if (!*phandle) {
> +			list++;
> +			goto next;
> +		}

Allright. I'll merge it. It might have been nicer to write here

		phandle = list++;
		args = list;

		if (!*phandle)
			goto next;

		.../...

		list += *cells;

But it's not big deal, I'll merge it as-is and if you feel like it
you can aways submit a cleanup later. In fact you can even completely
drop "args" I think.

Cheers,
Ben.
