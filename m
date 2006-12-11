Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17789.54777.283849.950002@cargo.ozlabs.ibm.com>
Date: Tue, 12 Dec 2006 09:04:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
	<Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	<Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
	<20061211180414.GA18833@aepfle.de>
	<20061211181813.GB18963@aepfle.de>
	<Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
	<20061211182908.GC7256@MAIL.13thfloor.at>
	<Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
	<20061211185536.GA19338@aepfle.de>
	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
	Steve Fox <drfickle@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> On Mon, 11 Dec 2006, Olaf Hering wrote:
> > 
> > arch/powerpc/boot/wrapper:156:    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
> 
> This is also obviously broken (and really sad), but actually ends up being 
> better than what get_kernel_version apparently does, by at least adding 
> the requirement that the string "Linux version" be slightly more correct.
> 
> However, it's also TOTALLY BROKEN. 

It's the minimum effort for the barely acceptable outcome. :)

The wrapper script, although it currently lives in arch/powerpc/boot,
is designed and intended to be standalone, so that people can use it
outside the kernel tree, and possibly even without having the kernel
source easily to hand.  Therefore I didn't want to use any kernel
header files.

Apparently the only reason "mkimage" wants to know the kernel version
is to put it as a comment in the image, which can be displayed to the
user when booting with u-boot (the bootloader used on some embedded
platforms).  So it's not critical if the grep fails, and it's slightly
more useful to do the grep than it would be to not even try to provide
any version string to mkimage.

If there is a reliable way to get the version string, great, I'll use
that.

Paul.
