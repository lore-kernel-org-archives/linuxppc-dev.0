Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 74ABADE05E
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 22:33:17 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so362658ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 05:33:15 -0700 (PDT)
Message-ID: <485F9806.1000408@genesi-usa.com>
Date: Mon, 23 Jun 2008 13:33:10 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: rh_init exported twice (rheap vs. dm-region_hash)
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I keep getting export errors when building kernels, a conflict between
arch/powerpc/lib/rheap.c:rh_init() and drivers/dm/dm-region_hash.c:rh_init()

- in the event you want to use BestComm, MPC8610 DIU or other features
*and* a RAID algorithm, which subsystem would be best to patch away or
patch in a fix?

I was thinking of renaming the dm hash one to rh_hash_init() and then I
thought, maybe rh_heap_init() is better. Then I thought, why have rh in
both places, why not rename the entire API (rheap_ and rhash_) in both
cases?

What do you think is the best solution? Willing to hack and compile test
just so my kernel builds are "cleaner"..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
