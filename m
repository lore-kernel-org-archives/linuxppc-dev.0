Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 83DBFDDF5E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 05:51:02 +1100 (EST)
Date: Fri, 18 Jan 2008 10:42:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080118065621.GA27495@aepfle.de>
Message-ID: <Pine.LNX.4.64.0801181042060.30348@schroedinger.engr.sgi.com>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de> <20080118065621.GA27495@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 18 Jan 2008, Olaf Hering wrote:

> calls cache_grow with nodeid 0
> > [c00000000075bbd0] [c0000000000f82d0] .cache_alloc_refill+0x234/0x2c0
> calls cache_grow with nodeid 0
> > [c00000000075bbe0] [c0000000000f7f38] .____cache_alloc_node+0x17c/0x1e8
> 
> calls cache_grow with nodeid 1
> > [c00000000075bbe0] [c0000000000f7d68] .fallback_alloc+0x1a0/0x1f4

Hmmm... fallback_alloc should not be called during bootstrap.
