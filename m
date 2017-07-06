Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3LYm4Hp4zDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 01:02:04 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so620618pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 08:02:04 -0700 (PDT)
Date: Fri, 7 Jul 2017 01:01:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] powernv:idle: Change return type of
 pnv_probe_idle_states to int
Message-ID: <20170707010149.7526c784@roar.ozlabs.ibm.com>
In-Reply-To: <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  5 Jul 2017 22:08:13 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In the current idle initialization code, if there are failures in
> pnv_probe_idle_states, then no platform idle state is
> enabled. However, since the error is not propagated to the top-level
> function pnv_init_idle_states, we continue initialization in this
> top-level function even though this will never be used.
> 
> Hence change the the return type of pnv_probe_idle_states from void to
> int and in case of failures, bail out early on in
> pnv_init_idle_states.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I wonder if the warnings are strong enough here to let people know
idle won't be used so power consumption will be high and performance
significantly reduced on SMT machines?
