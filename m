Return-Path: <niv@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D63BB7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 00:26:23 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4KEFi8G010014
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 10:15:44 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4KEQGov2224142
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 10:26:16 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4KEQFZe021814
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2010 10:26:16 -0400
Message-ID: <4BF54689.7090106@us.ibm.com>
Date: Thu, 20 May 2010 07:26:17 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com>
	<alpine.LFD.2.00.1005191620350.3368@localhost.localdomain>
	<alpine.LFD.2.00.1005192244430.3368@localhost.localdomain>
	<1274319248.22892.40.camel@concordia>
	<OF17F8F35C.B09E4797-ONC1257729.0028292D-C1257729.0029E9AC@de.ibm.com>
	<alpine.LFD.2.00.1005200950410.3368@localhost.localdomain>
	<OFCBBE5EB9.FD616EDA-ONC1257729.0030B539-C1257729.0031FB06@de.ibm.com>
	<alpine.LFD.2.00.1005201112000.3368@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1005201112000.3368@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Darren Hart <dvhltc@us.ibm.com>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	dvhltc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Doug Maxey <doug.maxey@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner wrote:

>> Pleaes check if multiple queues are enabled. The following module parameter
>> is used for that:
>>
>> MODULE_PARM_DESC(use_mcs, " 0:NAPI, 1:Multiple receive queues, Default = 0
>> ");
>>
>> you should also see the number of used HEA interrupts in /proc/interrupts
> 
> I leave that for Will and Darren, they have the hardware :)

  16:     477477	...	XICS      Level     IPI
  17:        129 ...	XICS      Level     hvc_console
  18:          0 ...	XICS      Level     RAS_EPOW
  33:     139232 ...     XICS      Level     mlx4_core
256:          3 ...     XICS      Level     ehea_neq
259:          0 ...     XICS      Level     eth0-aff
260:    2082153 ...	XICS      Level     eth0-queue0
289:     119166 ...	XICS      Level     ipr
305:          0 ...	XICS      Level     ohci_hcd:usb2
306:          0 ...	XICS      Level     ohci_hcd:usb3
307:    2389839 ...	XICS      Level     ehci_hcd:usb1


Nope, multiple rx queues not enabled.

thanks,
Nivedita
