Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 499371A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 23:54:24 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C25E1400DE
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 23:54:23 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 18:24:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 11C1E1258056
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 18:25:56 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2RCsGRP42532970
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 18:24:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2RCj3s3032376
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 18:15:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Remove powernv RTAS support
In-Reply-To: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
References: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 27 Mar 2015 18:24:08 +0530
Message-ID: <87k2y24n4f.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The powernv code has some conditional support for running on bare metal
> machines that have no OPAL firmware, but provide RTAS.
>
> No released machines ever supported that, and even in the lab it was
> just a transitional hack in the days when OPAL was still being
> developed.
>
> So remove the code.

So when we select CONFIG_PPC_PSERIES, we end up selecting
CONFIG_PPC_RTAS. What is the expected behaviour there for powernv ? Can
we use RTAS call from powernv code if rtas node is present in device
tree ? Or do we want to make sure powernv always use OPAL call ?

For example, right now we will use rtas_node get-term-char and
put-term-char even with this patch applied.

-aneesh
