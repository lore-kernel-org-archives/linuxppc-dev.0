Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 537DD1A0A49
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 13:53:00 +1100 (AEDT)
Message-ID: <1420599166.4961.47.camel@freescale.com>
Subject: Re: [PATCH] powerpc/8xx: reduce pressure on TLB due to context
 switches
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 6 Jan 2015 20:52:46 -0600
In-Reply-To: <20150105151453.E32BD1A4CF3@localhost.localdomain>
References: <20150105151453.E32BD1A4CF3@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-05 at 16:14 +0100, Christophe Leroy wrote:
> +		}
> +		__clear_bit(id, stale_map[cpu]);
> +
> +	}

Whitespace

> +
> +	/* Flush the TLB for all contexts */
> +	_tlbil_all();

Can you put a comment in here pointing out that for this to work on SMP,
it needs to be a global invalidation, or at least some indication on
this function that it's not SMP-safe?  I realize there's no SMP 8xx, and
this is only called in place of steal_context_up(), but in case others
think of reusing this elsewhere[1]...

-Scott

[1] It might be helpful on e500 derivatives in virtualized environments
where invalidate-by-PID is expensive, depending on how often stealing
happens there.
