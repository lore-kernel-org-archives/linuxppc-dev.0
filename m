Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57004B70F6
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 01:21:42 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SF2aB2003434
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 11:02:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SFLdKc385416
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 11:21:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8SFLapb011105
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 12:21:38 -0300
Subject: Re: [PATCH 6/8] v2 Update node sysfs code
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Robin Holt <holt@sgi.com>
In-Reply-To: <20100928092919.GF14068@sgi.com>
References: <4CA0EBEB.1030204@austin.ibm.com>
	<4CA0F00D.9000702@austin.ibm.com>  <20100928092919.GF14068@sgi.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 28 Sep 2010 08:21:33 -0700
Message-ID: <1285687293.19976.6172.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-09-28 at 04:29 -0500, Robin Holt wrote:
> Also, I don't think I much care for the weirdness that occurs if a
> memory block spans two nodes.  I have not thought through how possible
> (or likely) this is, but the code certainly permits it.  If that were
> the case, how would we know which sections need to be taken offline,
> etc? 

Since the architecture is the one doing the memory_block_size_bytes()
override, I'd expect that the per-arch code knows enough to ensure that
this doesn't happen.  It's probably something to add to the
documentation or the patch descriptions.  "How should an architecture
define this?  When should it be overridden?"

It's just like the question of SECTION_SIZE.  What if a section spans a
node?  Well, they don't because the sections are a software concept and
we _define_ them to not be able to cross nodes.  If they do, just make
them smaller.

-- Dave
