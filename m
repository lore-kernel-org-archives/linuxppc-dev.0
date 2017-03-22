Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwD64YZmzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:29:58 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id w20so3288231pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 20:29:58 -0700 (PDT)
Date: Wed, 22 Mar 2017 13:29:34 +1000
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
Subject: Re: [v2 PATCH 4/4] powernv: Recover correct PACA on wakeup from a
 stop on P9 DD1
Message-ID: <20170322132934.12ca83c4@roar.ozlabs.ibm.com>
In-Reply-To: <20170321025946.3c0b68c5@roar.ozlabs.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <5beb1c3fb26ef0b487be3aa0488ea31aabfcb311.1490024477.git.ego@linux.vnet.ibm.com>
 <20170321025946.3c0b68c5@roar.ozlabs.ibm.com>
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

On Tue, 21 Mar 2017 02:59:46 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Mon, 20 Mar 2017 21:24:18 +0530

> This is quite neat now you've moved it to its own function. Nice.
> It will be only a trivial clash with my patches now, I think.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Hmm... This won't actually work for machine check wakeups either.

We're doing the low level machine check before checking for wakeup,
which complicates things a little bit.

Simplest way to handle that might be to just always immediately
call the restore paca function at machine check entry, and then
just always mark machine checks as not-recoverable for DD1.

Thanks,
Nick
