Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssmvs1Rj5zDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 15:13:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: build time sort extable
In-Reply-To: <20161007112941.20073-1-npiggin@gmail.com>
References: <20161007112941.20073-1-npiggin@gmail.com>
Date: Mon, 10 Oct 2016 15:13:44 +1100
Message-ID: <87eg3o7sef.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Can we just switch this on? Powerpc does not use relative extables
> (that's a nice exercise left for the reader), so it should just use
> the standard sort.
>
> This patch seems to work, famous last words...

Would be nice but ...

> Sorting probably only takes a few ms on any real hardware, but on on
> very large kernel configs, extable sorting can take several seconds in
> simulators and be a noticable cost to booting.

(We even carried a patch for years to speed it up.)

Blows up for me at boot:

[  OK  ] Started LSB: Control pmcd (the collection daemon for PCP).
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000062d60
cpu 0x1: Vector: 300 (Data Access) at [c0000001d6687aa0]
    pc: c000000000062d60: __copy_tofrom_user_base+0x54/0x5b4
    lr: c0000000000633d8: copy_from_user+0x78/0xe0
    sp: c0000001d6687d20
   msr: 8000000000009033
   dar: 0
 dsisr: 40000000
  current = 0xc0000001d6601880
  paca    = 0xc000000007e00400	 softe: 0	 irq_happened: 0x01
    pid   = 7101, comm = docker
Linux version 4.8.0-compiler_gcc-6.2.0-11418-g4011878e4cd3 (michael@ka3.ozlabs.ibm.com) (gcc version 6.2.0 (GCC) ) #219 SMP Mon Oct 10 14:48:04 AEDT 2016
enter ? for help
[link register   ] c0000000000633d8 copy_from_user+0x78/0xe0
[c0000001d6687d20] c0000001d6687d90 (unreliable)
[c0000001d6687d60] c0000000001c7358 do_seccomp+0x78/0x6d0
[c0000001d6687dd0] c0000000000dc08c SyS_prctl+0x27c/0x670
[c0000001d6687e30] c00000000000bde4 system_call+0x38/0xfc
--- Exception: c01 (System Call) at 000000001025634c
SP (c8208d6cd8) is in userspace



cheers
