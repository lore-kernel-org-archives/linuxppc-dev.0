Return-Path: <haveblue@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D84CA67CA2
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 11:09:45 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3D19gw8000819
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 21:09:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3D16CYY224458
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 19:06:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3D19fLj014173
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 19:09:42 -0600
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
In-Reply-To: <200604130257.00203.ak@suse.de>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<200604130153.08604.ak@suse.de>
	<Pine.LNX.4.64.0604130058210.18950@skynet.skynet.ie>
	<200604130257.00203.ak@suse.de>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 18:08:48 -0700
Message-Id: <1144890528.31255.97.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: davej@codemonkey.org.uk, tony.luck@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bob.picco@hp.com, linuxppc-dev@ozlabs.org, Mel Gorman <mel@skynet.ie>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-13 at 02:56 +0200, Andi Kleen wrote:
> The problem is not memory consumption but complexity of code/data structures.
> Keeping information in two places is usually a good cue that something 
> is wrong. This code is also fragile and hard to test. 

Part of the motivation for these patches is that we really duplicate a
lot of functionality across architectures.  For instance, on x86, we
have limit_regions() to fiddle with the e820 or efi tables to make them
look right after a mem= on the command-line.

We end up doing the same kind of fiddling on powerpc, but on LMBs,
instead.  This code is error-prone, and every one of these
implementations gets it wrong.  I believe I've seen and fixed bugs in at
least two of them.  Add in NUMA things or hotplug boot-time zone sizing,
and you get an even worse mess. 

The motivation for Mel's patches is to keep the architectures from
getting it wrong.  If we let them do it themselves, they _will_ get it
wrong, and any bugfixes will not help anybody else.

If we do it in common code, we will certainly have bugs for a while.  By
sharing code, we narrow the bugs down to one place, and only have to fix
them once.

-- Dave "guy who hates the same bugs in many arches" Hansen
