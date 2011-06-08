Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D122B6FD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 09:16:22 +1000 (EST)
Message-ID: <4DF002BB.1020705@freescale.com>
Date: Wed, 8 Jun 2011 18:16:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
In-Reply-To: <20110608161009.7b05d305.randy.dunlap@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: arnd@arndb.de, konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap wrote:
>> Add the drivers/virt directory, which houses drivers that support
>> > virtualization environments, and add the Freescale hypervisor management
>> > driver.

> It can't go in linux/virt or linux/virt/fsl instead?  why drivers/ ?
> 
> or maybe linux/virt should be drivers/virt ?

I knew this would happen.  The reason I put it in drivers/virt is because Arnd
told me to put it there.  At this point, I don't give a damn where it goes, but
I wish you all would come to a consensus.

>> > + * ALTERNATIVELY, this software may be distributed under the terms of the
>> > + * GNU General Public License ("GPL") as published by the Free Software
>> > + * Foundation, either version 2 of that License or (at your option) any
>> > + * later version.

> Why any later version?  I thought that <powers> decided that Linux
> is GPL v2.

Um, you do realize that this isn't the only file in the kernel that is
v2-or-later?  Try this command on the Linux source, and you'll see what I mean:

grep -r "\(at your option\)" *

I'm dual-licensing the header file because it's meant for applications as well
as the kernel.  That way, no one needs to worry whether #including the header
file in his application will taint the app with the GPL.

>> > +/**
>> > + * struct fsl_hv_ioctl_restart: restart a partition
> This syntax should be (for all structs here):
> 
>  * struct fsl_hv_ioctl_restart - restart a partition
> 
> but the struct fields/members do use ':' instead of '-'.
> 
> Darn, I checked Documentation/kernel-doc-nano-HOWTO.txt and it says
> that ':' is optional but '-' is needed, so you could use
> 
>  * struct fsl_hv_ioctl_restart: - restart a partition
> 

Ok, I'll change it.

>> > + * fsl_hv_event_register -- register a callback for failover events

> Documentation/kernel-doc-nano-HOWTO.txt says to use one '-' here, not 2.

Ok.  I'll review that document and make sure my comments conform.  I guess I
just wasn't paying attention at the time.

-- 
Timur Tabi
Linux kernel developer at Freescale
