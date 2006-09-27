Return-Path: <nielsen.esben@gogglemail.com>
Received: from mx01.stofanet.dk (mx01.stofanet.dk [212.10.10.11])
	by ozlabs.org (Postfix) with ESMTP id C14E167BFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 02:52:37 +1000 (EST)
Date: Wed, 27 Sep 2006 18:52:13 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: local_irq_save not masking interrupts
In-Reply-To: <4518FA21.8050801@cambridgebroadband.com>
Message-ID: <Pine.LNX.4.64.0609271802460.9792@frodo.shire>
References: <4518FA21.8050801@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Tue, 26 Sep 2006, Alex Zeffertt wrote:

> Hi list,
>
> I'm having a strange problem with interrupts.  My platform is the
> MPC832xEMDS and the BSP I'm using (from Freescale) uses Linux-2.6.11.
>
> In the code below I enter a critical section with local_irq_save(),
> call request_irq() (from mpc832xemds_phy_interrupt_enable) 4 times,
> then exit the critical section using local_irq_restore.
>
>     /* Enable interrupts from PHYs */
>     local_irq_save(flags);
>     for (i = 0; i < driver_data->num_phys; i++) {
>         struct atm_dev *dev = driver_data->dev_data[i]->dev;
>         printk("%s/%d\n",__FUNCTION__,__LINE__);
>         RETURN_ON_ERROR(mpc832xemds_phy_interrupt_enable(dev));
>     }
>     local_irq_restore(flags);
>

This is a pure side-comment:

Please, don't use local_irq_save() for a critical region. Use
spin_lock_irqsave(), for 3 reasons:
1) SMP.
2) Preempt-realtime is like SMP not happy about using local_irq_save().
3) Read-ability: It is more clear what data is protected when there is a 
named lock object in the code.

You might not care about 1) and 2) but 3) should matter for you. And 
remember: When CONFIG_SMP is not set spin_lock_irqsave() will just 
become a local_irq_save().

Esben
