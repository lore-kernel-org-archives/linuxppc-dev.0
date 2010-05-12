Return-Path: <siccegge@faui48a.informatik.uni-erlangen.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93293B7E01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 00:43:57 +1000 (EST)
Date: Wed, 12 May 2010 16:34:45 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mike Frysinger <vapier@gentoo.org>,
	Graf Yang <graf.yang@analog.com>, Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Chen Liqin <liqin.chen@sunplusct.com>,
	Lennox Wu <lennox.wu@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"Pekka Savola (ipv6)" <pekkas@netcore.fi>,
	James Morris <jmorris@namei.org>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Patrick McHardy <kaber@trash.net>, Timo Teras <timo.teras@iki.fi>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com,
	linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: Config Items appearing twice in same Kconfig file?
Message-ID: <20100512143445.GA32559@faui48a.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all!

   First of all sorry for the huge CC, I couldn't come up with a way
to create a smaller list while reaching all the relevant people.

   We, the vamos project[1] at the Friedrich Alexander University are
analything the linux configuration model trying to detect
errors. During a run with our tools we noticed  the fact that the
option ALPHA_LEGACY_START_ADDRESS in arch/alpha/Kconfig.debug is
listed twice with contradictory dependencies on ALPHA_GENERIC.

   Taking a closer look[2] we noticed 22 occurences where the same
config option is defined more than once in the same Kconfig file, not
all of them are, of course, contradictory as the ALPHA sample.

   We"d be interested in reasons to keep this configuration split up
in the same file or if this is just a error introduced someeewhere in
linux' development that should be fixed.

Regards

   Chritoph Egger

[ Please keep vamos@ Cc-ed -- we're not following all the lkml traffic
  ;) no need to keep me though ]

[1] http://vamos1.informatik.uni-erlangen.de
[2] grep  ^config **/Kconfig* | sort | uniq -d -c
