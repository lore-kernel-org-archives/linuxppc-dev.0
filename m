Return-Path: <bcrl@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qQCwg3sjQzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 01:07:15 +1100 (AEDT)
Date: Wed, 16 Mar 2016 10:07:13 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: build failure after merge of the aio tree
Message-ID: <20160316140713.GC14746@kvack.org>
References: <20160315174634.6766cd88@canb.auug.org.au>
 <15874870.hBfxUomX5V@wuerfel>
 <CAHp75VcxkBTSKY_bVg3jaUPUtcyxKZ14sbu=uJK403xRmTYbbQ@mail.gmail.com>
 <4892345.flKnDo9XDS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4892345.flKnDo9XDS@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 16, 2016 at 02:59:38PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 March 2016 13:12:36 Andy Shevchenko wrote:
> > 
> > > I've also sent a patch that fixes the link error on ARM and that should
> > > work on all other architectures too.
> > 
> > In case of avr32 signalfd_read() fails. Does your patch help with it as well?
> > 
> > P.S. Bisecting shows same culprit: 150a0b4905f1 ("aio: add support for
> > async openat()")
> 
> I don't know. What is the symptom on avr32? My patch only removes the
> get_user() instances on 64-bit values and replaces them with a
> single copy_from_user() call.

Which is the wrong fix.  Arch code should be able to handle 64 bit values 
in all the get/put_user() variants.  We use 64 bit variables all over the 
place in interfaces to userspace.

		-ben
