Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88045B7B8D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 19:20:20 +1100 (EST)
In-Reply-To: <20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 16 Oct 2009 10:16:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 15/10/2009 18:56:50:
>
> arch/powerpc/kernel/head_8xx.o: In function `FixupDAR':
> /home/rfeany/src/lnxnm/linux-dev/arch/powerpc/kernel/head_8xx.S:576: undefined
> reference to `DARfix'
>
> With all of your patches applied I have this problem:
>
> open("/proc/mounts", O_RDONLY)          = 3
> fstat64(0x3, 0x7fc6ad58)                = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
> read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
> exit_group(0)                           = ?
>
> but it works fine with /dev/zero:
>
> open("/dev/zero", O_RDONLY)             = 3
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30001000
> read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
> \0"..., 1024) = 1024
>
> If I revert "8xx: start using dcbX instructions in various copy
> routines" then it works again. I think it is the cache instructions
> added to __copy_tofrom_user: reading from /dev/zero is OK (it uses
> __clear_user, no dcbX), but copy_to_user() fails.

Yes, only copy_tofrom_user will actually case a TLBError with
the dcbX insn.

>
> It seems stable with all but the dcbX patch applied. I haven't been able
> to crash it yet, anyway :)

Right, it is the pte table walk that is blowing up.
I just noted that 2.6 lacks a tophys() call in its table walk
so I removed that one(there is one more tophys call but I don't think
it should be removed).
Try this addon patch:

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3df4a17..0e91da4 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -540,7 +540,6 @@ DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR
      mtspr SPRN_MD_EPN, r10
      mfspr r11, SPRN_M_TWB	/* Get level 1 table entry address */
      lwz   r11, 0(r11)	/* Get the level 1 entry */
-     tophys  (r11, r11)
      DO_8xx_CPU6(0x3b80, r3)
      mtspr SPRN_MD_TWC, r11	/* Load pte table base address */
      mfspr r11, SPRN_MD_TWC	/* ....and get the pte address */
