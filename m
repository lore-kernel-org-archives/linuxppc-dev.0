Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn1lV70yyzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 03:35:34 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n11so6691018pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 09:35:34 -0700 (PDT)
Date: Tue, 21 Mar 2017 02:35:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/4] powernv: Move CPU-Offline idle state invocation
 from smp.c to idle.c
Message-ID: <20170321023517.4cb27add@roar.ozlabs.ibm.com>
In-Reply-To: <358fc68275a4986d2e112418aea447f49f644f7e.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <358fc68275a4986d2e112418aea447f49f644f7e.1490024477.git.ego@linux.vnet.ibm.com>
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

On Mon, 20 Mar 2017 21:24:15 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Move the piece of code in powernv/smp.c::pnv_smp_cpu_kill_self() which
> transitions the CPU to the deepest available platform idle state to a
> new function named pnv_cpu_offline() in powernv/idle.c. The rationale
> behind this code movement is that the data required to determine the
> deepest available platform state resides in powernv/idle.c.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Looks good. As a nitpick, possibly one or two variables in idle.c could
become static (pnv_deepest_stop_psscr_*).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
