Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1D88EDDEE7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 09:02:31 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "H. Peter Anvin" <hpa@zytor.com>
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
	<49FB35C4.6060107@zytor.com>
Date: Sat, 02 May 2009 01:02:12 +0200
In-Reply-To: <49FB35C4.6060107@zytor.com> (H. Peter Anvin's message of "Fri,
	01 May 2009 10:47:48 -0700")
Message-ID: <m2tz44o2a3.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>, Tim Abbott <tabbott@MIT.EDU>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Waseem, Paul Mackerras <paulus@samba.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, Bryan Wu <cooloney@kernel.org>,
	linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	Jeff Arnold <jbarnold@MIT.EDU>, Michal Simek <monstr@monstr.eu>,
	Mikael Starvik <starvik@axis.com>, Cyrill Gorcunov <gorcunov@openvz.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daher <wdaher@MIT.EDU>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	Tony Luck <tony.luck@intel.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-parisc@vger.kernel.org,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Anders Kaseorg <andersk@MIT.EDU>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hirokazu Takata <takata@linux-m32r.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Sam Ravnborg wrote:
>>>
>>> What's wrong with @?
>> arm does not support it :-(
>> I recall it denote a comment in arm assembler.
>> 
>> I could do some magic to detect the ARM case but I'm reluctant to do so.
>> I could also ignore the arm issue for now as it is not used by arm,
>> but that strikes me as the wrong approach.
>> 
>
> If we really have to use different tokens, I would say:
>
> #ifdef __ARM__
> # define _PROGBITS %progbits	/* or whatever */
> # define _NOBITS   %nobits
> #else
> # define _PROGBITS @progbits
> # define _NOBITS   @nobits
> #endif

GAS has always supported both '@' and '%', so '%' can be used
everywhere.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
