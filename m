Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2C143679EF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 15:16:42 +1000 (EST)
Date: Wed, 10 May 2006 00:16:50 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> With this patch, 64-bit powerpc uses __thread for per-cpu variables.

Nice! I like the way you hid the slb functions so they can't ever be
called by mistake from C code. :-)

This patch a ppc64_defconfig vmlinux a bit (with the other two percpu
patches):

olof@quad:~/work/linux/powerpc $ ls -l vmlinux.pre vmlinux
-rwxr-xr-x 1 olof olof 10290928 2006-05-09 23:48 vmlinux.pre
-rwxr-xr-x 1 olof olof 10307499 2006-05-09 23:50 vmlinux
olof@quad:~/work/linux/powerpc $ size vmlinux.pre vmlinux
   text    data     bss     dec     hex filename
5554034 2404256  480472 8438762  80c3ea vmlinux.pre
5578866 2384944  498848 8462658  812142 vmlinux

Looks like alot of the text growth is from the added mfsprg3 instructions:

$ objdump -d vmlinux.pre | egrep mfsprg.\*,3\$ | wc -l
26
$ objdump -d vmlinux | egrep mfsprg.\*,3\$ | wc -l
5134

... so, as the PACA gets deprecated, the bloat will go away again.

> The motivation for doing this is that getting the address of a per-cpu
> variable currently requires two loads (one to get our per-cpu offset
> and one to get the address of the variable in the .data.percpu
> section) plus an add.  With __thread we can get the address of our
> copy of a per-cpu variable with just an add (r13 plus a constant).

It would be interesting to see benchmarks of how much it improves
things. I guess it doesn't really get interesting until after the paca
gets removed though, due to the added mfsprg's.


-Olof
