Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A7511DDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 02:51:14 +1000 (EST)
Date: Fri, 14 Sep 2007 11:52:33 -0500
From: Olof Johansson <olof@lixom.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pcmcia: Convert io_req_t to use kio_addr_t
Message-ID: <20070914165233.GA3045@lixom.net>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070914034854.1658a9cf.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, hch@lst.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 03:48:54AM -0700, Andrew Morton wrote:
> On Wed, 5 Sep 2007 09:27:43 -0500 Olof Johansson <olof@lixom.net> wrote:
> 
> > Convert the io_req_t members to kio_addr_t, to allow use on machines with
> > more than 16 bits worth of IO port address space (ppc64 in this case,
> > but it applies to others as well).
> 
> drivers/usb/host/sl811_cs.c: In function 'sl811_cs_config':
> drivers/usb/host/sl811_cs.c:263: warning: format '%04x' expects type 'unsigned int', but argument 2 has type 'kio_addr_t'
> drivers/usb/host/sl811_cs.c:263: warning: format '%04x' expects type 'unsigned int', but argument 3 has type 'long unsigned int'
> 
> That's not just a cosmetic thing - the printk can print junk and if there's
> a %s in the control string after the %x's, printk() will crash.
> 
> I don't know how many instances of this are in the tree, but they'll all
> need to be found and fixed.

A crap, I completely forgot to check drivers/, and my default builds
don't contain many of them. My bad.

I'll do a full pass and review all references to the changed variables. So
far I've only noticed printk stuff, but I'm not done. There's a fair
amount lot of places where they're cast into ints instead of longs,
but that's a whole other ball of wax (and shouldn't cause regressions
like the printk ones could).


-Olof
