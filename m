Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B209867BFF
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 23:47:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IDln1f004397
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:47:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IDlm3K290228
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:47:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IDlmFp002972
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:47:48 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Fri, 18 Aug 2006 15:47:46 +0200
References: <200608181331.19501.ossthema@de.ibm.com>
	<1155903451.4494.168.camel@laptopd505.fenrus.org>
	<44E5BFB7.4000400@de.ibm.com>
In-Reply-To: <44E5BFB7.4000400@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608181547.47081.arnd.bergmann@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 August 2006 15:25, Thomas Klein wrote:
> 
> > wow... is this really so large that it warrants a vmalloc()???
> 
> Agreed: Replaced with kmalloc()

My understanding from the previous discussion was that it actually
is a multi-page power of two allocation, so the right choice might
be __get_free_pages() instead of kmalloc, but it probably doesn't
make much of a difference.

You should really do some measurements to see what the minimal
queue sizes are that can get you optimal throughput.

	Arnd <><
