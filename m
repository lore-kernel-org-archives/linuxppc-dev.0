Return-Path: <haveblue@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D5B167A45
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:40:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LIe6G2000413
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:40:06 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2LIh3aq172032
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 11:43:04 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2LIe2dR001961
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 11:40:03 -0700
Subject: Re: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
From: Dave Hansen <haveblue@us.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
In-Reply-To: <11429014352189-git-send-email-nathanl@austin.ibm.com>
References: <11429014352189-git-send-email-nathanl@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:38:37 -0800
Message-Id: <1142966317.10906.172.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-03-20 at 18:37 -0600, Nathan Lynch wrote:
> +       cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> +                         (void *)(unsigned long)boot_cpuid); 

That double-cast really caught my eye.  cpu_numa_callback() looks a
little bit confused about what type cpuids should be.

Its lcpu is an "unsigned long", but it has integers passed into it
(boot_cpuid), and calls map_cpu_to_node(lcpu, 0), where the first
argument is an integer, but an "unsigned long" is passed in.  This may
be harmless, but I still have to think about it, which is bad.

Seems like just making cpu_numa_callback()'s lcpu an int would get rid
of at least one net cast.  Why not just pass &boot_cpuid in there, and
do this:

	int lcpu = *(int *)hcpu;

That makes it _really_ obvious what is going on.  While it isn't
horribly uncommon to pass integers around inside of void*s, it can be a
bit confusing.  You also get readability issues with long<->int
conversions as you saw.

By the way, what do the "l" and "h" in front of "cpu" mean anyway?

-- Dave
