Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id A454CDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 03:42:41 +1000 (EST)
Date: Wed, 19 Sep 2007 19:44:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.23-rc6-mm1 -- powerpc link failure
Message-ID: <20070919174403.GC3115@uranus.ravnborg.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070919092848.GG973@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070919092848.GG973@shadowen.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 10:28:48AM +0100, Andy Whitcroft wrote:
> I am seeing this strange link error from a PowerMac G5 (powerpc):
> 
>   [...]
>     KSYM    .tmp_kallsyms2.S
>     AS      .tmp_kallsyms2.o
>     LD      vmlinux.o
>   ld: dynreloc miscount for fs/built-in.o, section .opd
>   ld: can not edit opd Bad value
>   make: *** [vmlinux.o] Error 1

We have had this issue before.
Try to see:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=045e72acf16054c4ed2760e9a8edb19a08053af1

Here it was caused by a weak declaration that was superflous.

I expect the workaround to be equally simple this time - or I hope so.

	Sam
