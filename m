Return-Path: <afleming@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 0BD03DDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 09:30:45 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so521919ywb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 14:30:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1235477399-20428-3-git-send-email-opurdila@ixiacom.com>
References: <1233724934.16867.290.camel@pasglop>
	<1235477399-20428-3-git-send-email-opurdila@ixiacom.com>
Date: Thu, 26 Feb 2009 16:30:43 -0600
Message-ID: <2acbd3e40902261430l77b465cqf1cb6f0f4b737e92@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc: oprofile: enable support for ppc750
	processors
From: Andy Fleming <afleming@gmail.com>
To: Octavian Purdila <opurdila@ixiacom.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2009 at 6:09 AM, Octavian Purdila <opurdila@ixiacom.com> wr=
ote:
> Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>
> ---
> =A0arch/powerpc/kernel/cputable.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 923f87a..4e20cfb 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -726,6 +726,8 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.cpu_setup =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =
__setup_cpu_750,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.machine_check =A0 =A0 =A0 =A0 =A0=3D mach=
ine_check_generic,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =
"ppc750",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .oprofile_cpu_type =A0 =A0 =A0=3D "ppc/7450=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .oprofile_type =A0 =A0 =A0 =A0 =A0=3D PPC_O=
PROFILE_G4,
> =A0 =A0 =A0 =A0},


I know this saves you some code, but it seems hacky.  It would be
better to modify oprofile to detect the proper cpu type.  Also, this
will screw things up if you try to use the different event set that
the 750 has.

Also, one more concern is the long-standing errata which makes this
quite dangerous.  All of the versions of the 750 I'm aware of have a
bug where if a Performance Monitor exception occurs within one cycle
of the Decrementer exception, the cpu will lose the ability to return
from the interrupt (SRR0/SRR1 become corrupted).  It's possible the
750s you have modified to support oprofile don't have this errata.
Alternatively, we can decide we don't care, as you have to be root to
use oprofile.  But this is why I didn't add support for anything
before the 7450.

Andy
