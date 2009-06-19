Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2BCA7B727B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 08:29:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8730DDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 08:29:58 +1000 (EST)
Subject: Re: [PowerPC] 2.6.30-git14 boot failure with SLAB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A3BC57B.8000408@in.ibm.com>
References: <4A3B615F.8090504@in.ibm.com>  <4A3BC57B.8000408@in.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Jun 2009 08:29:40 +1000
Message-Id: <1245450580.16880.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-19 at 22:36 +0530, Sachin Sant wrote:
> The offending commit seems to be
> c868d550115b9ccc0027c67265b9520790f05601.
> mm: Move pgtable_cache_init() earlier
> 
> If i revert this commit, the machine boots fine.

That is strange. If I revert that commit, I get breakages on machines
here. It would be interesting to understand what the problem is here,
as we -do- use that kmem cache for allocating page tables, so we do
need it initialized that early. (IE, we can't allow vmalloc for example
to be called before the page table caches are initialized).

This will need more debugging and understanding as to why it hangs.

Cheers,
Ben.
