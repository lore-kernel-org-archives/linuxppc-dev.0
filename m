Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3B83DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 07:21:39 +1000 (EST)
Date: Mon, 14 May 2007 14:21:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [POWERPC] 8xx: mpc885ads pcmcia support
Message-Id: <20070514142125.851f3d10.akpm@linux-foundation.org>
In-Reply-To: <20070508223123.3633.72309.stgit@localhost.localdomain>
References: <20070508222748.3633.37120.stgit@localhost.localdomain>
	<20070508223123.3633.72309.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 May 2007 02:31:25 +0400
Vitaly Bordug <vitb@kernel.crashing.org> wrote:

> +/* 
> + * Some internal interrupt registers use an 8-bit mask for the interrupt
> + * level instead of a number.
> + */
> +static inline uint mk_int_int_mask(uint mask) {
> +	return (1 << (7 - (mask/2)));
> +}

grumble.  "uint" isn't a favoured "type".  Please prefer to
use "unsigned int" if that's what is meant.  Or maybe u32,
if that's more appropriate - and it probably is, as we're
dealing with device registers here.
