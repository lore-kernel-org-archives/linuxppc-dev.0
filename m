Return-Path: <nicolas.lavocat@fr.thalesgroup.com>
Received: from thsmsgxrt12p.thalesgroup.com (thsmsgxrt12p.thalesgroup.com
	[192.54.144.135]) by ozlabs.org (Postfix) with ESMTP id 1D926DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 22:28:41 +1000 (EST)
Received: from thsmsgirt21p.corp.thales (unknown [10.33.231.5])
	by thsmsgxrt12p.thalesgroup.com (Postfix) with ESMTP id 6808C41CB28
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 14:28:39 +0200 (CEST)
Received: from thsmsgiav11p.corp.thales (10.33.231.31) by
	thsmsgirt21p.corp.thales (8.5.103)
	id 49D612C0001BE628 for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 14:28:39 +0200
Received: from vpsms001.fr.thav.thales (unknown [10.33.12.35])
	by thsmsgirt12p.corp.thales (Postfix) with ESMTP id 27C5C391BCB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 14:28:39 +0200 (CEST)
Received: from vpspms02.val.fr.thav.thales (128.1.6.82) by
	vpsms001.fr.thav.thales (NPlex 6.5.026)
	id 49EBDED400029016 for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 14:28:39 +0200
Received: from vpspms02.val.fr.thav.thales (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 110AA807E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 14:28:39 +0200 (CEST)
Received: from xbdxuspmail.bdx.fr.thav.thales (xbdxuspmail.bdx.fr.thav.thales
	[128.1.62.154])
	by vpspms02.val.fr.thav.thales (Postfix) with ESMTP id F0F88808F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 14:28:38 +0200 (CEST)
Message-ID: <49EF0D74.9000005@fr.thalesgroup.com>
Date: Wed, 22 Apr 2009 14:28:36 +0200
From: Nicolas Lavocat <nicolas.lavocat@fr.thalesgroup.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: freeze when reading a PCI bridge register
References: <49EECF8D.9000808@fr.thalesgroup.com>
	<20090422110327.GA9997@iram.es>
In-Reply-To: <20090422110327.GA9997@iram.es>
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

Thank you for your advices! I try it as soon as possible! (the board is=20
not often available...)

Nicolas Lavocat

Gabriel Paubert a =E9crit :
> On Wed, Apr 22, 2009 at 10:04:29AM +0200, Nicolas Lavocat wrote:
>  =20
>> Hi everybody!
>>
>> I' am trying to configure a PCI bridge on a private board, with a =20
>> powerpc . In a first time, I tried to get informations about PCI =20
>> devices, in order to be sure  that  my read  and write methods work ( =
=20
>> using 2 configuration registers, like on an x86 architecture.) . 2 =20
>> configuration registers  are used, for example we  write  an encoded =20
>> address (it is a request to a PCI device) in the first and the answer =
of =20
>> the PCI device can be read in the second register (it is a configurati=
on =20
>> cycle)
>> Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.
>>    =20
>
> JTAG is probably a completely different hardware path, so it
> does not really count. uboot testing is ok.
>  =20
>> For example, the code used under u-boot:
>>
>> volatile u32* addr;
>> u32 vendor_device_ID;
>>
>> puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
>> addr=3DCFG_ADDR_PCI1;
>> *addr=3D0x80007800;
>>
>> addr=3D CFG_DATA_PCI1;
>> vendor_device_ID=3D *addr;
>> printf("PCI1: PCI1_VENDOR_DEVICE_ID=3D %08x  \n" ,vendor_device_ID);
>>    =20
>
> 2 possibilities:
> - your I/O is not marked uncacheable (should be with ioremap)
> - the PPC is reordering and issuing the read before the write,
>   you should use accessors. A simple test is inserting
>   an asm volatile("eieio") before the read.
>
> About your other mails, please avoid HTML mail.
>
> 	Gabriel
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>  =20
