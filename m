Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id AF1BEB6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 03:39:16 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: Dave Carroll <dcarroll@astekcorp.com>
Subject: RE: [ v4] powerpc: Force page alignment for initrd reserved memory
Message-ID: <initrd-align-withdrawn@mdm.bga.com>
In-Reply-To: <522F24EF533FC546962ECFA2054FF777373072AB78@MAILSERVER2.cos.astekcorp.com>
References: <522F24EF533FC546962ECFA2054FF777373072AB75@MAILSERVER2.cos.astekcorp.com>
	<522F24EF533FC546962ECFA2054FF777373072AB78@MAILSERVER2.cos.astekcorp.com>
Date: Mon, 23 May 2011 12:39:06 -0500
Cc: Paul Mackerras <paulus@samba.org>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 23 May 2011 about 10:50:07 -0600, Dave Carroll wrote:
> I'm withdrawing this patch for the moment, due to two areas that need
> further research;
> 
> 1) An adjacent FDT blob, as mentioned by Milton Miller, and
> 

Ok ... by the way, see move_device_tree() in arch/powerpc/kernel/prom.c

> 2) Potential interaction with the crash kernel, as used in
>         init/initramfs.c

which already goes around the start and end of crashk_res, which
is adjusted to PAGE_ALIGN in reserve_crashkernel() in machine_kexec.c

 
> If anyone sees other interactions, please feel free to let me know ...
> 
> Thanks,
> -Dave Carroll

One interaction that I have ignored is preserve_initrd overlapping
crash kernel.  Loading the crash kernel destroys the preserved initrd.
But that is beyond the scope of your current patch (and probably a
seperate patch, with cross-architecture scope).

milton
