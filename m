Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 51C162C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 00:36:25 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: split the math emulation into two parts
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1373975836-11928-2-git-send-email-haokexin@gmail.com>
Date: Mon, 22 Jul 2013 09:36:05 -0500
Message-Id: <4E35EEC3-D4D8-4C03-B22E-5574584539AE@kernel.crashing.org>
References: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
 <1373975836-11928-2-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 16, 2013, at 6:57 AM, Kevin Hao wrote:

> For some SoC (such as the FSL BookE) even though there does have
> a hardware FPU, but not all floating point instructions are
> implemented. Unfortunately some versions of gcc do use these
> unimplemented instructions. Then we have to enable the math emulation
> to workaround this issue. It seems a little redundant to have the
> support to emulate all the floating point instructions in this case.
> So split the math emulation into two parts. One is for the SoC which
> doesn't have FPU at all and the other for the SoC which does have the
> hardware FPU and only need some special floating point instructions to
> be emulated.
>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> arch/powerpc/Kconfig           | 20 ++++++++++++++++++++
> arch/powerpc/math-emu/Makefile | 24 ++++++++++++------------
> arch/powerpc/math-emu/math.c   | 20 ++++++++++++++------
> 3 files changed, 46 insertions(+), 18 deletions(-)

why make the split, what harm is there in just turning on the full =
emulation code to handle the unimplemented cases?

who says what some other implementation doesn't need something that you =
have in CONFIG_MATH_EMULATION_FULL?

Is the kernel code size really an issue?

- k=
