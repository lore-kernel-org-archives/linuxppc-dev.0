Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20762B6F54
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2011 23:27:55 +1000 (EST)
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
Date: Thu, 14 Jul 2011 08:27:44 -0500
Message-Id: <CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 11, 2011, at 6:31 AM, Tiejun Chen wrote:

> When kprobe these operations such as store-and-update-word for SP(r1),
>=20
> stwu r1, -A(r1)
>=20
> The program exception is triggered, and PPC always allocate an =
exception frame
> as shown as the follows:
>=20
> old r1 ----------
>         ...
>         nip
>         gpr[2] ~ gpr[31]
>         gpr[1] <--------- old r1 is stored.
>         gpr[0]
>       -------- <--------- pr_regs @offset 16 bytes
>       padding
>       STACK_FRAME_REGS_MARKER
>       LR
>       back chain
> new r1 ----------
> Then emulate_step() will emulate this instruction, 'stwu'. Actually =
its
> equivalent to:
> 1> Update pr_regs->gpr[1] =3D mem[old r1 + (-A)]
> 2> stw [old r1], mem[old r1 + (-A)]
>=20
> Please notice the stack based on new r1 may be covered with mem[old r1
> +(-A)] when addr[old r1 + (-A)] < addr[old r1 + sizeof(an exception =
frame0].
> So the above 2# operation will overwirte something to break this =
exception
> frame then unexpected kernel problem will be issued.
>=20
> So looks we have to implement independed interrupt stack for PPC =
program
> exception when CONFIG_BOOKE is enabled. Here we can use
> EXC_LEVEL_EXCEPTION_PROLOG to replace original NORMAL_EXCEPTION_PROLOG
> for program exception if CONFIG_BOOKE. Then its always safe for kprobe
> with independed exc stack from one pre-allocated and dedicated =
thread_info.
> Actually this is just waht we did for critical/machine check =
exceptions
> on PPC.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---

I'm still very confused why we need a unique stack frame for =
kprobe/program exceptions on book-e devices.

Can you explain this further.

- k
