Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E04F1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:24:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 13:24:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E87672CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:24:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8G3OC3W27721762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:24:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8G3Noti002410
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:23:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Recompute hash value after a failed update
In-Reply-To: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 16 Sep 2015 08:53:31 +0530
Message-ID: <87vbbbdp3g.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> If we had secondary hash flag set, we ended up modifying hash value in
> the updatepp code path. Hence with a failed updatepp we will be using
> a wrong hash value for the following hash insert. Fix this by
> recomputing hash before insert.

Without this patch we can end up with using wrong slot number in linux
pte. That can result in us missing an hash pte update or invalidate
which can cause memory corruption or even machine check ?

-aneesh
