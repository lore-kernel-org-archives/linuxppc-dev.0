Return-Path: <cmetcalf@mellanox.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10042.outbound.protection.outlook.com [40.107.1.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZXBj6z1YzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 01:49:17 +1100 (AEDT)
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To: Jiri Slaby <jslaby@suse.cz>, <akpm@linux-foundation.org>
References: <20170303122712.13353-1-jslaby@suse.cz>
CC: <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua
 Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle
 <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov
 <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, <x86@kernel.org>,
 <linux-alpha@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
 <linux-ia64@vger.kernel.org>, <linux-mips@linux-mips.org>,
 <openrisc@lists.librecores.org>, <linux-parisc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
 <linux-xtensa@linux-xtensa.org>, <linux-arch@vger.kernel.org>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <8d435487-62a6-ebab-f45f-567d79237e9a@mellanox.com>
Date: Fri, 3 Mar 2017 09:48:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/3/2017 7:27 AM, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
>
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
>
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
>
> Signed-off-by: Jiri Slaby<jslaby@suse.cz>

Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
