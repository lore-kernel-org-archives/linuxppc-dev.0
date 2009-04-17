Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F757DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:37:25 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:37:19 +0200
Message-Id: <1239953839.7443.44.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 13:53 -0500, Kumar Gala wrote:

> A bit more debug info that might be helpful, I'm hitting this bad_area  
> fault :
> 
>                  if (!(vma->vm_flags & VM_EXEC) &&
>                      (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>                       !(vma->vm_flags & (VM_READ | VM_WRITE))))
>                          goto bad_area;
> 
> bad_area 7 = 48024bf4 vm_flags:0810 0873
> SEGV 3 address:48024bf4 trap:400 error_code:0

Right, it's trying to execute off the data section (brobably just a blrl
instruction, that's what it used to do). You can see the VMA at 48022000
it's trying to execute from doesn't have the x bit set.

Toolchains were fixed, afaik, a while ago to properly mark the bit where
it does that executable, though the whole 32-bit ABI also got somewhat
overhauled to remove the need for that junk in the first place. I don't
remember the details off hand.

If we really want to support that old crap, then we probably need a
config option of some sort to force 32-bit to allow execution from
readable pages as I don't think we can identify such broken
binaries at runtime. Note that I'd be surprised if those binaries worked
under a 64-bit kernel, do you have a G5 you can try on ?

> [root:~] cat /proc/1/maps
> 00100000-00103000 r-xp 00100000 00:00 0          [vdso]
> 0feab000-0ffbe000 r-xp 00000000 00:0d 7127086    /lib/libc-2.2.5.so
> 0ffbe000-0ffcb000 ---p 00113000 00:0d 7127086    /lib/libc-2.2.5.so
> 0ffcb000-0ffeb000 rw-p 00110000 00:0d 7127086    /lib/libc-2.2.5.so
> 0ffeb000-0fff0000 rw-p 0ffeb000 00:00 0
> 10000000-10008000 r-xp 00000000 00:0d 9093222    /sbin/init
> 10017000-10018000 rw-p 00007000 00:0d 9093222    /sbin/init
> 10018000-1001c000 rwxp 10018000 00:00 0          [heap]
> 48000000-48013000 r-xp 00000000 00:0d 7127082    /lib/ld-2.2.5.so
> 48022000-48026000 rw-p 00012000 00:0d 7127082    /lib/ld-2.2.5.so
> bfd0e000-bfd23000 rwxp bffeb000 00:00 0          [stack]
