Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 437B91007D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2012 03:30:10 +1100 (EST)
Subject: Re: [PATCH] PPC: Don't sync timebase when inside VM
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120302162058.GA24552@schlenkerla.am.freescale.net>
Date: Fri, 2 Mar 2012 17:30:05 +0100
Message-Id: <9A229F04-DFC9-485D-AB06-B1A4F0AEB348@suse.de>
References: <1330697553-27156-1-git-send-email-agraf@suse.de>
 <20120302162058.GA24552@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 kvm list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>, msm@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.03.2012, at 17:20, Scott Wood wrote:

> On Fri, Mar 02, 2012 at 03:12:33PM +0100, Alexander Graf wrote:
>> When running inside a virtual machine, we can not modify timebase, so
>> let's just not call the functions for it then.
>>=20
>> This resolves hangs when booting e500 SMP guests on overcommitted =
hosts.
>>=20
>> Reported-by: Stuart Yoder <B08248@freescale.com>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/platforms/85xx/smp.c |    7 +++++++
>> 1 files changed, 7 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp.c
>> index ff42490..d4b6c1f 100644
>> --- a/arch/powerpc/platforms/85xx/smp.c
>> +++ b/arch/powerpc/platforms/85xx/smp.c
>> @@ -249,6 +249,13 @@ void __init mpc85xx_smp_init(void)
>> 		smp_85xx_ops.cause_ipi =3D doorbell_cause_ipi;
>> 	}
>>=20
>> +	/* When running under a hypervisor, we can not modify tb */
>> +	np =3D of_find_node_by_path("/hypervisor");
>> +	if (np) {
>> +		smp_85xx_ops.give_timebase =3D NULL;
>> +		smp_85xx_ops.take_timebase =3D NULL;
>> +	}
>> +
>> 	smp_ops =3D &smp_85xx_ops;
>=20
> Again, for 85xx we should *never* sync the timebase in the kernel,
> hypervisor or no.

The code says "if the kexec config option is enabled, do the sync". I'm =
fairly sure it's there for a reason.

Git blame points to the following commit:

commit f933a41e419a954ef90605224e02c3ded78f3372
Author: Matthew McClintock <msm@freescale.com>
Date:   Wed Jul 21 16:14:53 2010 -0500

    powerpc/85xx: kexec for SMP 85xx BookE systems
   =20
    Adds support for kexec on 85xx machines for the BookE platform.
    Including support for SMP machines
   =20
    Based off work from Maxim Uvarov <muvarov@mvista.com>
    Signed-off-by: Matthew McClintock <msm@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>


Alex
