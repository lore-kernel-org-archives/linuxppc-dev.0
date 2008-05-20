Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1ED74DDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:22:21 +1000 (EST)
Date: Mon, 19 May 2008 19:22:15 -0700 (PDT)
Message-Id: <20080519.192215.193701293.davem@davemloft.net>
To: geoffrey.levand@am.sony.com
Subject: Re: [patch v2] LMB: Add basic spin locking to lmb
From: David Miller <davem@davemloft.net>
In-Reply-To: <48322191.6060909@am.sony.com>
References: <20080515.000203.225783838.davem@davemloft.net>
	<48321DF9.6060807@am.sony.com> <48322191.6060909@am.sony.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>
Date: Mon, 19 May 2008 17:55:45 -0700

> Add a spinlock to struct lmb to enforce concurrency in
> lmb_add(), lmb_remove(), lmb_analyze(), lmb_find(), and
> lmb_dump_all().
> 
> This locking is needed for SMP systems that access the lmb structure
> during hot memory add and remove operations after secondary cpus
> have been started.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> 
> v2: o Add locking to lmb_find().

I'm not against this patch, but I'm pretty sure it's not
necessary.  Isn't memory hotplug already synchronized at
a higher level?

If not, it should be.
