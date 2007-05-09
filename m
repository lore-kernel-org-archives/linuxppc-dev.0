Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 136FFDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 09:53:48 +1000 (EST)
Date: Wed, 9 May 2007 16:53:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-Id: <20070509165317.fcf7dbf5.akpm@linux-foundation.org>
In-Reply-To: <20070508224206.4039.87074.stgit@localhost.localdomain>
References: <20070508224206.4039.87074.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 May 2007 02:42:07 +0400
Vitaly Bordug <vitb@kernel.crashing.org> wrote:

> +		model = (char *)get_property(np, "model", NULL);
> +		if (model == NULL)
> +			return -ENODEV;
> +
> +		id = (u32 *) get_property(np, "device-id", NULL);

get_property() got renamed to of_get_property().

You have two coding-styles in the typecasting here.  The former (no space)
is more common and makes more sense, IMO.

However of_get_property() returns const void* so really you shouldn't be
doing any casting at all.  `model' should have type `const char *' and then
you can do

	model = get_property(np, "model", NULL);

which has nice type-safety and const-correctness.
