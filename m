Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.53377.898206.21369@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 12:33:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: sign extension for 32bit syscalls on ppc64
In-Reply-To: <20060429113059.150cadd6.sfr@canb.auug.org.au>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> They do need to be sign extended for the new *at syscalls where you can pass
> a sepecial value AT_FDCWD (-10) to represent the current directory ...

So, compat_sys_openat() in fs/compat.c looks wrong to me then, if
AT_FDCWD is part of the ABI and not just an internal thing.  And I'm
now not sure whether some of the other *at syscalls do in fact need
compat wrappers...

Paul.
