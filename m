Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id DB85467DB0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 23:02:21 +1000 (EST)
Date: Thu, 28 Jul 2005 15:02:19 +0200
From: Domen Puncer <domen@coderock.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050728130219.GB2249@homer.coderock.org>
References: <11224856623638@foobar.com> <20050727131857.78a56972.akpm@osdl.org>
	<17128.4407.838024.111955@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
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

On 27/07/05 18:56 -0400, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > Matt Porter <mporter@kernel.crashing.org> wrote:
> > >
> > > +static u64 dma_mask = 0xffffffffULL;

How about just DMA_32BIT_MASK from dma-mapping.h, that one has to be
correct. ;-)

> > 
> > I'm sure you're totally uninterested in this, but the above will probably
> > generate warnings on (say) ppc64, where u64 is implemented as unsigned
> > long.
> > 
> > I usually chuck a simple `-1' in there and the compiler always gets it
> > right, regardless of signedness and size and architecture.
> 
> Umm, I think we actually want 2^32-1 not -1, don't we?  In which case
> I think Matt's code is what we have to have.
> 
> I tried a little test compile with gcc 4.0 with -m64 -Wall and it
> didn't generate a warning with the 0xffffffffULL constant.
