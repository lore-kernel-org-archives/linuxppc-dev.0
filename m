Return-Path: <mihir124@yahoo.com>
Received: from web51701.mail.re2.yahoo.com (web51701.mail.re2.yahoo.com
	[206.190.38.219]) by ozlabs.org (Postfix) with SMTP id B0FEA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Nov 2009 17:13:11 +1100 (EST)
Message-ID: <848341.27696.qm@web51701.mail.re2.yahoo.com>
Date: Tue, 17 Nov 2009 22:13:09 -0800 (PST)
From: Mihir Punjabi <mihir124@yahoo.com>
Subject: Value of .bootpg and TEXT_BASE for ppc440 in U-Boot
To: u-boot@lists.denx.de, linuxppc-dev@lists.ozlabs.org,
	Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mihir124@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am currently trying to port U-Boot onto a board with PPC440x5. My board has 16MB of flash whose base address is 0xFC000000.

I have set ".bootpg" in u-boot.lds to 0xFCFFF000 (End of Flash - 4 KB) and "TEXT_BASE" in config.mk to 0xFCF80000 (End of Flash - 512 KB). I obtained an error saying "Not enough room for program headers (allocated 3, need 4)"

I get the above error even if I set ".bootpg" to 0xFCF80000 (End of Flash - 512 KB) & "TEXT_BASE" to 0xFCF00000 (End of Flash - 1 MB) - I know these are high values, but just wanted to ensure that enough space is available.
But, I still got the same error.

Can someone tell me what the problem here is? Is my understanding that ".bootpg" should be at a value (End of Flash - 4 KB) wrong?

Further, I harcoded the "SIZEOF_HEADERS" in u-boot.lds to 1024, reverted ".bootpg" to 0xFCFFF000 & "TEXT_BASE" to 0xFCF80000.

I obtained the following error:
cpu/ppc4xx/resetvec.o:(.resetvec+0x0): relocation truncated to fit: R_PPC_REL24 against symbol `_start_440' defined in .bootpg section in cpu/ppc4xx/start.o

Please let me know what exactly should .bootpg & TEXT_BASE be set to?

I am suspecting these 2 values because my code compiles successfully if I:
1) Set TEXT_BASE to 0xFFFC0000
2) Remove the hardcoding of "SIZEOF_HEADERS" & 
3) Set .bootpg to 0xFFFFF000 (set by all ppc440 boards)

Thanks and Regards,
Mihir Punjabi



      
