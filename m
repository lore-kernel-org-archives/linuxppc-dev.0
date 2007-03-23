Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070323120619.GA7472@localhost.localdomain>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Fri, 23 Mar 2007 13:56:51 +0100
To: Akinobu Mita <mita@fixstars.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> GCC may generate inline copy loop to handle memcpy() function
> instead of kernel defined memcpy() with -mstring or -Os.
> But this inlined version of memcpy() caused an alignment interrupt
> when copying from SPU local store on PS3.
> (http://ozlabs.org/pipermail/cbe-oss-dev/2007-March/001348.html)
>
> This patch deletes -mstring option on all powerpc and force -mno-string
> option on Cell.

Please split into two patches, the first half (deleting
-mstring) we can all agree on and "the other half".

What your patch does is setting -mno-string for all files
if your kernel is configured to support Cell.  It would be
better to set this option (and all other options needed,
-mno-multiple and -mno-algebraic come to mind, and that last
compiler option doesn't even exist yet) unconditionally on
the few Cell-specific files that are affected, not on the
whole kernel:

	CFLAGS_whatever.o := -msome-flags

It would be even better to not lie to the compiler by
telling it it can use the LS area as normal memory, since
evidently it cannot :-)


Segher
