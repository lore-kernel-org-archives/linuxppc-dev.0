Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-145.bluehost.com (outbound-mail-145.bluehost.com
	[67.222.38.35]) by ozlabs.org (Postfix) with SMTP id 9A939DE691
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 08:00:55 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 14:53:38 -0700
References: <1211852026.3286.36.camel@pasglop> <yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<1212097223.8888.55.camel@pasglop>
In-Reply-To: <1212097223.8888.55.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200805291453.38492.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, May 29, 2008 2:40 pm Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-29 at 10:47 -0400, Jes Sorensen wrote:
> > The only way to guarantee ordering in the above setup, is to either
> > make writel() fully ordered or adding the mmiowb()'s inbetween the two
> > writel's. On Altix you have to go and read from the PCI brige to
> > ensure all writes to it have been flushed, which is also what mmiowb()
> > is doing. If writel() was to guarantee this ordering, it would make
> > every writel() call extremely expensive :-(
>
> Interesting. I've always been taught by ia64 people that mmiowb() was
> intended to be used solely between writel() and spin_unlock().

Well, that *was* true, afaik, but maybe these days multipath isn't just for 
fail-over.  If that's true, then yeah making every single writeX ordered 
would be the only way to go...

> If this is a performance problem, then provide relaxed variants and
> use them in selected drivers.

Sounds reasonable.  That way drivers "just work" and important drivers can be 
optimized.

Jesse
