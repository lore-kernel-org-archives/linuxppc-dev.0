Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from fuzix.org (www.llwyncelyn.cymru [82.70.14.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wttfs2fw8zDr2d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:37:08 +1000 (AEST)
Date: Thu, 22 Jun 2017 21:36:55 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates
 <sbates@raithlin.com>
Subject: Re: [PATCH 3/7] asm-generic/io.h: make ioread64 and iowrite64
 universally available
Message-ID: <20170622213655.07dffac2@alans-desktop>
In-Reply-To: <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-4-logang@deltatee.com>
 <20170622211431.14270378@alans-desktop>
 <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 14:24:58 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 6/22/2017 2:14 PM, Alan Cox wrote:
> > If a platform doesn't support 64bit I/O operations from the CPU then you
> > either need to use some kind of platform/architecture specific interface
> > if present or accept you don't have one.  
> 
> Yes, I understand that.
> 
> The thing is that every user that's currently using it right now is 
> patching in their own version that splits it on non-64bit systems.
> 
> > It's not safe to split it. Possibly for some use cases you could add an
> > ioread64_maysplit()  
> 
> I'm open to doing something like that.

I think that makes sense for the platforms with that problem. I'm not
sure there are many that can't do it for mmio at least. 486SX can't do it
and I guess some ARM32 but I think almost everyone else can including
most 32bit x86.

What's more of a problem is a lot of platforms can do 64bit MMIO via
ioread/write64 but not 64bit port I/O, and it's not clear how you
represent that via an ioread/write API that abstracts it away.

Alan
