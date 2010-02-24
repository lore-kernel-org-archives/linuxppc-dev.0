Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Feb 2010 11:27:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: John Williams <john.williams@petalogix.com>
Subject: Re: simpleImage.XX and large kernels
Message-ID: <20100224002708.GE7187@yookeroo>
References: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2010 at 08:47:44PM +1000, John Williams wrote:
> Hi,
> 
> I'm looking at the simpleImage.XXX make target (PPC 405/440), and it
> seems that by default the arch/powerpc/boot/wrapper script places the
> bootwrapper at 0x400000, effectively setting a limit on the maximum
> bootable kernel size.
> 
> For various reasons we'd like to be able to put a fairly complete
> rootfs as an initramfs, which obviously blows past a 4Mbyte limit very
> quickly.  Short of adding a new 'platform' option and associated
> hackery through the powerpc/boot Makefiles and wrapper, is there a
> quick and clean way I can tell the boot wrapper to link at a higher
> address?

Not really, although altering the wrapper script to change the link
address is really not difficult.

Having the wrapper automatically adjust the link address based on the
size of the decompressed kernel has been on my todo list for ages, but
it's unlikely I'll get around to implementing it any time soon.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
