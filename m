Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 08DD9DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:56:11 +1100 (EST)
Date: Fri, 18 Jan 2008 07:56:21 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: crash in kmem_cache_init
Message-ID: <20080118065621.GA27495@aepfle.de>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080117211511.GA25320@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, Olaf Hering wrote:

> On Thu, Jan 17, Christoph Lameter wrote:
> 
> > On Thu, 17 Jan 2008, Olaf Hering wrote:
> > 
> > > The patch does not help.
> > 
> > Duh. We need to know more about the problem.
> 
> cache_grow is called from 3 places. The third call has cleared l3 for
> some reason.

Typo in debug patch.

calls cache_grow with nodeid 0
> [c00000000075bbd0] [c0000000000f82d0] .cache_alloc_refill+0x234/0x2c0
calls cache_grow with nodeid 0
> [c00000000075bbe0] [c0000000000f7f38] .____cache_alloc_node+0x17c/0x1e8

calls cache_grow with nodeid 1
> [c00000000075bbe0] [c0000000000f7d68] .fallback_alloc+0x1a0/0x1f4
