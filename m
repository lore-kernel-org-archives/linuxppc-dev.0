Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBA0A2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 10:13:13 +1100 (EST)
Message-ID: <1389049979.12906.11.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 07 Jan 2014 10:12:59 +1100
In-Reply-To: <20140106202856.5630590efc4bd6a466b7a668@canb.auug.org.au>
References: <20140106202856.5630590efc4bd6a466b7a668@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-06 at 20:28 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
> 
> The last time I got this error, I needed to apply patch "powerpc: Fix
> "attempt to move .org backwards" error", but that has been included in
> the powerpc tree now, so I guess something else has added code in a
> critical place. :-(
> 
> I have just left this broken for today.

I had to modify that patch when applying it, it's possible that the
"new" version isn't making as much room. Without that change it would
fail the build on some of my configs due to some of the asm for the
maskable exception handling being too far from the conditional branches
that calls it.

I think it's time we do a bit of re-org of that file to figure out
precisely what has to be where and move things out more aggressively.

Cheers,
Ben.
