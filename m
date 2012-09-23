Return-Path: <anton@samba.org>
Date: Mon, 24 Sep 2012 07:04:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove tlb batching hack for nighthawk
Message-ID: <20120924070405.1a5d1c33@kryten>
In-Reply-To: <1348214908-32605-1-git-send-email-michael@ellerman.id.au>
References: <1348214908-32605-1-git-send-email-michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Sep 2012 18:08:28 +1000
Michael Ellerman <michael@ellerman.id.au> wrote:

> In hpte_init_native() we call tlb_batching_enabled() to decide if we
> should setup ppc_md.flush_hash_range.
> 
> tlb_batching_enabled() checks the _unflattened_ device tree, to see
> if we are running on a nighthawk.
> 
> Since commit a223535 ("dont allow pSeries_probe to succeed without
> initialising MMU", Dec 2006), hpte_init_native() has been called from
> pSeries_probe() - at which point we have not yet unflattened the
> device tree.
> 
> This means tlb_batching_enabled() will always return true, so the hack
> has effectively been disabled since Dec 2006. Ergo, I think we can
> drop it.

Ouch. We probably had the last nighthawk in existence and we crushed it
years ago. So:

Acked-by: Anton Blanchard <anton@samba.org>

Anton
