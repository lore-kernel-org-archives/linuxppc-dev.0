Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5DF53DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 16:40:20 +1100 (EST)
Date: Mon, 17 Nov 2008 21:40:18 -0800 (PST)
Message-Id: <20081117.214018.238557661.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: Large stack usage in fs code (especially for PPC64)
From: David Miller <davem@davemloft.net>
In-Reply-To: <18722.10784.719186.434130@cargo.ozlabs.ibm.com>
References: <alpine.DEB.1.10.0811171557370.26123@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811172128380.26123@gandalf.stny.rr.com>
	<18722.10784.719186.434130@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 18 Nov 2008 13:36:16 +1100

> Steven Rostedt writes:
> 
> > By-the-way, my box has been running stable ever since I switched to 
> > CONFIG_IRQSTACKS.
> 
> Great.  We probably should remove the config option and just always
> use irq stacks.

That's what I did from the start on sparc64 when I added
irqstacks support.  It's pretty stupid to make it optional
when we know there are failure cases.

For example, is XFS dependant on IRQSTACKS on x86?  It should be, or
even more so XFS and NFS both being enabled at the same time :-)
