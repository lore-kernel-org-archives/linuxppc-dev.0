Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 157D2DE16B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 15:29:04 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 15:23:01 +1000
Message-Id: <1219209781.21386.25.camel@pasglop>
Mime-Version: 1.0
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW. It would be good to try to turn the GFP_ATOMIC into GFP_KERNEL,
maybe using a semaphore instead of a lock to protect insertion vs.
initialisation. The old scheme was fine because if the atomic allocation
failed, it could fallback to the linear search and try again on the next
interrupt. Not anymore.

Ben.
