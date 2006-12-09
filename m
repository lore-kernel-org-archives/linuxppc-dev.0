Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17786.267.627624.105175@cargo.ozlabs.ibm.com>
Date: Sat, 9 Dec 2006 11:19:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
In-Reply-To: <177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> If you argue it is *not* a branch, where in the architecture
> documentation can we find any language that gives us the
> guarantee we depend on here?

isync is context synchronizing.  In the definition of context
synchronization, it says "2.  The operation is not initiated, or in
the case of isync, does not complete, until all instructions already
in execution have completed to a point at which they have reported all
exceptions they will cause".  The twi conditionally causes an
exception depending on the data from the previous load, therefore it
cannot complete to a point at which is has reported all exceptions it
will cause until it sees the data from the load.  Therefore the isync
cannot complete (and allow following instructions to start) until the
data from the load has returned.

I once asked Ed Silha (one of the PowerPC architects) whether this
reasoning was good, and he agreed it was.

Paul.
