Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5FB2DDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:39:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l34Hcv48013477
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 13:38:57 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l34HcvKM157890
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 11:38:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l34HcuRO030542
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 11:38:57 -0600
Date: Wed, 4 Apr 2007 12:38:56 -0500
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404173856.GU4922@austin.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
	<20070404162234.GS4922@austin.ibm.com>
	<1175704494.2774.33.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175704494.2774.33.camel@shinybook.infradead.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 12:34:53PM -0400, David Woodhouse wrote:
> On Wed, 2007-04-04 at 11:22 -0500, Linas Vepstas wrote:
> > The biggest problem would seem to be that the assignment would
> > depend on the detection order; there don't seem to be unique 
> > id's that would help udev consistently assign device names in 
> > consistent order. 
> 
> Of course there are. The different types of ports have different device
> numbers. As long as we don't do anything silly like putting all the
> serial drivers on the same major number, we can tell them apart
> relatively well.

Sure, but if two different pci serial cards are moved around  
to different pci slots, they'll be detected in a different order. 
Similarly if one has some usb-to-serial converter that might get
plugged in after boot, or maybe some serial port that shows up
only when a laptop is docked into a docking station.

--linas
