Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E3F5DDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 05:12:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAQIC4Ar025830
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 13:12:04 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAQIBowV084008
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:11:52 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAQIBnqN021787
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:11:50 -0700
Date: Mon, 26 Nov 2007 12:11:49 -0600
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH] ehea: Add kdump support
Message-ID: <20071126181148.GF4551@austin.ibm.com>
References: <200711091433.51259.osstklei@de.ibm.com>
	<1196064988.19855.15.camel@concordia>
	<1196091697.7513.30.camel@luke-laptop.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196091697.7513.30.camel@luke-laptop.br.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Michael Neuling <mikey@neuling.org>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

On Mon, Nov 26, 2007 at 01:41:37PM -0200, Luke Browning wrote:
> On Mon, 2007-11-26 at 19:16 +1100, Michael Ellerman wrote:
> 
> > For kdump we have to assume that the kernel is fundamentally broken,

If I may so humbly suggest: since ehea is a power6 thing only,
we should refocus our energies on "hypervisor assisted dump",
which solves all of these problems. 

In short, upon crash, the hypervisor will reset the 
pci devices into working order, and will then boot
a new fresh kernel into a tiny corner of ram. The rest
of ram is not cleared, and can be dumped. After the 
dump, the mem is returned to general use.

The key point here, for ehea, is "the hypervisor
will reset he device state to something rational".

Preliminary patches are at
http://patchwork.ozlabs.org/linuxppc/patch?id=14884
and following.

--linas
