Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1174678703.10836.69.camel@localhost.localdomain>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
	<1174678703.10836.69.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1f8cf21a42e1b0d8ffe896b8c20aa557@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Sat, 24 Mar 2007 01:02:33 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's fair enough to use -mno-string overall.

> If the kernel is going to
> run on cell, performance will suck with string instructions.

Yes.

> In fact,
> I'm not sure they are worth having on anything anyway.

We'll have to disagree here.  String insns _are_ useful
on many CPUs.

Either way, even if string insns would suck on every
CPU -- this shouldn't be handled in the kernel Makefiles,
convince the GCC people instead.  If there are no special
considerations why certain insns would be inappropriate
for a certain specific piece of code, you'll just have
to trust the compiler's insn selection.  That's just the
same as for any other isns patterns.

If there are such considerations, add the flags you need
for that source file, and that source file only.

If you don't compile targeting a specific CPU, and GCC's
choices suck on the hardware you actually run on, select
a different cost model.  Or, again, convince the GCC people
to make some changes.


Segher
