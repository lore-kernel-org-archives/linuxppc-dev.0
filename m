Return-Path: <SRS0+9c5c8d7c21a472aa6c73+1090+infradead.org+arjan@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD7C167B70
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 23:56:28 +1000 (EST)
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20060818134728.GB5201@martell.zuzino.mipt.ru>
References: <200608181329.02042.ossthema@de.ibm.com>
	<20060818134728.GB5201@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:56:17 +0200
Message-Id: <1155909377.4494.192.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Thomas Klein <osstklei@de.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-18 at 17:47 +0400, Alexey Dobriyan wrote:
> On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:
> 
> Was there noticeable performance difference when explicit prefetching is
> removed? At some (invisible) point CPUs will become smarter about prefetching
> than programmers and this code will be slower than possible.

Hi,

what you say is true in general, however the packet response part of the
kernel is special; the cpu just cannot know where your card just dma'd
the packet to (and thus cleared it from any caches anywhere in the
system) so it's going to be pretty much a 100% cachemiss always...

Greetings,
   Arjan van de Ven
