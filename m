Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96E09DDFA3
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:37:54 +1100 (EST)
Subject: Re: [PATCH 1/2] OF: new helper: of_parse_phandles_with_args()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080925183710.GA25627@oksana.dev.rtsoft.ru>
References: <20080925183641.GA20037@oksana.dev.rtsoft.ru>
	<20080925183710.GA25627@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 14:37:29 +1100
Message-Id: <1223609849.8157.135.camel@pasglop>
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


> +	for (i = 0; i < list_cells; cur_index++) {
> +		const u32 *cells;
> +		const phandle *phandle;
> +
> +		phandle = list + i;
> +		args = phandle + 1;

Rather than incrementing i, I would just use a running pointer "list"
and drop "i" totally. Not big deal tho.

> +		/* one cell hole in the list = <>; */
> +		if (!*phandle) {
> +			if (cur_index == index)
> +				return -ENOENT;
> +			i++;
> +			continue;
> +		}

I don't totally understand the above. The 0 phandle terminates the list
or is just an empty slot in it ? In the later case, it might be more
readable to use goto to skip over down to the normal if (cur_index ==
index) break; and let it return via the normal if (!node) return -ENOENT
out of the loop.

Appart from that it's good and I'm fine with putting it in if you respin
despite being a bit late mostly because it's me who is later reviewing
there :-)

Cheers,
Ben.
