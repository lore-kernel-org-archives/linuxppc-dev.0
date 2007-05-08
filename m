Return-Path: <SRS0+d63ffb15e5103ff6c39b+1353+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A67C7DDE36
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 22:16:08 +1000 (EST)
Date: Tue, 8 May 2007 13:15:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH] ehea: Receive SKB Aggregation
Message-ID: <20070508121527.GA16763@infradead.org>
References: <200705081405.33742.osstklei@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705081405.33742.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 02:05:33PM +0200, Thomas Klein wrote:
> This patch enables the receive side processing to aggregate TCP packets within
> the HEA device driver. It analyses the packets already received after a
> interrupt arrived and forwards these as a chains of SKBs for the same TCP
> connection with modified header field. We have seen a lower CPU load and
> improved throughput for small numbers of parallel TCP connections.
> 
> We added a disabled module parameter to prevent disruption of normal driver
> operation.
> We currently consider this as "experimental" until further review and tests
> have been passed.
> 
> Are there any concerns about including this in the mainline driver?

So we grow yet another LRO copy in drivers?  I think someone needs to
bite the bullet and make it generic.
