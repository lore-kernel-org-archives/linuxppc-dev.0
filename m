Return-Path: <mikey@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] SLB shadow buffer 
In-reply-to: <1115481268674b0dc511.424238335.miltonm@bga.com> 
References: <1115481268674b0dc511.424238335.miltonm@bga.com>
Date: Sun, 06 Aug 2006 11:27:38 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060806012739.8CD2A679E7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, paulus@samba.org,
	anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The SLB shadow buffer is a pure software construct recording the required 
> segment translations.  Registering a the shadow buffer informs the 
> hypervisor which entries are required when switching partitions, and may 
> allow it to recover the partition from a hardware error. 

What Milton said.  It's a high availability feature.

We can register volatile and persistent SLBs with PHYP.  PHYP will
invalidate volatile entries and replace persistent entries if it sees a
problem with them.  

Here I've only registered the 3 persistent (bolted) SLBs, as the
volatile SLBs can be handled with SLB faults in the kernel.

Mikey
