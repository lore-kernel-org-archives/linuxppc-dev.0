Return-Path: <typedef@eircom.net>
Received: from eurodubx.europlex.local (unknown [193.120.144.98])
	by ozlabs.org (Postfix) with ESMTP id 3A4DE67A8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 02:24:34 +1100 (EST)
Message-ID: <421CA367.1010604@eircom.net>
Date: Wed, 23 Feb 2005 15:38:15 +0000
From: Bryan O'Donoghue <typedef@eircom.net>
MIME-Version: 1.0
To: Gerhard Jaeger <g.jaeger@sysgo.com>
References: <4219EC67.1070602@dgt-lab.com.pl>
	<200502231554.56860.g.jaeger@sysgo.com>
In-Reply-To: <200502231554.56860.g.jaeger@sysgo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wojciech Kromer <krom@dgt-lab.com.pl>, linuxppc-embedded@ozlabs.org
Subject: Re: any hints using gcc 3.4.3 for 2.4.25 kernel?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gerhard Jaeger wrote:
> On Monday 21 February 2005 15:12, Wojciech Kromer wrote:
> 
>>a)first i have:
>>- 2.4.25 kernel (from denx cvs)
>>- eldk with 2.95.4 compiler
>>this one set works fine :)
>>
>>b)then, i've tried  to same sources with:
>>gcc-3.4.3 , self build from uClibc buildroot
>>new hernel hangs just after decompressing :(
>>
>>any tricks?
>>
> 
> 
> you can use the include/linux/init.h and compiler.h from 2.4.29
> kernel + patching some header files, where the inlining does not
> work any longer. I also suggest comparing with 2.4.29 kernel.
> 
> ciao,
> Gerhard
> 

If all you want is a cross compiler to make a kernel why not try this 
procedure ?

Tested with :

gcc-3.4.2
binutils-2.15.90.0.3
dietlibc-0.28 or dietlibc cvs

1
untar all sources

2
binutils:

./configure --prefix=/usr/local/powerpc-linux --target=powerpc-linux

make
make install

3
gcc:

./configure --prefix=/usr/local/powerpc-linux --target=powerpc-linux 
--with-ecos --disable-nls --enable-threads=posix --disable-shared 
--enable-languages=c --with-headers=../dietlibc/include

make
make install

There might be a little error in gcc/unwind-dw2-fde-glibc.c and 
gcc/unwind-dw2-fde.h

I can't remember the exact errors in those two files, but, hopefully 
those should be easy enough to fix.

Once you work around the slight inconsistency between dietlibc & gcc in 
those two files, and make install, you should have a full toolchain in 
/usr/local/powerpc-linux

I had been thinking about making a small script for kernel people such 
as yourself, who wanted just a toolchain for kernel cross compiles.
Maybe I'll do that.

But, in any case, the above procedure gives me a 3.4.2 which is quite 
happy to compile a 2.4.28-rc3 (though I haven't tried out the denx 
2.4.25... but, I can't see why that would fail).

Hope this helps.

--
Bryan
