Return-Path: <kniht@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67856DE394
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 03:07:24 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4DH7M8J018785
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 13:07:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4DH7IXC241718
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 13:07:18 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4DH7E0f012966
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:07:15 -0600
Message-ID: <4829CAC3.30900@us.ibm.com>
Date: Tue, 13 May 2008 12:07:15 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/6] 16G and multi size hugetlb page support on powerpc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nick Piggin <npiggin@suse.de>, Nishanth Aravamudan <nacc@us.ibm.com>,
	Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch set builds on Nick Piggin's patches for multi size and giant 
hugetlb page support of April 22.  The following set of patches adds 
support for 16G huge pages on ppc64 and support for multiple huge page 
sizes at the same time on ppc64.  Thus allowing 64K, 16M, and 16G huge 
pages given a POWER5+ or later machine.

New to this version of my patch is numerous bug fixes and cleanups, but 
the biggest change is the support for multiple huge page sizes on power.

patch 1: changes to generic hugetlb to enable 16G pages on power
patch 2: powerpc: adds function for allocating 16G pages
patch 3: powerpc: setups 16G page locations found in device tree
patch 4: powerpc: page definition support for 16G pages
patch 5: check for overflow when user space is 32bit
patch 6: powerpc: multiple huge page size support

Jon
