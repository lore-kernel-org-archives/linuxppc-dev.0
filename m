Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60039DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 09:41:15 +1100 (EST)
Date: Mon, 4 Feb 2008 14:40:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.24-mm1: ppc32: too few arguments to function 'reserve_bootmem'
Message-Id: <20080204144036.cf22a402.akpm@linux-foundation.org>
In-Reply-To: <200802042129.03065.m.kozlowski@tuxland.pl>
References: <20080203171634.58ab668b.akpm@linux-foundation.org>
	<200802042129.03065.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, bwalle@suse.de, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Feb 2008 21:29:02 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	This is from ppc32:
> 
>   CC      arch/powerpc/mm/mem.o
> arch/powerpc/mm/mem.c: In function 'do_init_bootmem':
> arch/powerpc/mm/mem.c:256: error: too few arguments to function 'reserve_bootmem'
> arch/powerpc/mm/mem.c:261: error: too few arguments to function 'reserve_bootmem'
> 
> Leftover from introduce-flags-for-reserve_bootmem.patch?
> 

Yes, I've had to fix that patch many times.

--- a/arch/powerpc/mm/mem.c~introduce-flags-for-reserve_bootmem-powerpc-fix
+++ a/arch/powerpc/mm/mem.c
@@ -253,12 +253,13 @@ void __init do_init_bootmem(void)
 				     lmb_size_bytes(&lmb.reserved, i) - 1;
 		if (addr < total_lowmem)
 			reserve_bootmem(lmb.reserved.region[i].base,
-					lmb_size_bytes(&lmb.reserved, i));
+					lmb_size_bytes(&lmb.reserved, i),
+					BOOTMEM_DEFAULT);
 		else if (lmb.reserved.region[i].base < total_lowmem) {
 			unsigned long adjusted_size = total_lowmem -
 				      lmb.reserved.region[i].base;
 			reserve_bootmem(lmb.reserved.region[i].base,
-					adjusted_size);
+					adjusted_size, BOOTMEM_DWEFAULT);
 		}
 	}
 #else
_

We did this wrong.  We should have introduced a new reserve_bootmem_foo()
and migrated over to that in stages.  Once all callers are migrated, remove
the old interface.
