Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5CC5BDDE30
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 23:39:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCh v3] powerpc: add hugepagesz boot-time parameter
Date: Mon, 7 Jan 2008 13:37:56 +0100
References: <477D68E6.2070108@linux.vnet.ibm.com>
	<200801040034.25329.arnd@arndb.de>
	<20080107120410.GB29254@csn.ul.ie>
In-Reply-To: <20080107120410.GB29254@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801071337.59877.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	csnook@redhat.com, Paul Mackerras <paulus@samba.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 January 2008, Mel Gorman wrote:
> 
> > We started discussing this in v1, but the discussion got sidetracked:
> > Is there a technical reason why you don't also allow 1M pages, which
> > may be useful in certain scenarios?
> > 
> 
> I cannot see why not although the ideal would be that the necessary
> information to support the pagesize would be provided by the firmware
> instead of hard-coded values.
> 
> > On the Cell/B.E. platforms (IBM/Mercury blades, Toshiba Celleb, PS3), the
> > second large page size is an option that can be set in a HID SPR
> > to either 64KB or 1MB. Unfortunately, we can't do these two simultaneously,
> > but the firmware can change the default and put it into the device tree,
> > or you could have the kernel override the firmware settings.

The problem with the firmware choosing the page size is that it has much
less of an idea about what the user wants to do than the kernel.
It's not exclusive however. We can first teach the kernel to deal
with firmware setting the 1MB or 1GB page size, and later implement
changing the HW setting from the kernel.

	Arnd <><
