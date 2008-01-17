Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 54027DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 17:26:58 +1100 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	m0H6QtTi003064
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Jan 2008 22:26:55 -0800
To: linuxppc-embedded@ozlabs.org
Subject: Endian problem when accessing internel regs on 8347
MIME-Version: 1.0
Message-ID: <OF03A8BF8B.4AC46CCD-ON882573D3.00216F5B-882573D3.00236B8D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 16 Jan 2008 22:26:53 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've got an MPC8347 running the 2.6.24-rc5 kernel and I'm trying to access 
the GPIO registers.  I already have a driver that's doing related work 
(tho across PCI) and I just want to remap the internal CPU address to a 
kernal address and be able to read/write the register using an IOCTL call 
from user space.  My problem is, every accessor I try does an endian 
conversion before giving me my data.  So here's some code snipits of what 
I'm doing:

request_mem_region(0xe0000c00, 24, "my driver");  // 0xe0000c00 is the 
memory mapped location of the GPIO regs
data_ptr2 = ioremap(0xe0000c00, 24);

Then in the IOCTL function I try to read from the register.  First I 
tried:

ioread32(data_ptr2);

I know that the mapping is working okay because I got the data from the 
GPIO direction register, but it's been byte swapped.  The contents of the 
register are 0xFFFFFFE7, but what my user space app gets back is 
0xE7FFFFFF.  I've tried all the varients I can find, readl(), inl(), 
in_be32(), in_le32(), even __raw_readl().  They all give me back byte 
swapped data.  I'm very confused.  Especially since I've looked at 
in_be32() and in_le32(), they're both inline assembly, and they use 
different instructions.  They can't be giving me the same results.  I'm 
sure I'm not the first person to want to access PowerPC internal registers 
through a driver.  Can anyone give me a hint what I'm doing wrong?

As an additional question related to PowerPC inline assembly, can anyone 
tell me what "%U1%X1" means in the following:

__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" (ret) : 
"m" (*addr));

Thanks.

See 'ya!

Bruce
