Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 9868ADDE37
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 05:33:47 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2023087rvf
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 10:33:46 -0800 (PST)
Message-ID: <5c9cd53b0711301033w4b98a35coc275298d288973cb@mail.gmail.com>
Date: Fri, 30 Nov 2007 13:33:46 -0500
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: PCI configuration registers(BARs)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I set PCI configuration registers(BARs) of a PCI adapter as following in Uboot:


  base address 0 =              0xf4000001
  base address 1 =              0xf4000041
  base address 2 =              0xf4000081
  base address 3 =              0xa0000000
  base address 4 =              0xa0020000
  base address 5 =              0x00000000

However when I start Linux2.4 kernel, the same adapter's PCI
configuration registers have following values:
BaseAddr[0]=0x3ffffc0
BaseAddr[1]=0x3ffffb0
BaseAddr[2]=0x3ffff00
    After ioremap BaseAddr[3]=0xa1002000
BaseAddr[3]=0xa1002000
    After ioremap BaseAddr[4]=0xa1004000
BaseAddr[4]=0xa1004000
BaseAddr[5]=0x0

This is a working system on MPC8548, everything including PCI adapter
works fine. My question is why the values are different in Uboot and
Linux? The value under Uboot is reasonable, since the PCI outbound
window is set up as 0xA0000000 and 0XF4000000. In addition, the value
seems falling into the outbound window after the ioremap() is called
on BAR3 and BAR4. The ioremap() will failed if I try to convert BAR0,
BAR1, BAR2.

Thanks in advance,

Mike
