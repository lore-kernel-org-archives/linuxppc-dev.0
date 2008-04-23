Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C330DE268
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 04:27:08 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3NIR408017597
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 13:27:04 -0500
Mime-Version: 1.0 (Apple Message framework v623)
In-Reply-To: <2fcdb6beb2e205a397a1928c2c2c4b1e3360b09e.1208962154.git.segher@kernel.crashing.org>
References: <2fcdb6beb2e205a397a1928c2c2c4b1e3360b09e.1208962154.git.segher@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <13e9f2da3e71dd8fb3849649c44f542a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Don't play type punning games with lock_token
Date: Wed, 23 Apr 2008 20:27:02 +0200
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The two u16 fields lock_token and paca_index in struct paca_struct are
> accessed as one u32 field via type punning.  Change this into one u32
> field paca_id, and add a paca_get_index() function to access only the
> low 16 bits of this.
>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/asm-offsets.c          |    2 +-
>  arch/powerpc/kernel/paca.c                 |    3 +--
>  arch/powerpc/platforms/iseries/exception.S |    2 +-
>  include/asm-powerpc/iseries/hv_call.h      |    2 +-
>  include/asm-powerpc/paca.h                 |   18 ++++++++++++------
>  include/asm-powerpc/smp.h                  |    2 +-
>  include/asm-powerpc/spinlock.h             |    2 +-
>  7 files changed, 18 insertions(+), 13 deletions(-)

It doesn't apply cleanly anymore, will redo once the dust settles
a bit.


Segher
