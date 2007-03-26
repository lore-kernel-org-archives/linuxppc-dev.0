Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200703232146.21224.arnd@arndb.de>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
	<200703232146.21224.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7f2c3c749a9c5b836354e4f0c6343e6d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] force -mno-string option on cell
Date: Mon, 26 Mar 2007 14:00:31 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: Akinobu Mita <mita@fixstars.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It would be even better to not lie to the compiler by
>> telling it it can use the LS area as normal memory, since
>> evidently it cannot :-)
>
> Yes, this is the important point. I actually think the first
> patch that just replaces memcpy with memcpy_fromio is the
> right solution for the specific problem.

Not only is it the _right_ solution, it actually _is_ a
solution -- adding -mno-string only sweeps one particular
symptom under the rug, it doesn't fix anything.

> Avoiding certain instructions in the kernel may be a good
> thing to do as well,

Only if there is something special about the kernel wrt
those instructions.  For example, if certain insns cannot
execute in supervisor mode on some CPU.

If there is no such special consideration, you should
just let GCC do its job (and if you think it makes bad
insn selection choices, you know where to come complain).

> but this is not at all a cell specific
> thing.

Indeed.

> Maybe we should have a more detailed CPU selection Kconfig
> option like
>
> CPU Family
>    * 64 bit common (power3/4/5/6, ppc970, cell, *star)
>    * 32 bit common (6xx, 82xx, 83xx, 86xx)
>    * 40x/44x
>    * ...

Useful.  This could at least partly be derived / defaulted
from the platform support that is already selected, too.

> Minimum supported CPU (gcc -march=, depending on above selection)
>    * 603
>    * 604
>    * 750
>    * power3
>    * power4
>    * 970

There is no -march= option.  You mean -mcpu= I think?

> Optimize for CPU (gcc -mtune)
>    (subset of the -march list as before)

-mcpu= implies -mtune= for the same CPU.  I don't think
many people would ever want to set something else.

Btw, when you install GCC, you can select its default
-mcpu= target: ../gcc/configure --with-cpu=970 .  It
helps ;-)


Segher
