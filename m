Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 37BA6DDF1E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 08:25:14 +1000 (EST)
Date: Thu, 14 Jun 2007 15:26:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Vladislav Buzov <vbuzov@ru.mvista.com>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Message-ID: <20070614222620.GA17382@mag.az.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <467176EB.7060404@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2007 at 09:12:11PM +0400, Vladislav Buzov wrote:
> Segher Boessenkool wrote:

> >>      /* TODO: use HW flush assist when available */
> >
> >
> > You want to get rid of this old comment though -- and
> > perhaps branch over the non-hardware-assisted cache
> > flushing code.
> 
> Ok, I agree that the comment is obsolete now. Would you please explain 
> why the branch over non-hardware-assisted code should be removed as 
> well. Technically the cache is flushed and there is no need to use extra 
> commands to fill and then re-flush the cache.

I think Segher is saying that you can skip the manual invalidation too
(although he said "flushing", I think he really meant "invalidation"--
the manual flushing is already skipped).  If I'm reading the manual
correctly, L2HWF does the invalidation as well so both the manual
flushing and invalidation can be skipped.

Mark
