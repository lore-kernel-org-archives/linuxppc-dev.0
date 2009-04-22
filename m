Return-Path: <nicolas.lavocat@fr.thalesgroup.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134]) by ozlabs.org (Postfix) with ESMTP id 36A47DDF87
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 00:56:44 +1000 (EST)
Received: from thsmsgirt22p.corp.thales (unknown [10.33.231.6])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id D5E68488E46
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 16:56:41 +0200 (CEST)
Received: from thsmsgiav13p.corp.thales (10.33.231.33) by
	thsmsgirt22p.corp.thales (8.5.103)
	id 49D614AC001C4826 for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 16:56:41 +0200
Received: from vpsms001.fr.thav.thales (unknown [10.33.12.35])
	by thsmsgirt11p.corp.thales (Postfix) with ESMTP id 64E80598049
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 16:56:38 +0200 (CEST)
Received: from vpspms02.val.fr.thav.thales (128.1.6.82) by
	vpsms001.fr.thav.thales (NPlex 6.5.026)
	id 49EBDED40002C092 for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 16:56:38 +0200
Received: from vpspms02.val.fr.thav.thales (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 2BF78808F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 16:56:38 +0200 (CEST)
Received: from xbdxuspmail.bdx.fr.thav.thales (xbdxuspmail.bdx.fr.thav.thales
	[128.1.62.154])
	by vpspms02.val.fr.thav.thales (Postfix) with ESMTP id F04F28091
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 16:56:37 +0200 (CEST)
Message-ID: <49EF3023.1090007@fr.thalesgroup.com>
Date: Wed, 22 Apr 2009 16:56:35 +0200
From: Nicolas Lavocat <nicolas.lavocat@fr.thalesgroup.com>
MIME-Version: 1.0
Subject: Re: freeze when reading a PCI bridge register
References: <49EECF8D.9000808@fr.thalesgroup.com>	<20090422110327.GA9997@iram.es>
	<49EF0D74.9000005@fr.thalesgroup.com>
In-Reply-To: <49EF0D74.9000005@fr.thalesgroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tests done...

-I use ioremap for the mapping of the memory, so it should be uncacheable
-I inserted a  eieio() before the read and there is no change. In=20
addition, I use outbe_32 and inbe_32, which make a sync or isync ... And=20
these functions are used for the serial port and perfectly work
about boot traces,  there is nothing to see...  system freezes just when=20
the register "pci1_cfg_addr_register" has to be read:

traces
-------------------------------------------------------------------------
[snip]
<- unflatten_device_tree()

get_real_base: looking for abac-bridge :

OF: ** translation for device /abac@20000000 **

OF: bus is default (na=3D1, ns=3D1) on /

OF: translating address: 20000000

OF: reached root node

get_real_base: base address of ABAC : 20000000

console [udbg0] enabled

setup_arch: bootmem

reading PCI vendorID and deviceID

pci1_cfg_addr =3D 0xfdfe1098, pci1_cfg_data =3D 0xfdfe1f00

writing in pci1_cfg_data_register

reading pci1_cfg_addr_register
-------------------------------------------------------------
freeze, nothing after that...

so writing seems to be ok but reading freezes...
thank you again for your suggestions ^^
If somebody has another idea...

best regards,

Nicolas Lavocat

Nicolas Lavocat a =E9crit :
> Thank you for your advices! I try it as soon as possible! (the board=20
> is not often available...)
>
> Nicolas Lavocat
>
> Gabriel Paubert a =E9crit :
>> On Wed, Apr 22, 2009 at 10:04:29AM +0200, Nicolas Lavocat wrote:
>> =20
>>> Hi everybody!
>>>
>>> I' am trying to configure a PCI bridge on a private board, with a =20
>>> powerpc . In a first time, I tried to get informations about PCI =20
>>> devices, in order to be sure  that  my read  and write methods work=20
>>> (  using 2 configuration registers, like on an x86 architecture.) .=20
>>> 2  configuration registers  are used, for example we  write  an=20
>>> encoded  address (it is a request to a PCI device) in the first and=20
>>> the answer of  the PCI device can be read in the second register (it=20
>>> is a configuration  cycle)
>>> Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.
>>>    =20
>>
>> JTAG is probably a completely different hardware path, so it
>> does not really count. uboot testing is ok.
>> =20
>>> For example, the code used under u-boot:
>>>
>>> volatile u32* addr;
>>> u32 vendor_device_ID;
>>>
>>> puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
>>> addr=3DCFG_ADDR_PCI1;
>>> *addr=3D0x80007800;
>>>
>>> addr=3D CFG_DATA_PCI1;
>>> vendor_device_ID=3D *addr;
>>> printf("PCI1: PCI1_VENDOR_DEVICE_ID=3D %08x  \n" ,vendor_device_ID);
>>>    =20
>>
>> 2 possibilities:
>> - your I/O is not marked uncacheable (should be with ioremap)
>> - the PPC is reordering and issuing the read before the write,
>>   you should use accessors. A simple test is inserting
>>   an asm volatile("eieio") before the read.
>>
>> About your other mails, please avoid HTML mail.
>>
>>     Gabriel
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>  =20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
