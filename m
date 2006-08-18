Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 3AC6167B5F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 00:33:40 +1000 (EST)
Date: Fri, 18 Aug 2006 16:33:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Message-ID: <20060818143328.GC6393@wohnheim.fh-wedel.de>
References: <200608181331.19501.ossthema@de.ibm.com>
	<1155903451.4494.168.camel@laptopd505.fenrus.org>
	<44E5BFB7.4000400@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <44E5BFB7.4000400@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 August 2006 15:25:11 +0200, Thomas Klein wrote:
> Arjan van de Ven wrote:
> >>+	queue->queue_length = nr_of_pages * pagesize;
> >>+	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
> >
> >
> >wow... is this really so large that it warrants a vmalloc()???
> 
> Agreed: Replaced with kmalloc()

kzalloc() and you can remove the memset() as well.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
