Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
Date: Wed, 27 Jul 2005 18:56:55 -0400
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050727131857.78a56972.akpm@osdl.org>
References: <11224856623638@foobar.com> <20050727131857.78a56972.akpm@osdl.org>
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

Andrew Morton writes:

> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > +static u64 dma_mask = 0xffffffffULL;
> 
> I'm sure you're totally uninterested in this, but the above will probably
> generate warnings on (say) ppc64, where u64 is implemented as unsigned
> long.
> 
> I usually chuck a simple `-1' in there and the compiler always gets it
> right, regardless of signedness and size and architecture.

Umm, I think we actually want 2^32-1 not -1, don't we?  In which case
I think Matt's code is what we have to have.

I tried a little test compile with gcc 4.0 with -m64 -Wall and it
didn't generate a warning with the 0xffffffffULL constant.

Paul.
