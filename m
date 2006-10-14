Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CD13167B54
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 12:02:32 +1000 (EST)
Date: Fri, 13 Oct 2006 21:01:47 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
Message-ID: <20061013210147.4c904ad1@localhost.localdomain>
In-Reply-To: <1160779006.4792.269.camel@localhost.localdomain>
References: <1160726663.4792.222.camel@localhost.localdomain>
	<20061013115457.7b36a7c3@localhost.localdomain>
	<1160779006.4792.269.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 14 Oct 2006 08:36:46 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > You can advance the pointer with L1_CACHE_BYTES/sizeof(int) per
> > iteration in the second loop here.
> 
> Yeah, I suppose so. Though I'm not 100% confident we get L1_CACHE_BYTES
> on all cpus, for example, PA6T is 64 bytes ;) We could use
> cur_cpu_spec->icache_bsize but that would involve ugly RELOC's to get it
> right on 32 bits. I decided not to care for now.

Ugh, yeah, I remember this when I did the patches but forgot about it
now. L1_CACHE_BYTES is used in a number of places, but overall used as
the largest value needed to bump between lines to avoid false sharing.

The other early places seems to have used hardcoded constants. I guess
it's better to just loop over every word like you're already doing. It
still avoids a barrier on every iteration.


-Olof
