Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by lists.ozlabs.org (Postfix) with ESMTP id 58DED1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 04:13:23 +1000 (EST)
Received: from localhost.localdomain ([127.0.0.1]:53048 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6901559AbaHNSFjnRwUK (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Thu, 14 Aug 2014 20:05:39 +0200
Date: Thu, 14 Aug 2014 20:04:18 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Message-ID: <20140814180418.GA20777@linux-mips.org>
References: <53ECE9DD.80004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53ECE9DD.80004@gmail.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, a-jacquiot@ti.com, catalin.marinas@arm.com,
 linux@openrisc.net, will.deacon@arm.com, dhowells@redhat.com,
 jcmvbkbc@gmail.com, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-s390@vger.kernel.org, gxt@mprc.pku.edu.cn,
 Jean Delvare <jdelvare@suse.de>, egtvedt@samfundet.no, jonas@southpole.se,
 Liqin Chen <liqin.linux@gmail.com>, jesper.nilsson@axis.com,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-c6x-dev@linux-c6x.org, "David S. Miller" <davem@davemloft.net>,
 linux-xtensa@linux-xtensa.org, takata@linux-m32r.org, x86@kernel.org,
 jejb@parisc-linux.org, mingo@redhat.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Lennox Wu <lennox.wu@gmail.com>,
 msalter@redhat.com, mattst88@gmail.com, hskinnemoen@gmail.com,
 fenghua.yu@intel.com, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>,
 realmz6@gmail.com, heiko.carstens@de.ibm.com, jdike@addtoit.com,
 linux-alpha@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 cmetcalf@tilera.com, starvik@axis.com, linux-m32r@ml.linux-m32r.org,
 ink@jurassic.park.msu.ru, user-mode-linux-user@lists.sourceforge.net,
 tglx@linutronix.de, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rth@twiddle.net, chris@zankel.net,
 Michal Simek <monstr@monstr.eu>, tony.luck@intel.com,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, vgupta@synopsys.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rkuo@codeaurora.org, user-mode-linux-devel@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, yasutake.koichi@jp.panasonic.com,
 linuxppc-dev@lists.ozlabs.org, deller@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 15, 2014 at 12:54:53AM +0800, Chen Gang wrote:

> Normal architectures:
> 
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
> 
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>                   score, unicore32, x86
> 
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh

Nak for MIPS.  On MIPS Kconfig already always sets one of CPU_BIG_ENDIAN
and CPU_LITTLE_ENDIAN depending on platforms and where both endianess are
supported by a platform, user choice:

config FOO
	bool "foo"
	select SYS_SUPPORTS_LITTLE_ENDIAN

config FOO
	bool "foo"
	select SYS_SUPPORTS_BIG_ENDIAN
	select SYS_SUPPORTS_LITTLE_ENDIAN
[...]
choice
        prompt "Endianess selection"
        help
          Some MIPS machines can be configured for either little or big endian
          byte order. These modes require different kernels and a different
          Linux distribution.  In general there is one preferred byteorder for a
          particular system but some systems are just as commonly used in the
          one or the other endianness.

config CPU_BIG_ENDIAN
        bool "Big endian"
        depends on SYS_SUPPORTS_BIG_ENDIAN

config CPU_LITTLE_ENDIAN
        bool "Little endian"
        depends on SYS_SUPPORTS_LITTLE_ENDIAN
        help

endchoice

So I think you can just drop the MIPS segment from your patch.

  Ralf
