Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (89-178-69-49.broadband.corbina.ru
	[89.178.69.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00453DDFC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 08:10:26 +1000 (EST)
Message-ID: <462B6EB2.70109@ru.mvista.com>
Date: Sun, 22 Apr 2007 18:18:26 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Tri-mode auto-negotiation on ML405
References: <461F65E3.1050004@computing.dundee.ac.uk>
	<461FAF0D.3070803@ru.mvista.com>
	<46278F3A.4070007@computing.dundee.ac.uk>
In-Reply-To: <46278F3A.4070007@computing.dundee.ac.uk>
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

Hi Peter,

Peter Mendham wrote:
> Andrei Konovalov wrote:
> 
>> And I've tried the PHY library (drivers/net/phy/*) introduced by Andy 
>> Fleming.
>> Kinda works. [...]
>> Attached is the incomplete adapter.c (with FIFO mode support only) which
>> uses the PHY lib to handle the PHY. Just to illustrate the idea (will 
>> post the
>> patch later when it is completed).
> 
> Hi Andrei,
> 
> I've now had a chance to have a go at the adapter.c you sent properly 
> (sorry about the delay).  I'm afraid I can't get it to work.  I was 
> wondering if you could tell me what I'm doing wrong.  When I try and 
> bring the interface up I get:
> SIOCSIFADDR: No such device
> SIOCSIFNETMASK: No such device
> SIOCSIFBRDADDR: No such device
> SIOCGIFFLAGS: No such device
> route: SIOC[ADD|DEL]RT: No such device
> 
> I have included PHYLIB and even tried including support for the Marvell 
> PHY.  I still get the same. I'm sure I've made a stupid mistake, any ideas?

Has the ethernet device been registered on the platform bus?
There should be a call to platform_device_register()
in arch/ppc/syslib/virtex_devices.c or arch/ppc/platforms/4xx/virtex.c depending
on the kernel tree used and the patches appiled.

Thanks,
Andrei

> Thanks,
> -- Peter
> 
> 
> 
