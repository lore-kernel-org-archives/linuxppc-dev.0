Message-ID: <003501c1fd40$034dd010$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20020514111336.A39B411960@denx.denx.de>
Subject: Re: File System on 64-bit-bus-width Flash memory 
Date: Fri, 17 May 2002 10:13:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,

Thanks for the helps.
The 64bit buswith MTD support in ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2002-03-21.tar.bz2, which is Wolfgang Denk recommanded, is nice. But... Though it probably works well with MPC8260, it doesn't work with MPC107 which is a memory controller / PCI bridge from motorola. With MPC107 you can't access high 32 bit and low 32 bit separately. Because it doesn't have byte select or word select. Unfortunately my board uses MPC107.
The code in http://www.infradead.org/, which is Allen Curtis recommanded, has a different approach, but with some rack of functionality. First, It did not support probing for 64bit buswidth flash. Second, __raw_readll and __raw_writell, which may be 64bit read write functions, are not exist in kernel.
I changed the infradead code to support 64-bit buswith probing(I referenced the denx code). And made the __raw_writell and __raw_readll using floating load load store operation. I disabled the floating point interrupt to avoid the 'floating point used in kernel' message and re-enabled it. For now I only succeed in probing the chip. Does my approach correct? Is it OK to use floating point operations in kernel or device driver code?
Thank you.
-Sangmoon Kim-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
