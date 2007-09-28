Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE40FDDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 18:04:21 +1000 (EST)
Date: Fri, 28 Sep 2007 17:04:01 +0900 (JST)
Message-Id: <20070928.170401.-1300520897.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
In-Reply-To: <1190932629.6158.37.camel@pasglop>
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

> > It should have been set in setup_64.c, in setup_paca() (which is
called
> > twice) in that statement:
> > 
> > 	local_paca = &paca[cpu];
> > 
> > As local_paca is defined as being a variable held in register r13.
Maybe
> > something bad's happening with the compiler ?

> Can you check early_setup disassembly, see if r13 is assigned (it
should
> be in two spots) and if it's clobbered by the compiler somewhere ?

> Also, you may want to try adding --ffixed-r13 to the CFLAGS in the
> makefile and let us know if it makes a difference... r13 is marked
> reserved by the ABI but segher seems to imply that gcc may decide to
ues
> it anyway (ouch !)

I reviewed early_setup() disassembly sets r13 correctly. Now I found
the kernel works well without our hack, so I think I can decline the
patch [1/7].

Commit edd0622bd2e8f755c960827e15aa6908c3c5aa94 seems to break the
kernel and commit 175587cca7447daf5a13e4a53d32360ed8cba804 backs out
the symptom.  Calling slb_flush_and_rebolt() at slb_initialize()
function breaks the SLB table since it is called before setting up
PACA.

Thank you for your hint.

Best regards,
Kou Ishizaki
