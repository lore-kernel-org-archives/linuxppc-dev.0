Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wVt0N1qB4zDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 16:57:55 +1000 (AEST)
Date: Sun, 21 May 2017 08:57:49 +0200
From: 'Christoph Hellwig' <hch@lst.de>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Christoph Hellwig' <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tejun Heo <tj@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mark Gross <mark.gross@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
Message-ID: <20170521065749.GA13052@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <063D6719AE5E284EB5DD2968C1650D6DCFFFAA38@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFFAA38@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 19, 2017 at 10:48:51AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 16 May 2017 12:48
> >
> > The new callback gets a pointer to the timer_list itself, which can
> > then be used to get the containing structure using container_of
> > instead of casting from and to unsigned long all the time.
> 
> What about sensible drivers that put some other value in the 'data'
> field?

They will add the equivalent of the data field into the containing
structure of the timer.  Just like we do for all other kernel interfaces
using the container_of patter, which includes just about every
primitive designed in the last 15 years.
