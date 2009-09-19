Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43C58B7B7F
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Sep 2009 01:53:18 +1000 (EST)
Received: from bzq-82-81-138-186.red.bezeqint.net ([82.81.138.186]:50585
	helo=[10.0.0.2]) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1Mp2FT-0001Ee-4S
	for linuxppc-dev@ozlabs.org; Sat, 19 Sep 2009 11:53:19 -0400
Message-ID: <4AB4FE51.9050607@embedded-sol.com>
Date: Sat, 19 Sep 2009 18:52:49 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: FPGA access over PCI-E on MPC8536
References: <4AB1B84F.8080606@embedded-sol.com>	<C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
	<1253176993.8375.345.camel@pasglop>
In-Reply-To: <1253176993.8375.345.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Benjamin

Benjamin Herrenschmidt wrote:
>>> However when I attempt to access FPGA memory my mmapping it in  
>>> userspace the read hangs. The same happens in kernel space. Does it  
>>> happen because FPGA memory is marked as disabled, or because FPGA  
>>> code is doing something wrong ?
>> Can you access the device in u-boot?  That would possible tell you if  
>> the HW is functioning or not.
>>
>>> Another question is what can cause PCI device memory be marked as
>>> disabled.
>> Good question, no idea how lspci decided to print [disabled].  Take a  
>> look at lspci source and see :)
> 
> Maybe the memory enable in the PCI command register isn't set ?
> 
> If you don't have a kernel driver that sets it (by calling
> pci_enable_device) and u-boot doesn't set it then it's going
> to be off and you'll get hangs or machine checks trying to
> access the device...
> 
> Just an idea...

Yes, that was my problem exactly ! Setting this bit via setpci
fixed it.

Thanks a lot for your help.

Felix
