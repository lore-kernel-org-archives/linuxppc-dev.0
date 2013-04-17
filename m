Return-Path: <chris.friesen@genband.com>
Received: from exprod7og129.obsmtp.com (exprod7og129.obsmtp.com [64.18.2.122])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02BD22C0158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 04:44:57 +1000 (EST)
Message-ID: <516EED8D.3040304@genband.com>
Date: Wed, 17 Apr 2013 12:44:29 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: questions around Book III-E and branch trace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to wrap my head around how linux handles branch tracing on 
Book III-E.  I think I understand how we set MSR[DE] and DBCR0[IDM|BT], 
and how we handle fixing things up if an instruction being traced causes 
an exception.

I have a few questions though:

1) Does user_enable_block_step() have a bug in it?  The current code has

task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;

Should that be as follows (to match the singel-step case)?

task->thread.dbcr0 |= DBCR0_IDM | DBCR0_BT;


2) Why doesn't DBCR0_ACTIVE_EVENTS include DBCR0_BT?


3) In sys_debug_setcontext() why does SIG_DBG_BRANCH_TRACING return 
-EINVAL if CONFIG_PPC_ADV_DEBUG_REGS is set?  Would it not be possible 
to use DBCR0_BT?

Thanks,
Chris


-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
