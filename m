Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E27EE2C0085
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 17:32:38 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UhxLh-00072n-Au
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 00:32:37 -0700
Date: Thu, 30 May 2013 00:32:37 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369899157331-71783.post@n7.nabble.com>
In-Reply-To: <51A6EA1D.7080100@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com>
Subject: Re: can't access PCIe card under sbc8548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(continued)
  I traced the 8139too.c when it uses pci_iomap, the pci_iomap called the 
ioport_map. The difference between 8139 and my PCIe card lies in the
"port" value :
void __iomem *ioport_map(unsigned long port, unsigned int len)
{
	return (void __iomem *) (port + _IO_BASE);
}
  in 8139too.c, the "port" value is 0x1000; for my PCIe card, the "port"
value
is 0xfefff000. And the value is got from pci_resource_start. So you see, the 
8139 case doesn't overflow, my PICe overflows when _IO_BASE's value is 
0xfd7fd000.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71783.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
