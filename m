Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 94EA6B7121
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 22:48:22 +1000 (EST)
Date: Tue, 28 Sep 2010 07:48:10 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/8] v2 Allow memory block to span multiple memory sections
Message-ID: <20100928124810.GI14068@sgi.com>
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA0EFAA.8050000@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA0EFAA.8050000@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +u32 __weak memory_block_size_bytes(void)
> +{
> +	return MIN_MEMORY_BLOCK_SIZE;
> +}
> +
> +static u32 get_memory_block_size(void)

Can we make this an unsigned long?  We are testing on a system whose
smallest possible configuration is 4GB per socket with 512 sockets.
We would like to be able to specify this as 2GB by default (results
in the least lost memory) and suggest we add a command line option
which overrides this value.  We have many installations where 16GB may
be optimal.  Large configurations will certainly become more prevalent.

...
> @@ -551,12 +608,16 @@
>  	unsigned int i;
>  	int ret;
>  	int err;
> +	int block_sz;

This one needs to match the return above.  In our tests, we ended up
with a negative sections_per_block which caused very unexpected results.

Robin
