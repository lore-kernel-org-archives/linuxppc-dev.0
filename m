Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30A59DDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 12:18:36 +1100 (EST)
Date: Mon, 13 Oct 2008 03:18:27 +0200
From: Nick Piggin <npiggin@suse.de>
To: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081013011827.GA1299@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081012054732.GB12535@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> 
> Implement a more optimal mutex fastpath for powerpc, making use of acquire
> and release barrier semantics. This takes the mutex lock+unlock benchmark
> from 203 to 173 cycles on a G5.
> 
> +static inline int
> +__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> +{
> +	if (likely(__mutex_cmpxchg_lock(count, 1, 0) == 1))
> +		return 1;

Oops, I must have sent the wrong version. This needs a return 0 here.

> +}
