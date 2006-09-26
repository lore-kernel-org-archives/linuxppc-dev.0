Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D1B867A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 20:28:07 +1000 (EST)
Message-ID: <451900B0.7010006@cambridgebroadband.com>
Date: Tue, 26 Sep 2006 11:28:00 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Liu Dave-r63238 wrote:
> <snip>
>> I'm having a strange problem with interrupts.  My platform is 
>> the MPC832xEMDS and the BSP I'm using (from Freescale) uses 
>> Linux-2.6.11.
>>
>> In the code below I enter a critical section with 
>> local_irq_save(), call request_irq() (from 
>> mpc832xemds_phy_interrupt_enable) 4 times, then exit the 
>> critical section using local_irq_restore.
>>
>>      /* Enable interrupts from PHYs */
>>      local_irq_save(flags);
>>      for (i = 0; i < driver_data->num_phys; i++) {
>>          struct atm_dev *dev = driver_data->dev_data[i]->dev;
>>          printk("%s/%d\n",__FUNCTION__,__LINE__);
>>          RETURN_ON_ERROR(mpc832xemds_phy_interrupt_enable(dev));
>>      }
>>      local_irq_restore(flags);
>>
>> The problem is that I get an interrupt *before* exiting the 
>> critical section.  This causes a problem for me, because the 
>> interrupts are shared and the correct handler has not yet 
>> been registered, so the interrupt never gets deasserted.
>>
>> My question is: why is local_irq_save()/local_irq_restore() 
>> not working?
> 
> Really? local_irq_save not working?
> I don't believe it. 
> Please check if exist any re-enable the interrupt in the critical
> section.
> 
> -DAve


Well, mpc832xemds_phy_interrupt_enable() does nothing except call
request_irq(,,SA_SHIRQ,,).  I suspect that request_irq() is somehow
reenabling interrupts, but I can't see where it might be doing so.

Is this a possible?

Alex
