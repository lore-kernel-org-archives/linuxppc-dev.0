Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15607.mail.cnb.yahoo.com (web15607.mail.cnb.yahoo.com
	[202.165.102.61]) by ozlabs.org (Postfix) with SMTP id 5205367A3D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 23:47:06 +1000 (EST)
Message-ID: <20060810134703.24498.qmail@web15607.mail.cnb.yahoo.com>
Date: Thu, 10 Aug 2006 21:47:03 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Problems of compiling KGDB patched kernel for 405EP and 440EP boards
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1096285275-1155217623=:32332"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1096285275-1155217623=:32332
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
I'm trying to enable KGDB between x86 host and PPC target (405EP and 440EP boards are used here). I'm using 2.6.15 kernel from ELDK4.0 patched with linux-2.6.15.5-kgdb-2.4.tar.bz2 and cross-compiling toolchain from ELDK4.0. I run "make menuconfig ARCH=ppc CROSS_COMPILE=ppc_4xx-" for configuration. For 405EP board, PPChameleonEVB is used in "Machine Type"; for 440EP board, Yosemite is used. After configuration, I run "make all ARCH=ppc CROSS_COMPILE=ppc_4xx-". But during compilation, similar errors will occur.

For 405EP, there are:
  LD      arch/powerpc/lib/built-in.o
  CC      arch/ppc/platforms/4xx/ppchameleon.o
arch/ppc/platforms/4xx/ppchameleon.c: In function 'platform_init':
arch/ppc/platforms/4xx/ppchameleon.c:252: error: 'struct machdep_calls' has no member named 'early_serial_map'
make[1]: *** [arch/ppc/platforms/4xx/ppchameleon.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2
And the lines cause the errors are:
251  #ifdef CONFIG_KGDB
252          ppc_md.early_serial_map = ppchameleon_early_serial_map;
253  #endif


For 440EP, there are:
  LD      arch/powerpc/lib/built-in.o
  CC      arch/ppc/platforms/4xx/yosemite.o
arch/ppc/platforms/4xx/yosemite.c: In function 'yosemite_early_serial_map':
arch/ppc/platforms/4xx/yosemite.c:288: warning: implicit declaration of function 'gen550_init'
arch/ppc/platforms/4xx/yosemite.c: In function 'platform_init':
arch/ppc/platforms/4xx/yosemite.c:349: error: 'struct machdep_calls' has no member named 'early_serial_map'
make[1]: *** [arch/ppc/platforms/4xx/yosemite.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2
And the lines cause the errors are:
348  #ifdef CONFIG_KGDB
349          ppc_md.early_serial_map = yosemite_early_serial_map;
350  #endif


I find that for ARCH=ppc, both ppchameleon.c and yosemite.c include the file ${2.6.15_SOURCE_DIR}/include/asm-ppc/machdep.h. There is "struct machdep_calls" but no member "early_serial_map" in it. However, in the file ${2.6.15_SOURCE_DIR}/include/asm-powerpc/machdep.h, there is "struct machdep_calls" and also member "early_serial_map" in it. If I run "make menuconfig ARCH=powerpc CROSS_COMPILE=ppc_4xx-" instead of "make menuconfig ARCH=ppc CROSS_COMPILE=ppc_4xx-", there is no PPChameleonEVB or Yosemite in "Machine Type". So I can't compile kernel for the boards I have.

Would someone like to give me any advice about this problem? Thank you very much.
  

Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 __________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
--0-1096285275-1155217623=:32332
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,<br>I'm trying to enable KGDB between x86 host and PPC target (405EP and 440EP boards are used here). I'm using 2.6.15 kernel from ELDK4.0 patched with linux-2.6.15.5-kgdb-2.4.tar.bz2 and cross-compiling toolchain from ELDK4.0. I run "make menuconfig ARCH=ppc CROSS_COMPILE=ppc_4xx-" for configuration. For 405EP board, PPChameleonEVB is used in "Machine Type"; for 440EP board, Yosemite is used. After configuration, I run "make all ARCH=ppc CROSS_COMPILE=ppc_4xx-". But during compilation, similar errors will occur.<br><br>For 405EP, there are:<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/powerpc/lib/built-in.o<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/ppc/platforms/4xx/ppchameleon.o<br>arch/ppc/platforms/4xx/ppchameleon.c: In function 'platform_init':<br>arch/ppc/platforms/4xx/ppchameleon.c:252: error: 'struct machdep_calls' has no member named 'early_serial_map'<br>make[1]: *** [arch/ppc/platforms/4xx/ppchameleon.o] Error 1<br>make: *** [arch/ppc/platforms/4xx]
 Error 2<br>And the lines cause the errors are:<br>251&nbsp; #ifdef CONFIG_KGDB<br>252&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_md.early_serial_map = ppchameleon_early_serial_map;<br>253&nbsp; #endif<br><br><br>For 440EP, there are:<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/powerpc/lib/built-in.o<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/ppc/platforms/4xx/yosemite.o<br>arch/ppc/platforms/4xx/yosemite.c: In function 'yosemite_early_serial_map':<br>arch/ppc/platforms/4xx/yosemite.c:288: warning: implicit declaration of function 'gen550_init'<br>arch/ppc/platforms/4xx/yosemite.c: In function 'platform_init':<br>arch/ppc/platforms/4xx/yosemite.c:349: error: 'struct machdep_calls' has no member named 'early_serial_map'<br>make[1]: *** [arch/ppc/platforms/4xx/yosemite.o] Error 1<br>make: *** [arch/ppc/platforms/4xx] Error 2<br>And the lines cause the errors are:<br>348&nbsp; #ifdef
 CONFIG_KGDB<br>349&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_md.early_serial_map = yosemite_early_serial_map;<br>350&nbsp; #endif<br><br><br>I find that for ARCH=ppc, both ppchameleon.c and yosemite.c include the file ${2.6.15_SOURCE_DIR}/include/asm-ppc/machdep.h. There is "struct machdep_calls" but no member "early_serial_map" in it. However, in the file ${2.6.15_SOURCE_DIR}/include/asm-powerpc/machdep.h, there is "struct machdep_calls" and also member "early_serial_map" in it. If I run "make menuconfig ARCH=powerpc CROSS_COMPILE=ppc_4xx-" instead of "make menuconfig ARCH=ppc CROSS_COMPILE=ppc_4xx-", there is no PPChameleonEVB or Yosemite in "Machine Type". So I can't compile kernel for the boards I have.<br><br>Would someone like to give me any advice about this problem? Thank you very much.<br>  <BR><BR>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R.
 China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;__________________________________________________<br>∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?<br>http://cn.mail.yahoo.com
--0-1096285275-1155217623=:32332--
