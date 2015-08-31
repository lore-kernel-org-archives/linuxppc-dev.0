Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8649B1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 21:19:28 +1000 (AEST)
Message-ID: <1441019966.31779.1.camel@ellerman.id.au>
Subject: Re: [Question] Is little endian supported on all the platforms?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, Geoff
 Levand <geoff@infradead.org>, Anatolij Gustschin <agust@denx.de>, Alistair
 Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Olof
 Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Aug 2015 21:19:26 +1000
In-Reply-To: <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-31 at 15:53 +0800, Boqun Feng wrote:
> On Mon, Aug 31, 2015 at 04:52:38PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2015-08-31 at 14:44 +0800, Boqun Feng wrote:
> > > Hi all,
> > > 
> > > I hit a strange build error on v4.2, when I try to build a LE kernel
> > > with a slightly modification of the ppc64_defconfig. What I did is just
> > > make ppc64_defconfig and make menuconfig to set CPU_LITTLE_ENDIAN=y, and
> > > then build the kernel.
> > > 
> > > I did a little research myself, and found out the error is because of
> > > trying to build a LE kernel with CONFIG_PPC_PS3=y. So a simple way to
> > > reproduce is:
> > 
> > First, LE isn't supported on PS/3 :-) It's only supported on POWER8
> > machines (and *some* P7 machines and only when running as KVM guest).
> 
> Got it, thank you ;-)
> 
> So should we modify Kconfigs of all the platform to reflect this?

Yes. Maybe something like this?

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c140e94..c359f72 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -415,9 +415,13 @@ config VDSO32
          big endian. That is because the only little endian configuration we
          support is ppc64le which is 64-bit only.
 
+config CHOOSE_ENDIAN
+       bool
+
 choice
        prompt "Endianness selection"
        default CPU_BIG_ENDIAN
+       depends on CHOOSE_ENDIAN
        help
          This option selects whether a big endian or little endian kernel will
          be built.
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 604190c..32d5661 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -18,6 +18,7 @@ config PPC_POWERNV
        select CPU_FREQ_GOV_ONDEMAND
        select CPU_FREQ_GOV_CONSERVATIVE
        select PPC_DOORBELL
+       select CHOOSE_ENDIAN
        default y
 
 config OPAL_PRD
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 54c87d5..182f485 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
        select HOTPLUG_CPU if SMP
        select ARCH_RANDOM
        select PPC_DOORBELL
+       select CHOOSE_ENDIAN
        default y
 
 config PPC_SPLPAR



> > But the specific problem you are having looks like a differnet issue
> > with the PS3 boot wrapper.
> > 
> 
> But could the reason of this be that the building process of the PS3
> boot wrapper assumes the kernel is BE?

It looks more like we're getting confused between 32-bit and 64-bit, from your
log:

    ld: powerpc:common64 architecture of input file `arch/powerpc/boot/ps3-head.o' is incompatible with powerpc:common output

Which says it has a .o which is 64-bit but it's trying to produce 32-bit output.

That's probably related to the PPC64_BOOT_WRAPPER stuff.

cheers
