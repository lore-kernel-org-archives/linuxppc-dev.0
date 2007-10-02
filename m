Return-Path: <pbadari@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27A9BDDF4F
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 06:34:13 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l92KYADR031643
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 16:34:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92KYAej418234
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 14:34:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92KY9YN001885
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 14:34:10 -0600
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4702A5FE.5000308@am.sony.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<4702A5FE.5000308@am.sony.com>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 13:37:15 -0700
Message-Id: <1191357435.6106.31.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-02 at 13:11 -0700, Geoff Levand wrote:
> Hi Badari,
> 
> Badari Pulavarty wrote:
> > Hi Paul & Ben,
> > 
> > I am trying to get hotplug memory remove working on ppc64.
> > In order to verify a given memory region, if its valid or not -
> > current hotplug-memory patches used /proc/iomem. On IA64 and
> > x86-64 /proc/iomem shows all memory regions. 
> > 
> > I am wondering, if its acceptable to do the same on ppc64 also ?
> > Otherwise, we need to add arch-specific hooks in hotplug-remove
> > code to be able to do this.
> 
> 
> It seems the only reasonable place is in /proc/iomem, as the the 
> generic memory hotplug routines put it in there, and if you have
> a ppc64 system that uses add_memory() you will have mem info in
> several places, none of which are complete.  

Well, this information exists in various places (lmb structures
in the kernel), /proc/device-tree for various users. I want to
find out what ppc experts think about making this available through
/proc/iomem also since generic memory hotplug routines expect 
it there.

Other option would be to provide arch-specific call out. Each
arch could decide to implement whatever way they want to verify 
the range.

Thanks,
Badari
