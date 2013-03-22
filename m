Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04F792C00BF
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:56:56 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 22 Mar 2013 21:24:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3F4F21258023
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2013 21:28:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MFukp71769820
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Mar 2013 21:26:47 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MFumWh005502
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2013 02:56:49 +1100
Date: Fri, 22 Mar 2013 21:26:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG][PATCH] powerpc: fix numa distance for form0 device tree
Message-ID: <20130322155644.GB26283@dirshya.in.ibm.com>
References: <20130322154935.GA26283@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130322154935.GA26283@dirshya.in.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2013-03-22 21:19:35]:

[snip]

>     Prior to the above commit:
>     #define node_distance(from,to)
>     	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
>     
>     Restoring compatible behavior with this patch for old powerpc systems
>     with device tree where numa distance are encoded as form0.

This patch on v3.9-rc3 has been tested on multi-node POWER7 with
different device tree combinations.

numactl -H would show local distance '10' for same node and remote
distance '20' for other nodes.  This ensures NUMA level sched domain
gets built and load balancing could work across such configurations.

--Vaidy
