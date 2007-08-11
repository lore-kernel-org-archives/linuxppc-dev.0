Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 67BDADDE39
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 11:56:52 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so676438rvf
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 18:56:51 -0700 (PDT)
Message-ID: <5c9cd53b0708101856p140ede1k1d5fa2a9bc83a109@mail.gmail.com>
Date: Fri, 10 Aug 2007 21:56:51 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Early UART configuration for 85xx on 2.6 Kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1538_32718437.1186797411082"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1538_32718437.1186797411082
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

In order to debug the 8548 CDS BSP of kernel 2.6, I want setup serial port
with UART on mpc85xx as early as possible. . I add the register access
code at the beginning of  platform_init(). However the system just hanging
there with this line. If I comment out this
line"WRITE8_ADDR(M85xx_EIIADDR,0)", then linux kernel runs well.

Thanks in advance,

Mike Z

Here is the code of my mpc85xx_cds_common.c:

#define WRITE8_ADDR(address, value) \
    ((*((volatile u8 *)(address))) = (u8)(value))

#define M85xx_EII_ADDR 0xe0004500

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                   unsigned long r6, unsigned long r7)
{
       /* parse_bootinfo must always be called first */
       parse_bootinfo(find_bootinfo());

      /* Now we try to access register of UART */
      WRITE8_ADDR(M85xx_EII_ADDR, 0);
....
}

------=_Part_1538_32718437.1186797411082
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>In order to debug the 8548 CDS BSP of kernel 2.6, I want setup serial port with UART on mpc85xx as early as possible. . I add the register access code&nbsp;at the beginning of &nbsp;platform_init(). However the system just hanging there with this line. If I comment out this line&quot;WRITE8_ADDR(M85xx_EIIADDR,0)&quot;, then linux kernel runs well.
</div>
<div>&nbsp;</div>
<div>Thanks in advance,</div>
<div>&nbsp;</div>
<div>Mike Z</div>
<div>&nbsp;</div>
<div>Here is the code of my mpc85xx_cds_common.c:</div>
<div>&nbsp;</div>
<div>#define WRITE8_ADDR(address, value) \</div>
<div>&nbsp;&nbsp;&nbsp; ((*((volatile u8 *)(address))) = (u8)(value))</div>
<div>&nbsp;</div>
<div>#define M85xx_EII_ADDR 0xe0004500</div>
<div>&nbsp;</div>
<div>void __init</div>
<div>platform_init(unsigned long r3, unsigned long r4, unsigned long r5, </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long r6, unsigned long r7)</div>
<div>{</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* parse_bootinfo must always be called first */</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parse_bootinfo(find_bootinfo());</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Now we try to access register of UART */</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE8_ADDR(M85xx_EII_ADDR, 0);</div>
<div>....</div>
<div>}&nbsp;</div>
<div>&nbsp;</div>

------=_Part_1538_32718437.1186797411082--
