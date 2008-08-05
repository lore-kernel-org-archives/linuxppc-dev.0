Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34BC5DE0DB
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 02:14:01 +1000 (EST)
Message-Id: <988452A8-7DC4-4FFE-9E5B-F93E4BB7A847@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080805120916.2f39307c@lappy.seanm.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Big include file move breaks user mode
Date: Tue, 5 Aug 2008 11:13:56 -0500
References: <20080805120916.2f39307c@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 5, 2008, at 11:09 AM, Sean MacLennan wrote:

> Almost all of the includes in include/asm-powerpc where moved to
> arch/powerpc/include/asm. This is breaking almost all of my user mode
> code... so I assume I am doing something very wrong.
>
> Here is a simple program that flushes stdout for no apparent reason ;)
>
> #include <stdio.h>
> #include <sys/ioctl.h>
>
> int main(int argc, char *argv[])
> {
> 	ioctl(1, TCFLSH, 1);
> 	return 0;
> }
>
> This builds and runs fine under x86 and ppc before the include file
> move. After the move, the compile fails because gcc can't find
> asm/ioctls.h which is needed by /usr/include/bits/ioctls.h (let's
> ignore the cross-compile path for now).
>
> The other big one I am hitting is that /usr/include/bits/errno.h
> includes linux/errno.h which includes asm/errno.h which no longer
> exists.
>
> Anybody know how to fix this? I am using the DENX 4.1 toolchain if  
> that
> helps. Also, if there is a better place to post this, let me know. I
> posted here since it only affects powerpc cross compiles... x86 still
> has all the includes in "the right place".
>
> Should include/asm be a link to arch/powerpc/include/asm?

Are you using the headers_install option?  or just point to a kernel  
tree.

- k
