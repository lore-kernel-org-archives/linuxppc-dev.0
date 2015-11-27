Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 089071A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:40:28 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 22:40:27 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2622119D803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:28:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5ePMp25755794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:40:25 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5ePJf027616
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:40:25 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/powernv: Add a kmsg_dumper that flushes
 console output on panic
In-Reply-To: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
References: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
Date: Fri, 27 Nov 2015 16:40:14 +1100
Message-ID: <m3oaegm24h.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:
> On BMC machines, console output is controlled by the OPAL firmware and is
> only flushed when its pollers are called.  When the kernel is in a panic
> state, it no longer calls these pollers and thus console output does not
> completely flush, causing some output from the panic to be lost.
>
> This patch adds a new kmsg_dumper which gets called at panic time to ensure
> panic output is not lost.  It accomplishes this by calling OPAL_CONSOLE_FLUSH
> in the OPAL API, and if that is not available, the pollers are called enough
> times to (hopefully) completely flush the buffer.

You may want to add to commit message that this depends on:
https://patchwork.ozlabs.org/patch/547379/

(which I'm about to go review)

Considering this does address an actual bug, should this go to stable@ ?

(Same question for the skiboot patch)
