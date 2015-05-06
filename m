Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95CD81A036D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 12:11:16 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 5 May 2015 22:11:13 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E9B866E804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 22:02:59 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t462BB7Q51642510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 02:11:11 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t462BAb5021434
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2015 22:11:11 -0400
Message-ID: <5549783B.4010605@linux.vnet.ibm.com>
Date: Tue, 05 May 2015 21:11:07 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.ocm>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: hibernation/migration should honor
 topology update policy
References: <1430848434-25793-1-git-send-email-tyreld@linux.vnet.ibm.ocm>
In-Reply-To: <1430848434-25793-1-git-send-email-tyreld@linux.vnet.ibm.ocm>
Content-Type: text/plain; charset=windows-1252
Cc: nacc@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2015 12:53 PM, Tyrel Datwyler wrote:
> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> 
> The suspend call paths for hibernation and migration operations call
> stop_topology_update() and start_topology_update() respectively prior to
> suspending the LPAR and upon resume. Topology updating can be
> enabled/disabled from userspace and no check is currently done to determine
> the current policy. This results in topology updates being started upon
> resume from hibernation/migration even in the case where topology updates
> were disabled initially.
> 
> This fixes the issue by storing the current policy and only calling
> start_topology_update() in the case where either PRRN/VPHN were enabled to
> start with.
> 
> Fixes: e04fa61214a3 (powerpc/pseries: Add /proc interface to control topology updates)
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
