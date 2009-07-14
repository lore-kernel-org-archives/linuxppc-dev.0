Return-Path: <anton@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F397CB7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:41:01 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDA70DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:41:01 +1000 (EST)
Date: Tue, 14 Jul 2009 17:38:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
Message-ID: <20090714073823.GB9805@kryten>
References: <20090714065350.659537380@samba.org>
	<20090714065425.301516312@samba.org>
	<1247555233.29462.86.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1247555233.29462.86.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Ben,

> Don't we lose randomization ? Or do we randomize the whole mem map
> nowadays ?

The start of the top down mmap region is randomized, so the VDSO will be in a
different position each time. A quick example:

run 1:
fffb01f6000-fffb01f9000 r-xp 00000000 00:00 0         [vdso]
fffb01f9000-fffb01fa000 r--p 00027000 08:06 4333852   /lib64/ld-2.9.so
fffb01fa000-fffb01fd000 rw-p 00028000 08:06 4333852   /lib64/ld-2.9.so
fffb01fd000-fffb01fe000 rw-p 00000000 00:00 0 
ffff7c6f000-ffff7c84000 rw-p 00000000 00:00 0         [stack]

run 2:
fff9a094000-fff9a097000 r-xp 00000000 00:00 0         [vdso]  
fff9a097000-fff9a098000 r--p 00027000 08:06 4333852   /lib64/ld-2.9.so
fff9a098000-fff9a09b000 rw-p 00028000 08:06 4333852   /lib64/ld-2.9.so
fff9a09b000-fff9a09c000 rw-p 00000000 00:00 0 
fffea0a6000-fffea0bb000 rw-p 00000000 00:00 0         [stack]

You will notice we aren't randomising each mmap, so the relative offset
between ld.so and the vdso will be consistent. I just checked and it 
looks like x86 does the same.

It might make sense to add a small amount of randomness between mmaps
on both x86 and PowerPC, at least for 64bit applications where we have
enough address space.

Anton
