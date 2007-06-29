Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18052.53604.173632.186062@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2007 19:31:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <fd3e668b664f28db6aa3071b1abdc642@kernel.crashing.org>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
	<fd3e668b664f28db6aa3071b1abdc642@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> It is not.  -mcpu=powerpc64 doesn't select an ABI, and your
> GCC presumably defaults to the 32-bit ABI.  Use -m64 on the
> GCC command line, too, you need it, and it solves this issue
> as a side effect.

No, actually the command line had -m64 on it.  The situation is this:

gcc -m64 -mtune=power4 works
gcc -m64 -mcpu=powerpc64 -mtune=power4 fails.

The problem is in the spec file where it works out what parameters to
pass to `as'.  Without any -mcpu it correctly defaults to passing
-mppc64 (when -m64 is given).  It then also has a list of -mcpu values
and the corresponding flag to pass to as, but powerpc64 isn't in that
list.  Thus with -mcpu=powerpc64 we don't get -mppc64 passed to as.

Paul.
