Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B4A0BDE1FC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 09:17:16 +1000 (EST)
Date: Thu, 16 Apr 2009 16:17:06 -0700 (PDT)
Message-Id: <20090416.161706.69866211.davem@davemloft.net>
To: schwab@linux-m68k.org
Subject: Re: ppc32: Don't clobber personality flags on exec
From: David Miller <davem@davemloft.net>
In-Reply-To: <m27i1k8t7a.fsf@igel.home>
References: <m27i1k8t7a.fsf@igel.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 16 Apr 2009 18:22:01 +0200

> Now that ppc32 implements address randomization it also wants to inherit
> personality flags like ADDR_NO_RANDOMIZE across exec, for things like
> `setarch ppc -R' to work.  But the ppc32 version of SET_PERSONALITY
> forcefully sets PER_LINUX, clearing all personality flags.  So be
> careful about preserving the flags.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Grumble, sparc has the same bugs...  thanks for finding this.
