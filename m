Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 78F78DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 02:09:17 +1000 (EST)
Date: Tue, 5 Aug 2008 12:09:16 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Big include file move breaks user mode
Message-ID: <20080805120916.2f39307c@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Almost all of the includes in include/asm-powerpc where moved to
arch/powerpc/include/asm. This is breaking almost all of my user mode
code... so I assume I am doing something very wrong.

Here is a simple program that flushes stdout for no apparent reason ;)

#include <stdio.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	ioctl(1, TCFLSH, 1);
	return 0;
}

This builds and runs fine under x86 and ppc before the include file
move. After the move, the compile fails because gcc can't find
asm/ioctls.h which is needed by /usr/include/bits/ioctls.h (let's
ignore the cross-compile path for now).

The other big one I am hitting is that /usr/include/bits/errno.h
includes linux/errno.h which includes asm/errno.h which no longer
exists.

Anybody know how to fix this? I am using the DENX 4.1 toolchain if that
helps. Also, if there is a better place to post this, let me know. I
posted here since it only affects powerpc cross compiles... x86 still
has all the includes in "the right place".

Should include/asm be a link to arch/powerpc/include/asm?

Cheers,
   Sean
