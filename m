Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31F1AB6F2B
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 18:52:36 +1100 (EST)
Received: from mail.mta.it (mail.mta.it [89.96.171.250])
	by rly12a.srv.mailcontrol.com (MailControl) with ESMTP id
	n9J7qFYg013515
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 08:52:30 +0100
Message-ID: <4ADC1AAD.60606@mta.it>
Date: Mon, 19 Oct 2009 09:52:13 +0200
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Acceleration for map_copy_from on powerpc 512x
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I'm working on a powerpc (PPC512x) embedded Linux product, and while I 
was trying to improve boot time, I found I could exploit the hw in order 
to speed up reading from NOR flashes.
The Linux/mtd version we're using is 2.6.24.6+Freescale patches.
Basically, I needed to hack the map_copy_from, which for my arch and 
uncached areas translates to a memcpy, in order to use the SCLPC FIFO, 
with a performance benefit of >2x on aligned multiple of 32Bytes transfers.

I didn't find a cleaner way than just #ifdef'ing the map_copy_from call 
and substitute with my call on relevant cases. I wonder if there is a 
cleaner way.

And yes, as soon as I've cleaned up the code a little bit, I will 
definitely post a patch about it.

Moreover: a huge benefit would come from exploiting DMA on these 
transfers, but I found I'm in_atomic while doing map_copy_from... is 
there an alternative way of locking than just disabling preemption?
I know maybe a newer kernel has already fixed it, but we're kind of 
stuck with the old one since we don't have time to port all of our 
device drivers to 2.6.3x

Thanks,
Matteo
