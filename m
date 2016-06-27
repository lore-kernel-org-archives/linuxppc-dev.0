Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdj5v73LfzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:40:19 +1000 (AEST)
Message-ID: <1467063605.20278.93.camel@kernel.crashing.org>
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Jun 2016 07:40:05 +1000
In-Reply-To: <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
 <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-27 at 22:42 +0200, Gerhard Pircher wrote:
> This patch series reminds me of a long-standing issue with the
> AmigaOne platform code, which would have to clear the coherence
> (M) flag for every memory mapping to avoid lockups (especially
> on G4 CPUs) - as you can read in the comment below your patch
> above.
> 
> Now the follow-up code in amigaone/setup.c to clear the
> corresponding CPU feature flag is essentially dead code (it used
> to work with a second call of do_feature_fixups() before the
> handling of the CPU_FTR_NEED_COHERENT flag was changed/inverted
> somewhere around v2.6.30). Also it doesn't seem to fix all
> deadlocks, as e.g. KVM virtual machines can still inject memory
> mappings with the M flag set AFAICT.
> 
> Now I wonder, if there is a reasonably clean way to clear the M
> flag in all hardware page table and BAT entries without defacing
> generic kernel code too much. Any ideas?

Other than a compile time option ? Do we know where the lockups come
from btw ? A problem with the northbridge ?

Cheers,
Ben.
