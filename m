Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A6C567BB1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 20:00:08 +1000 (EST)
Received: from exchange.cbl.local (exchange.cambridgebroadband.com
	[217.204.121.87])
	by cambridgebroadband.com (8.12.11.20060308/8.12.8) with ESMTP id
	k8QA02Ss011124
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Sep 2006 11:00:02 +0100
Message-ID: <4518FA21.8050801@cambridgebroadband.com>
Date: Tue, 26 Sep 2006 11:00:01 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: local_irq_save not masking interrupts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

I'm having a strange problem with interrupts.  My platform is the
MPC832xEMDS and the BSP I'm using (from Freescale) uses Linux-2.6.11.

In the code below I enter a critical section with local_irq_save(),
call request_irq() (from mpc832xemds_phy_interrupt_enable) 4 times,
then exit the critical section using local_irq_restore.

     /* Enable interrupts from PHYs */
     local_irq_save(flags);
     for (i = 0; i < driver_data->num_phys; i++) {
         struct atm_dev *dev = driver_data->dev_data[i]->dev;
         printk("%s/%d\n",__FUNCTION__,__LINE__);
         RETURN_ON_ERROR(mpc832xemds_phy_interrupt_enable(dev));
     }
     local_irq_restore(flags);

The problem is that I get an interrupt *before* exiting the critical
section.  This causes a problem for me, because the interrupts are
shared and the correct handler has not yet been registered, so the
interrupt never gets deasserted.

My question is: why is local_irq_save()/local_irq_restore() not
working?

TIA,

Alex
