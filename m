Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Date: Wed, 4 Aug 2010 23:18:16 +0900
To: Joerg.Roedel@amd.com
Subject: Re: 2.6.35-stable/ppc64/p7: Badness at lib/dma-debug.c:902, Call
	Trace	& Instruction Dump during boot
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100804131634.GX26098@amd.com>
References: <1280746270.15317.16.camel@subratamodak.linux.ibm.com>
	<20100802205404C.fujita.tomonori@lab.ntt.co.jp>
	<20100804131634.GX26098@amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100804231727H.fujita.tomonori@lab.ntt.co.jp>
Cc: sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, santil@us.ibm.com,
	fujita.tomonori@lab.ntt.co.jp, Linuxppc-dev@ozlabs.org,
	devilbis@us.ibm.com, James.Bottomley@suse.de, sleddog@us.ibm.com,
	brking@linux.vnet.ibm.com, tj@kernel.org,
	subrata@linux.vnet.ibm.com, dipraksh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Aug 2010 15:16:34 +0200
"Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:

> On Mon, Aug 02, 2010 at 07:55:03AM -0400, FUJITA Tomonori wrote:
> > I guess that this driver does a partial sync with
> > dma_sync_single_for_* API. dma-debug can't handle it properly. It's
> > likely that this is a false warning.
> 
> If this turns out to be true it is not trivial to fix. I prepare a patch
> to test for you.

I've not looked at the details of this driver, but there are drivers
that do such. So dma-debug needs to be fixed anyway; you can't assume
that a DMA address that dma_map_single returned is passed to
dma_sync_single_for API.
