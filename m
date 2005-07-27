Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 756A067D7F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 06:20:20 +1000 (EST)
Date: Wed, 27 Jul 2005 13:18:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Message-Id: <20050727131857.78a56972.akpm@osdl.org>
In-Reply-To: <11224856623638@foobar.com>
References: <11224856623638@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/3] ppc32: add 440ep support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> +static u64 dma_mask = 0xffffffffULL;

I'm sure you're totally uninterested in this, but the above will probably
generate warnings on (say) ppc64, where u64 is implemented as unsigned
long.

I usually chuck a simple `-1' in there and the compiler always gets it
right, regardless of signedness and size and architecture.
