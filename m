Message-ID: <001901c20602$104f9f30$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg> <20020527063451.GL16537@zax> <005c01c2054a$e3fb2100$e1a8459b@ntu.edu.sg> <00fe01c20556$614567a0$1a11efcb@industrialDiv.hanasys.co.kr> <008501c20556$544612c0$e1a8459b@ntu.edu.sg> <20020528003604.GN16537@zax>
Subject: Re: map iomem in linux_2_4_dev
Date: Tue, 28 May 2002 13:42:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>
> No, that's rubbish.  Use one or the other. ioremap() takes a physical
> address and returns the virtual address at which it mapped it.
>

Sometimes it is needed to use  io_block_mapping and ioremap.
io_block_mapping maps a phiscal address to a virtual address.
And ioremap returns the virtual address.
When I ported linux on an MPC755 based custom board.
My hardware didn't running because it had a serial port at 0x78000000.
Linux uses 0 to 0x7fffffff as a virtual memory for applications.
And the address of 0x78000000 overlaped the serial port.
I had to use io_block_mapping to map it at different location on system initialization,
and ioremap to get the mapped address on serial port driver.
I'm sorry, if it's another rubbish.
-Sangmoon Kim-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
