Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F2631A006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:33:55 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 16:33:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8C7903578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:33:52 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A6XeSD47775890
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:33:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A6XJRv031804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:33:20 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 03/18] cxl: Define process problem state area at attach
 time only
In-reply-to: <1454765345-7417-4-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-4-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 17:32:54 +1100
Message-Id: <1455085746-sup-9303@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-02-07 00:28:50 +1100:
> Cxl kernel API was defining the process problem state area during
> context initialization, making it possible to map the problem state
> area before attaching the context. This won't work on a powerVM
> guest. So do the logical thing, like in userspace: attach first, then
> map the problem state area.
> Remove calls to cxl_assign_psn_space during init. The function is
> already called on the attach paths.

Looks good.

It might be a reasonable idea to make cxl_psa_map fail outright if it is
called on a context that has not been attached yet like we do in the
user api, but I trust kernel devs to get this right more than userspace
so I'm not too worried :)

Cheers,
-Ian
