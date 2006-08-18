Return-Path: <shemminger@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4047667B6F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 03:45:58 +1000 (EST)
Date: Fri, 18 Aug 2006 10:45:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
Message-ID: <20060818104547.5ad1352f@localhost.localdomain>
In-Reply-To: <44E5DFA6.7040707@de.ibm.com>
References: <200608181333.23031.ossthema@de.ibm.com>
	<20060818140506.GC5201@martell.zuzino.mipt.ru>
	<44E5DFA6.7040707@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Klein <tklein@de.ibm.com>, Marcus,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Eder <meder@de.ibm.com>,
	Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Aug 2006 17:41:26 +0200
Thomas Klein <osstklei@de.ibm.com> wrote:

> Hi Alexey,
> 
> first of all thanks a lot for the extensive review.
> 
> 
> Alexey Dobriyan wrote:
> >> +	u64 hret = H_HARDWARE;
> > 
> > Useless assignment here and everywhere.
> > 
> 
> Initializing returncodes to errorstate is a cheap way to prevent
> accidentally returning (uninitalized) success returncodes which
> can lead to catastrophic misbehaviour.

That is old thinking. Current compilers do live/dead analysis
and tell you about this at compile time which is better than relying
on default behavior at runtime.
