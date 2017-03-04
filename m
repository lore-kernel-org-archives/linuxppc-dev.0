Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (unknown [IPv6:2001:1868:a000:17::138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbGgF5JLMzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 06:43:05 +1100 (AEDT)
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jiri Slaby <jslaby@suse.cz>
References: <20170303122712.13353-1-jslaby@suse.cz>
 <20170304130550.GT21222@n2100.armlinux.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Richard Kuo <rkuo@codeaurora.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3994975e-89a5-d2b5-60be-a8633ddc3733@zytor.com>
Date: Sat, 4 Mar 2017 11:15:17 -0800
MIME-Version: 1.0
In-Reply-To: <20170304130550.GT21222@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/17 05:05, Russell King - ARM Linux wrote:
>>  
>> +static int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
>> +{
>> +	int op = (encoded_op >> 28) & 7;
>> +	int cmp = (encoded_op >> 24) & 15;
>> +	int oparg = (encoded_op << 8) >> 20;
>> +	int cmparg = (encoded_op << 20) >> 20;
> 
> Hmm.  oparg and cmparg look like they're doing these shifts to get sign
> extension of the 12-bit values by assuming that "int" is 32-bit -
> probably worth a comment, or for safety, they should be "s32" so it's
> not dependent on the bit-width of "int".
> 

For readability, perhaps we should make sign- and zero-extension an
explicit facility?

/*
 * Truncate an integer x to n bits, using sign- or
 * zero-extension, respectively.
 */
static inline __const_func__ s32 sex32(s32 x, int n)
{
  return (x << (32-n)) >> (32-n);
}

static inline __const_func__ s64 sex64(s64 x, int n)
{
  return (x << (64-n)) >> (64-n);
}

#define sex(x,y)						\
	((__typeof__(x))					\
	 (((__builtin_constant_p(y) && ((y) <= 32)) ||		\
	   (sizeof(x) <= sizeof(s32)))				\
	  ? sex32((x),(y)) : sex64((x),(y))))

static inline __const_func__ u32 zex32(u32 x, int n)
{
  return (x << (32-n)) >> (32-n);
}

static inline __const_func__ u64 zex64(u64 x, int n)
{
  return (x << (64-n)) >> (64-n);
}

#define zex(x,y)						\
	((__typeof__(x))					\
	 (((__builtin_constant_p(y) && ((y) <= 32)) ||		\
	   (sizeof(x) <= sizeof(u32)))				\
	  ? zex32((x),(y)) : zex64((x),(y))))
