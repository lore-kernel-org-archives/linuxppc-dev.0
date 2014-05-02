Return-Path: <mpe@ellerman.id.au>
Message-ID: <1398993559.23822.1.camel@concordia>
Subject: Re: cscope: issue with symlinks in
 tools/testing/selftests/powerpc/copyloops/
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yann Droneaud <ydroneaud@opteya.com>
Date: Fri, 02 May 2014 11:19:19 +1000
In-Reply-To: <1396530975.4361.28.camel@localhost.localdomain>
References: <1396530975.4361.28.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Hans-Bernhard =?ISO-8859-1?Q?Br=F6ker?= <broeker@users.sourceforge.net>,
 Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
 Neil Horman <nhorman@users.sourceforge.net>,
 cscope-devel@lists.sourceforge.net, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-03 at 15:16 +0200, Yann Droneaud wrote:
> Hi,
> 
> I'm using cscope to browse kernel sources, but I'm facing warnings from
> the tool since following commit:
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=22d651dcef536c75f75537290bf3da5038e68b6b
> 
>     commit 22d651dcef536c75f75537290bf3da5038e68b6b
>     Author: Michael Ellerman <mpe@ellerman.id.au>
>     Date:   Tue Jan 21 15:22:17 2014 +1100
> 
>     selftests/powerpc: Import Anton's memcpy / copy_tofrom_user tests

Ooops, sorry.

> cscope reports error when generating the cross-reference database:
> 
>     $ make ALLSOURCE_ARCHS=all O=./obj-cscope/ cscope
>       GEN     cscope
>     cscope: cannot find
> file /home/ydroneaud/src/linux/tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
> 
> It's a rather uncommon side effect of having (for the first time ?)
> sources files as symlinks: looking for symlinks in the kernel sources
> returns only:
> 
>     $ find . -type l
>     ./arch/mips/boot/dts/include/dt-bindings
>     ./arch/microblaze/boot/dts/system.dts
>     ./arch/powerpc/boot/dts/include/dt-bindings
>     ./arch/metag/boot/dts/include/dt-bindings
>     ./arch/arm/boot/dts/include/dt-bindings
>     ./tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
>     ./tools/testing/selftests/powerpc/copyloops/memcpy_64.S
>     ./tools/testing/selftests/powerpc/copyloops/memcpy_power7.S
>     ./tools/testing/selftests/powerpc/copyloops/copyuser_64.S


Right.

I did check that there were other symlinks already in the tree, but you're
correct I seem to be the first clever person to add symlinks to source files.

> So one can wonder if having symlinked sources files is an expected
> supported feature for kbuild and all the various kernel
> tools/infrastructure ?

Kbuild is not involved really, these files are just built with plain Makefiles,
at least from the symlink side.

FWIW ctags seems to cope, that's what I use.

But I didn't think of cscope.


Given you're the only person who's noticed I suspect most other things haven't
broken, fingers crossed :)

cheers
