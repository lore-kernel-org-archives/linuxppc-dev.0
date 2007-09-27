Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3DEADDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 21:22:27 +1000 (EST)
Date: Thu, 27 Sep 2007 20:22:07 +0900 (JST)
Message-Id: <20070927.202207.-1300525707.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
In-Reply-To: <1190881132.6158.4.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> On Thu, 2007-09-27 at 17:01 +0900, kou.ishizaki@toshiba.co.jp wrote:
>
> > Celleb does not set get_paca()->kstack properly (I don't know which
> > function should set it up), so we need to workaround.
>
> paca->kstack is set in asm (via the PACAKSAVE macro), from either
> __secondary_start for non-boot CPUs or from start_here_common for the
> boot CPU.
>
> slb_flush_and_rebolt() should not be called before that happens.
>
> How do you end up with kstack set to 0 ?

I found r13 is not set before entering start_here_common for boot cpu.
For non-boot threads, __secondary_start will set r13 properly.

So the problem is to set r13 correct PACA address before entering
start_here_common. Should it set before entering kernel or will some
patch make sense?

Best regards,
Kou Ishizaki
