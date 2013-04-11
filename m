Return-Path: <chris.friesen@genband.com>
Received: from exprod7og120.obsmtp.com (exprod7og120.obsmtp.com [64.18.2.18])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C8A82C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 08:38:46 +1000 (EST)
Message-ID: <51673B66.1090206@genband.com>
Date: Thu, 11 Apr 2013 16:38:30 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [BUG?]  possible bug in user_enable_block_step()
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

I'm looking at user_enable_block_step() in current kernels and it has 
the following:

#ifdef CONFIG_PPC_ADV_DEBUG_REGS
		task->thread.dbcr0 &= ~DBCR0_IC;
		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
		regs->msr |= MSR_DE;


Should it be as follows?

		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_BT;


If not, then what's the point of clearing the DBCR0_IC bit in the 
previous line?

Chris


-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
