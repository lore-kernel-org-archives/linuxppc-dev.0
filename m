Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E8A91007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 10:26:33 +1100 (EST)
Message-ID: <4B15A67C.2030102@kernel.org>
Date: Wed, 02 Dec 2009 08:27:56 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091201070834.6A840B7B63@ozlabs.org>	
	<4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>
In-Reply-To: <1259709552.2076.1053.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Holger Macht <hmacht@suse.de>,
	linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 12/02/2009 08:19 AM, Benjamin Herrenschmidt wrote:
>> I think you'll need an ata_port_freeze() or abort() here because at
>> this point the drive is already gone and all in-flight commands need
>> to be failed right away.  Holger, do you remember why
>> ata_acpi_detach_device() is using ata_port_schedule_eh() instead?  Was
>> it because ata_port_freeze() might end up poking registers after
>> hotunplug happened?  ISTR reports where accessing any register there
>> causing the whole system to lock up but then why can't it use
>> ata_port_abort() instead?
> 
> I'll try. Which one ? freeze or abort tho ?

Conceptually freeze would be more approriate but the side effect is
that the port is frozen and EH will try to thaw it by resetting it.
So, abort would work better.

Thanks.

-- 
tejun
