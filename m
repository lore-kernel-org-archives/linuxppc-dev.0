Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 761C3B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 06:13:13 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
	by duster.selinc.com (8.14.3/8.14.3) with ESMTP id p04IwYbV022568
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 10:58:34 -0800
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0
Subject: Question about combining a PCI driver with an OF driver
Message-ID: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 4 Jan 2011 10:58:35 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm working on a project with an MPC8347 and three ethernet ports. Because 
of end of life issues we've had to replace the part we're using for the 
third ethernet port and we decided rather than rely on a vendor who would 
pull a part out from under us every two to three years we would do our own 
MAC in an FPGA.  In order to reduce driver work it was decided that we 
would use the same hardware interface as the TSEC in the 8347 so we could 
reuse the gianfar driver.  And for speed sake it would go on the PCI bus. 
(So much for letting HW make decisions regarding SW :)   )

So now I'm stuck with hacking the gianfar driver to work on PCI.  However, 
I think it would be a lot more elegant if I could wrap the gianfar driver 
with a PCI interface.  After all the idea is sound, with a HW interface 
that looks like the TSEC I should be able to reuse the gianfar driver. But 
the gianfar driver is an open firmware driver registered with a call to 
of_register_platform_driver() and depending on the order in which the 
busses are walked the PCI bus may not be enumerated and available when the 
onboard TSECS are detected and the gianfar driver claims them.

So the question is, how can I wrap an OF driver with a PCI driver so that 
I can just do a thin layer of probing the PCI bus, registering with the 
PCI sub-system, and then calling the OF probe in the gianfar driver?

Thanks for any insight.

Bruce
