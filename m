Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xcGHY0MwczDqYl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 02:29:59 +1000 (AEST)
Date: Tue, 22 Aug 2017 19:29:51 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Andreas Schwab <schwab@linux-m68k.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
In-Reply-To: <87378ja870.fsf@linux-m68k.org>
Message-ID: <alpine.LRH.2.20.1708221925270.23061@math.ut.ee>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
 <87378ja870.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Aug 17 23:53:57 pohl kernel: [ 2940.146546] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
> > Aug 17 23:54:02 pohl kernel: [ 2944.804838] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1110
> 
> I think these messages are harmless and expected.  This device has no
> x86 option ROM but a OpenFirmware one.  This is likely unrelated to the
> sddm crash.

Yes, but after these crashes have happened for a while, vmalloc 
problems appear.

sddm crash might be related to X server dying under it, or it crashes 
for it own problems (varying signals and addresses beacuse of some 
ASLR?) and causes X server restart that triggers another ROM allocation 
round.

I did read the kernel code and I do not see how the dmesg lines are 
possible without corresponding aty128fb lines about the same ROM 
signature, or why the ROM signature is sometimes 0x1111 and sometimes 
0x1110 instead of x86 ROM signature (that clearly is not there, 
but this is expected).

-- 
Meelis Roos (mroos@linux.ee)
