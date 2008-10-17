Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 29128DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 16:37:18 +1100 (EST)
Message-ID: <48F82481.8070201@nortel.com>
Date: Thu, 16 Oct 2008 23:37:05 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
In-Reply-To: <20081016181452.GA29739@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

 > Are these two merged yet?  I just spent the better part of the morning
 > trying to figure out why various Fedora kernels based on 2.6.27-rcX and
 > 2.6.27 final hung on my G5 and finally got one booting with FTRACE
 > disabled.

Until recently I could boot my G5 with FTRACE enabled, but it totally screwed 
up load balancing.

As of a couple days ago, -tip hung on boot due to the following genirq 
issue:


diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 570d1ea..1c178ae 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -132,7 +132,7 @@ int set_irq_type(unsigned int irq, unsigned int type)
    		return 0;

    	spin_lock_irqsave(&desc->lock, flags);
-	ret = __irq_set_trigger(desc, irq, flags);
+	ret = __irq_set_trigger(desc, irq, type);
    	spin_unlock_irqrestore(&desc->lock, flags);
    	return ret;
    }



Chris
