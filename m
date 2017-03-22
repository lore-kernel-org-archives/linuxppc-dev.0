Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpF1H2dNQzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 03:06:43 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id w20so6368340pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 09:06:43 -0700 (PDT)
Date: Thu, 23 Mar 2017 02:06:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 4/4] powernv: Recover correct PACA on wakeup from a
 stop on P9 DD1
Message-ID: <20170323020628.56b40eed@roar.ozlabs.ibm.com>
In-Reply-To: <2387240280c6445bd22ee9be621997b6f951ef3d.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
 <2387240280c6445bd22ee9be621997b6f951ef3d.1490194710.git.ego@linux.vnet.ibm.com>
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

On Wed, 22 Mar 2017 20:34:17 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> POWER9 DD1.0 hardware has an issue due to which the SPRs of a thread
> waking up from stop 0,1,2 with ESL=1 can endup being misplaced in the
> core. Thus the HSPRG0 of a thread waking up from can contain the paca
> pointer of its sibling.
> 
> This patch implements a context recovery framework within threads of a
> core, by provisioning space in paca_struct for saving every sibling
> threads's paca pointers. Basically, we should be able to arrive at the
> right paca pointer from any of the thread's existing paca pointer.
> 
> At bootup, during powernv idle-init, we save the paca address of every
> CPU in each one its siblings paca_struct in the slot corresponding to
> this CPU's index in the core.
> 
> On wakeup from a stop, the thread will determine its index in the core
> from the TIR register and recover its PACA pointer by indexing into
> the correct slot in the provisioned space in the current PACA.
> 
> Furthermore, ensure that the NVGPRs are restored from the stack on the
> way out by setting the NAPSTATELOST in paca.
> 
> [Changelog written with inputs from svaidy@linux.vnet.ibm.com]

Looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
