Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17924.38058.582386.176550@cargo.ozlabs.ibm.com>
Date: Sat, 24 Mar 2007 14:02:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
In-Reply-To: <d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
Cc: Akinobu Mita <mita@fixstars.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> What your patch does is setting -mno-string for all files
> if your kernel is configured to support Cell.  It would be
> better to set this option (and all other options needed,
> -mno-multiple and -mno-algebraic come to mind, and that last
> compiler option doesn't even exist yet) unconditionally on
> the few Cell-specific files that are affected, not on the
> whole kernel:
> 
> 	CFLAGS_whatever.o := -msome-flags

Unless someone can show a measurable difference in performance between
a kernel compiled with -mno-string and one compiled without (with the
kernel compiled without being faster), then I would be inclined just
to add -mno-string everywhere, since there are some cpus (e.g. e500
cores) where string instructions aren't implemented.

Paul.
