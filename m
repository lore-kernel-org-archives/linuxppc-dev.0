Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0E7DB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:10:15 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23816DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:10:14 +1000 (EST)
Message-Id: <DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Linux-Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: spin_is_locked() broken for uniprocessor?
Date: Tue, 18 Aug 2009 17:09:56 -0500
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I just want to validate that what I'm seeing (for UP, non-debug  
features):

spin_is_locked() is defined as:

include/linux/spinlock.h:#define spin_is_locked(lock)    
__raw_spin_is_locked(&(lock)->raw_lock)

for UP that should get us:

include/linux/spinlock_up.h:#define __raw_spin_is_locked(lock)  ((void) 
(lock), 0)

which implies to me that spin_is_locked() will always return false.   
Is this expected behavior.

- k
