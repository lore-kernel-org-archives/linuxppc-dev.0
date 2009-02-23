Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09ED5DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 00:29:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1NDQhGr024926
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 06:26:43 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1NDTEQc189752
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 06:29:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1NDTCWC000928
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 06:29:12 -0700
Subject: Re: [PATCH 2/2] Make sure we copy all cpu_spec features except PMC
	related ones
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <30c3ca265326d7aaa86cc75367d23739398a7b23.1235355941.git.michael@ellerman.id.au>
References: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
	<30c3ca265326d7aaa86cc75367d23739398a7b23.1235355941.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 23 Feb 2009 07:28:43 -0600
Message-Id: <1235395723.11996.1.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-02-23 at 13:25 +1100, Michael Ellerman wrote:
> When identify_cpu() is called a second time with a logical PVR, it
> only copies a subset of the cpu_spec fields so as to avoid overwriting
> the performance monitor fields that were initialized based on the
> real PVR.
> 
> However some of the other, non performance monitor related fields are
> also not copied:
>  * pvr_mask
>  * pvr_value
>  * mmu_features
>  * machine_check
> 
> The fact that pvr_mask is not copied can result in show_cpuinfo()
> showing the cpu as "unknown", if we override an unknown PVR with a
> logical one - as reported by Shaggy.
> 
> So change the logic to copy all fields, and then put back the PMC
> related ones in the case that we're overwriting a real PVR with a
> logical one.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

-- 
David Kleikamp
IBM Linux Technology Center
