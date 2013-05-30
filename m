Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E93322C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 22:49:49 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1Ui2Ie-0001rA-Cd
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 05:49:48 -0700
Date: Thu, 30 May 2013 05:49:48 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369918188379-71827.post@n7.nabble.com>
In-Reply-To: <51A72D04.2090203@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com> <1369899157331-71783.post@n7.nabble.com>
 <51A72D04.2090203@windriver.com>
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

tiejun.chen wrote
> On 05/30/2013 03:32 PM, wolfking wrote:
>> (continued)
>>    I traced the 8139too.c when it uses pci_iomap, the pci_iomap called
>> the
>> ioport_map. The difference between 8139 and my PCIe card lies in the
>> "port" value :
>> void __iomem *ioport_map(unsigned long port, unsigned int len)
>> {
>> 	return (void __iomem *) (port + _IO_BASE);
> 
> _IO_BASE is equal to isa_io_base. So if this is not zero, I think there's
> a isa 
> bridge in your platform. So you can access these I/O ports based on that
> isa 
> bridge/bus with ioreadx/iowritex.
> 
> I tried ioread8/iowriet8 after ioremap, it doesn't work
> 
>> }
>>    in 8139too.c, the "port" value is 0x1000; for my PCIe card, the "port"
>> value
>> is 0xfefff000. And the value is got from pci_resource_start. So you see,
>> the
> 
> But this means the port is as memory-mapped so ioremap() should be
> workable in 
> this case. Then out_bex/in_bex should be fine.
> 
> Tiejun
> 
> _______________________________________________
> Linuxppc-dev mailing list

> Linuxppc-dev@.ozlabs

> https://lists.ozlabs.org/listinfo/linuxppc-dev





--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71827.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
