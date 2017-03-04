Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (unknown [IPv6:2001:1868:a000:17::138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbMDd1zw0zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 10:08:48 +1100 (AEDT)
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <201703042304.v24N4Afu010968@mail.zytor.com>
Date: Sat, 04 Mar 2017 15:03:50 -0800
In-Reply-To: <20170304213805.GA2449@lianli.shorne-pla.net>
References: <20170303122712.13353-1-jslaby@suse.cz>
 <20170304130550.GT21222@n2100.armlinux.org.uk>
 <3994975e-89a5-d2b5-60be-a8633ddc3733@zytor.com>
 <20170304213805.GA2449@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To: Stafford Horne <shorne@gmail.com>
CC: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Richard Kuo <rkuo@codeaurora.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller"@zytor.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<davem@davemloft.net>,Chris Metcalf <cmetcalf@mellanox.com>,Thomas Gleixner <tglx@linutronix.de>,Ingo Molnar <mingo@redhat.com>,Chris Zankel <chris@zankel.net>,Max Filippov <jcmvbkbc@gmail.com>,Arnd Bergmann <arnd@arndb.de>,x86@kernel.org,linux-alpha@vger.kernel.org,linux-snps-arc@lists.infradead.org,linux-arm-kernel@lists.infradead.org,linux-hexagon@vger.kernel.org,linux-ia64@vger.kernel.org,linux-mips@linux-mips.org,openrisc@lists.librecores.org,linux-parisc@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-sh@vger.kernel.org,sparclinux@vger.kernel.org,linux-xtensa@linux-xtensa.org,linux-arch@vger.kernel.org
From: hpa@zytor.com
Message-ID: <9B46AFA6-C422-41FD-8E8A-356E44A6DCD2@zytor.com>

On March 4, 2017 1:38:05 PM PST, Stafford Horne <shorne@gmail=2Ecom> wrote:
>On Sat, Mar 04, 2017 at 11:15:17AM -0800, H=2E Peter Anvin wrote:
>> On 03/04/17 05:05, Russell King - ARM Linux wrote:
>> >> =20
>> >> +static int futex_atomic_op_inuser(int encoded_op, u32 __user
>*uaddr)
>> >> +{
>> >> +	int op =3D (encoded_op >> 28) & 7;
>> >> +	int cmp =3D (encoded_op >> 24) & 15;
>> >> +	int oparg =3D (encoded_op << 8) >> 20;
>> >> +	int cmparg =3D (encoded_op << 20) >> 20;
>> >=20
>> > Hmm=2E  oparg and cmparg look like they're doing these shifts to get
>sign
>> > extension of the 12-bit values by assuming that "int" is 32-bit -
>> > probably worth a comment, or for safety, they should be "s32" so
>it's
>> > not dependent on the bit-width of "int"=2E
>> >=20
>>=20
>> For readability, perhaps we should make sign- and zero-extension an
>> explicit facility?
>
>There is some of this in already here, 32 and 64 bit versions:
>
>  include/linux/bitops=2Eh
>
>Do we really need zero extension? It seems the same=2E
>
>Example implementation from bitops=2Eh
>
>static inline __s32 sign_extend32(__u32 value, int index)
>{
>        __u8 shift =3D 31 - index;
>        return (__s32)(value << shift) >> shift;
>}
>
>> /*
>>  * Truncate an integer x to n bits, using sign- or
>>  * zero-extension, respectively=2E
>>  */
>> static inline __const_func__ s32 sex32(s32 x, int n)
>> {
>>   return (x << (32-n)) >> (32-n);
>> }
>>=20
>> static inline __const_func__ s64 sex64(s64 x, int n)
>> {
>>   return (x << (64-n)) >> (64-n);
>> }
>>=20
>> #define sex(x,y)						\
>> 	((__typeof__(x))					\
>> 	 (((__builtin_constant_p(y) && ((y) <=3D 32)) ||		\
>> 	   (sizeof(x) <=3D sizeof(s32)))				\
>> 	  ? sex32((x),(y)) : sex64((x),(y))))
>>=20
>> static inline __const_func__ u32 zex32(u32 x, int n)
>> {
>>   return (x << (32-n)) >> (32-n);
>> }
>>=20
>> static inline __const_func__ u64 zex64(u64 x, int n)
>> {
>>   return (x << (64-n)) >> (64-n);
>> }
>>=20
>> #define zex(x,y)						\
>> 	((__typeof__(x))					\
>> 	 (((__builtin_constant_p(y) && ((y) <=3D 32)) ||		\
>> 	   (sizeof(x) <=3D sizeof(u32)))				\
>> 	  ? zex32((x),(y)) : zex64((x),(y))))
>>=20

Signed versus unsigned=2E=2E=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
