Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 70CEF6877C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 03:51:23 +1100 (EST)
Message-ID: <437A1208.2060804@ru.mvista.com>
Date: Tue, 15 Nov 2005 19:51:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Greg!

While doing "platformization" for one of the Freescale SoC's, I have 
discovered a serious drawback of the model - it prevents registering 
driver with the same name.

For instance, cpm2 on either ppc82xx or ppc85xx is very flexible, and 
its device fsl-cpm-scc could (and actually are) utilized in the 
different drivers.

Those devices will have different bus_id, but pdev->name fields are the 
same for all the fsl-cpm-scc, only id is different there. Hence the 
fsl-cpm-scc could be driver_register'ed only once, while it is required 
several times.

Could you please suggest possible solutions for this situation? This is 
relatively common case among freescale chips, so I guess inventing a 
workaround is odd, and writing an additional shim to handle CPM device 
multiplexing  is odd either.

TIA!
--
Sincerely,
Vitaly
