Return-Path: <holindho@cs.helsinki.fi>
Received: from fep34-app.kolumbus.fi (fep34-0.kolumbus.fi [193.229.0.43])
	by ozlabs.org (Postfix) with ESMTP id 14E036893F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2006 06:12:06 +1100 (EST)
Received: from [192.168.1.4] (really [80.186.59.4])
	by fep32-app.kolumbus.fi with ESMTP
	id <20060104183626.HDTM3516.fep32-app.kolumbus.fi@[192.168.1.4]>
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jan 2006 20:36:26 +0200
Message-ID: <43BC15A9.7010009@cs.helsinki.fi>
Date: Wed, 04 Jan 2006 20:36:25 +0200
From: Heikki Lindholm <holindho@cs.helsinki.fi>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: restore_user_regs and fpu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I haven't really confirmed this can happen, but I was wondering whether 
the following would be possible. Looking at restore_user_regs in 
ppc/kernel/signal_32.c and assuming:
* last_task_used_math == current, eg. a signal handler used fpu
* fpu state is still what the sig handler left there
If after the fpu state is restored to current->thread.fpr (copy_user) 
somebody preempts this task and uses fpu, wouldn't it cause the fpu 
state (of the sig handler) to be saved to 
last_task_used_math->thread.fpr overwriting the just restored state. 
Should the last_task_used_math nullifying, etc. be moved to the front of 
the function instead, or am I overlooking something?

-- Heikki Lindholm
