Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <17924.38058.582386.176550@cargo.ozlabs.ibm.com>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
	<17924.38058.582386.176550@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <481387db70970cb6bd6c44b449299e47@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Sat, 24 Mar 2007 15:46:49 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Akinobu Mita <mita@fixstars.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> What your patch does is setting -mno-string for all files
>> if your kernel is configured to support Cell.  It would be
>> better to set this option (and all other options needed,
>> -mno-multiple and -mno-algebraic come to mind, and that last
>> compiler option doesn't even exist yet) unconditionally on
>> the few Cell-specific files that are affected, not on the
>> whole kernel:
>>
>> 	CFLAGS_whatever.o := -msome-flags
>
> Unless someone can show a measurable difference in performance between
> a kernel compiled with -mno-string and one compiled without (with the
> kernel compiled without being faster), then I would be inclined just
> to add -mno-string everywhere, since there are some cpus (e.g. e500
> cores) where string instructions aren't implemented.

So add it _if_ support for e500 is compiled in.

Not using string instructions probably won't hurt performance
much, but adding -mno-string always doesn't solve any actual
problems -- in particular, it doesn't solve the original problem
that got all this started, which needs -mno-multiple too (and
that hurts performance on many CPUs) and -mno-algebraic and
-mno-dcbz (and those two options don't even exist yet).

If you decide to put -mno-string in there always anyway, please
put a nice fat big comment on there saying why this is done?


Segher
