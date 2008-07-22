Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A64DDE12D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 23:28:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MDSHMG026091
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 09:28:17 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MDSGYN110642
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 07:28:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MDSGKI008807
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 07:28:16 -0600
Date: Tue, 22 Jul 2008 08:28:17 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/16 v3] powerpc: iommu enablement for CMO
Message-ID: <20080722132816.GC5650@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125459.GM1310@linux.vnet.ibm.com>
	<18565.26804.757649.584391@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18565.26804.757649.584391@cargo.ozlabs.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Paul Mackerras (paulus@samba.org) wrote:
> Robert Jennings writes:
> 
> > To support Cooperative Memory Overcommitment (CMO), we need to check
> > for failure from some of the tce hcalls.
> 
> This patch runs into context mismatches because of changes made by
> Michael Ellerman's patch "Fix sparse warnings in
> arch/powerpc/platforms/pseries" (now in Linus' tree), which changed
> code like
> 
> 	if (condition)
> 		return function_returning_void(args);
> 
> into
> 
> 	if (condition) {
> 		function_returning_void(args);
> 		return;
> 	}
> 
> which will cause problems for your patch.  Please check if any of
> these changes need to be undone again.

I do need to revert those changes, the return values will no longer be
void.  I'll get those tested and posted.  Thanks.

--Rob Jennings
