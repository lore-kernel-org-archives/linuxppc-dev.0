Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F6C8DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 00:55:18 +1100 (EST)
Message-Id: <B21B7D6E-3991-422F-A4BC-ABA8423D9F90@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
In-Reply-To: <20081105123715.GA29574@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Rebooting the mpc8544
Date: Wed, 5 Nov 2008 07:55:02 -0600
References: <20081105123715.GA29574@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 6:37 AM, Sebastian Andrzej Siewior wrote:

> I'm trying to reboot the mpc8544 and pass the reason of the reboot  
> (two
> bits would be enough). I've been told the a PowerPC cpu has usually a
> few registers which will survive a soft reset.
> The "normal" reboot is done via the HRESET_REQ line which is handeled
> by externel HW and does a power cycle.
> The e500 watchdog also uses the HRESET_REQ line.
> Other way would be use the Debug Control Register 0 (DBCR0) and set  
> the
> reset bit. The manual says here that it does a hard reset so none of
> my registers will survive, right? There is a Most recent reset (MRR)  
> bit
> in the Debug Status Register (DBSR) but that one should be always set
> since the last reset was a hard reset.
> Right now I'm thinking about stealing a page and put the information
> there since the memory controller isn't re-initialized.
> Does someone have a better idea?

The issue w/DBCR0 is it only resets the core and not the reset of the  
SoC.  So you can still have IO transactions in flight, etc.. you have  
to ensure you quiesce all these things to handle it properly.

- k
