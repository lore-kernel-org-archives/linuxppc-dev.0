Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFAB6DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 04:03:00 +1000 (EST)
Message-ID: <49FB35C4.6060107@zytor.com>
Date: Fri, 01 May 2009 10:47:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss
	sections.
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
	<20090501091848.GB18326@uranus.ravnborg.org>
	<alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu>
	<49FB2449.1010301@zytor.com>
	<20090501171717.GA26401@uranus.ravnborg.org>
	<49FB2EDC.9050300@zytor.com>
	<20090501174457.GA26559@uranus.ravnborg.org>
In-Reply-To: <20090501174457.GA26559@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>, Tim Abbott <tabbott@MIT.EDU>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	Jeff Arnold <jbarnold@MIT.EDU>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Cyrill Gorcunov <gorcunov@openvz.org>,
	Michal Simek <monstr@monstr.eu>, Waseem Daher <wdaher@MIT.EDU>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Anders Kaseorg <andersk@MIT.EDU>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
>>
>> What's wrong with @?
> arm does not support it :-(
> I recall it denote a comment in arm assembler.
> 
> I could do some magic to detect the ARM case but I'm reluctant to do so.
> I could also ignore the arm issue for now as it is not used by arm,
> but that strikes me as the wrong approach.
> 

If we really have to use different tokens, I would say:

#ifdef __ARM__
# define _PROGBITS %progbits	/* or whatever */
# define _NOBITS   %nobits
#else
# define _PROGBITS @progbits
# define _NOBITS   @nobits
#endif

Otherwise we probably need to ask the binutils people...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
