Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6p5lmfzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:54 +1100 (AEDT)
In-Reply-To: <1488174007-8732-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2] powernv:idle: Fix bug due to labeling ambiguity in
 power_enter_stop
Message-Id: <3vdQ6p4LMRz9sNG@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-27 at 05:40:07 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Commit 09206b600c76 ("powernv: Pass PSSCR value and mask to
> power9_idle_stop") added additional code in power_enter_stop() to
> distinguish between stop requests whose PSSCR had ESL=EC=1 from those
> which did not. When ESL=EC=1, we do a forward-jump to a location
> labelled by "1", which had the code to handle the ESL=EC=1 case.
> 
> Unforunately just a couple of instructions before this label, is the
> macro IDLE_STATE_ENTER_SEQ() which also has a label "1" in its
> expansion.
> 
> As a result, the current code can result in directly executing stop
> instruction for deep stop requests with PSSCR ESL=EC=1, without saving
> the hypervisor state.
> 
> Fix this BUG by labeling the location that handles ESL=EC=1 case with
> a more descriptive label ".Lhandle_esl_ec_set" (local label suggestion
> a la .Lxx from Anton Blanchard).
> 
> While at it, rename the label "2" labelling the location of the code
> handling entry into deep stop states with ".Lhandle_deep_stop".
> 
> For a good measure, change the label in IDLE_STATE_ENTER_SEQ() macro
> to an not-so commonly used value in order to avoid similar mishaps in
> the future.
> 
> Fixes: 09206b600c76 ("powernv: Pass PSSCR value and mask to
> power9_idle_stop")
> 
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/424f8acd328a111319ae30bf384e5d

cheers
