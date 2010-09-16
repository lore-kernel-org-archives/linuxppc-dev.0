Return-Path: <linasvepstas@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 4751F1007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 08:55:09 +1000 (EST)
Received: by vws20 with SMTP id 20so1451275vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 15:55:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100915181319.GB3683@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<20100915181319.GB3683@us.ibm.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Thu, 16 Sep 2010 17:54:46 -0500
Message-ID: <AANLkTikHxiUQR2+Gao0sNn2mzVN-M=Z=+3Z3=7H7GJdK@mail.gmail.com>
Subject: Re: [PATCH 01/15] ppc: fix return type of BUID_{HI,LO} macros
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>, Milton Miller <miltonm@bga.com>
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

I'm guessing this worked up til now because the rtas_call function prototyp=
e
was telling compiler to cast these to 32-bit before passing them as args.
(and since these would still get passed as one arg per 64-bit reg, it
still wouldn't go wrong.)

What I'm wondering about is why there was no compiler warning about an
implicit cast of a 64-bit int to a 32-bit int?  Surely, this is something t=
hat
should be warned about!

-- Linas

On 15 September 2010 13:13, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> BUID_HI and BUID_LO are used to pass data to call_rtas, which expects
> ints or u32s. But the macro doesn't cast the return, so the result is
> still u64. Use the upper_32_bits and lower_32_bits macros that have been
> added to kernel.h.
>
> Found by getting printf format errors trying to debug print the args, no
> actual code change for 64 bit kernels where the macros are actually
> used.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> ---
> =C2=A0arch/powerpc/include/asm/ppc-pci.h | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/as=
m/ppc-pci.h
> index 42fdff0..43268f1 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -28,8 +28,8 @@ extern void find_and_init_phbs(void);
> =C2=A0extern struct pci_dev *isa_bridge_pcidev; =C2=A0 =C2=A0 =C2=A0/* ma=
y be NULL if no ISA bus */
>
> =C2=A0/** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID *=
/
> -#define BUID_HI(buid) ((buid) >> 32)
> -#define BUID_LO(buid) ((buid) & 0xffffffff)
> +#define BUID_HI(buid) upper_32_bits(buid)
> +#define BUID_LO(buid) lower_32_bits(buid)
>
> =C2=A0/* PCI device_node operations */
> =C2=A0struct device_node;
> --
> 1.7.0.4
>
>
