Return-Path: <jirislaby@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx73L2bFhzDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 22:02:37 +1000 (AEST)
Received: by mail-wm0-f65.google.com with SMTP id 131so1071256wmq.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 05:02:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] futex: remove duplicated code and fix UB
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Richard Kuo
 <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org
References: <20170621115318.2781-1-jslaby@suse.cz>
 <alpine.DEB.2.20.1706230017520.2221@nanos>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <80af8d81-4522-de2d-8289-1ab46565505a@suse.cz>
Date: Mon, 26 Jun 2017 14:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706230017520.2221@nanos>
Content-Type: text/plain; charset=iso-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2017, 09:51 AM, Thomas Gleixner wrote:
> On Wed, 21 Jun 2017, Jiri Slaby wrote:
>> diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
>> index f32b42e8725d..5bb2fd4674e7 100644
>> --- a/arch/arm64/include/asm/futex.h
>> +++ b/arch/arm64/include/asm/futex.h
>> @@ -48,20 +48,10 @@ do {									\
>>  } while (0)
>>  
>>  static inline int
>> -futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> 
> That unsigned int seems to be a change from the arm64 tree in next. It's
> not upstream and it'll cause a (easy to resolve) conflict.

Ugh, I thought the arm64 is in upstream already. Note that this patch
just takes what is in this arm64 fix and makes it effective for all
architectures. So I will wait with v2 until it merges upstream.

So, Will, will you incorporate Thomas' comments into your arm64 fix?

...

> Yes, we probably can't change that anymore, but at least we should make it
> very explicit and add a comment to that effect.

Something like this or do you want a comment yet?
        unsigned int op =         (encoded_op & 0x70000000) >> 28;
        unsigned int cmp =        (encoded_op & 0x0f000000) >> 24;
        int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
        int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);

thanks,
-- 
js
suse labs
