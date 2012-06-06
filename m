Return-Path: <aarcange@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3F4A9B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 23:14:54 +1000 (EST)
Date: Wed, 6 Jun 2012 15:14:42 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix assmption of end_of_DRAM() returns end
 address
Message-ID: <20120606131442.GN21339@redhat.com>
References: <1338904504-2750-1-git-send-email-bharat.bhushan@freescale.com>
 <1338934659.7150.113.camel@pasglop>
 <20120605.152058.828742127223799137.davem@davemloft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D03D68F08@039-SN2MPN1-022.039d.mgd.msft.net>
 <1338960617.7150.163.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338960617.7150.163.camel@pasglop>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jun 06, 2012 at 03:30:17PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-06-06 at 00:46 +0000, Bhushan Bharat-R65777 wrote:
> 
> > > >> memblock_end_of_DRAM() returns end_address + 1, not end address.
> > > >> While some code assumes that it returns end address.
> > > >
> > > > Shouldn't we instead fix it the other way around ? IE, make
> > > > memblock_end_of_DRAM() does what the name implies, which is to
> > return
> > > > the last byte of DRAM, and fix the -other- callers not to make bad
> > > > assumptions ?
> > > 
> > > That was my impression too when I saw this patch.
> > 
> > Initially I also intended to do so. I initiated a email on linux-mm@
> > subject "memblock_end_of_DRAM()  return end address + 1" and the only
> > response I received from Andrea was:
> > 
> > "
> > It's normal that "end" means "first byte offset out of the range". End
> > = not ok.
> > end = start+size.
> > This is true for vm_end too. So it's better to keep it that way.
> > My suggestion is to just fix point 1 below and audit the rest :)
> > "
> 
> Oh well, I don't care enough to fight this battle in my current state so

I wish you to get well soon Ben!

> unless Dave has more stamina than I have today, I'm ok with the patch.

Well it doesn't really matter in the end what is decided as long as
something is decided :). I was asked through a forward so I only
expressed my preference...
