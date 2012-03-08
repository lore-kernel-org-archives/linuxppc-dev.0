Return-Path: <B29882@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEC20B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 04:31:21 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH] PPC: Don't sync timebase when inside VM
Date: Thu, 8 Mar 2012 17:31:12 +0000
Message-ID: <CAEsOVNczPUdfUK6oZ7WOTGUQbA135HgrntwvnydbYd-Eo4joLg@mail.gmail.com>
References: <1330697553-27156-1-git-send-email-agraf@suse.de>
 <20120302162058.GA24552@schlenkerla.am.freescale.net>
 <9A229F04-DFC9-485D-AB06-B1A4F0AEB348@suse.de>
 <4F5100A0.8040802@freescale.com>
In-Reply-To: <4F5100A0.8040802@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 kvm list <kvm@vger.kernel.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 2, 2012 at 11:17 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 03/02/2012 10:30 AM, Alexander Graf wrote:
>>
>> On 02.03.2012, at 17:20, Scott Wood wrote:
>>
>>> On Fri, Mar 02, 2012 at 03:12:33PM +0100, Alexander Graf wrote:
>>>> When running inside a virtual machine, we can not modify timebase, so
>>>> let's just not call the functions for it then.
>>>>
>>>> This resolves hangs when booting e500 SMP guests on overcommitted host=
s.
>>>>
>>>> Reported-by: Stuart Yoder <B08248@freescale.com>
>>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>>> ---
>>>> arch/powerpc/platforms/85xx/smp.c | =A0 =A07 +++++++
>>>> 1 files changed, 7 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platform=
s/85xx/smp.c
>>>> index ff42490..d4b6c1f 100644
>>>> --- a/arch/powerpc/platforms/85xx/smp.c
>>>> +++ b/arch/powerpc/platforms/85xx/smp.c
>>>> @@ -249,6 +249,13 @@ void __init mpc85xx_smp_init(void)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.cause_ipi =3D doorbell_cause_ipi;
>>>> =A0 =A0 }
>>>>
>>>> + =A0 /* When running under a hypervisor, we can not modify tb */
>>>> + =A0 np =3D of_find_node_by_path("/hypervisor");
>>>> + =A0 if (np) {
>>>> + =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.give_timebase =3D NULL;
>>>> + =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.take_timebase =3D NULL;
>>>> + =A0 }
>>>> +
>>>> =A0 =A0 smp_ops =3D &smp_85xx_ops;
>>>
>>> Again, for 85xx we should *never* sync the timebase in the kernel,
>>> hypervisor or no.
>>
>> The code says "if the kexec config option is enabled, do the sync". I'm =
fairly sure it's there for a reason.
>
> Sigh. =A0I forgot about that. =A0It's because instead of doing kexec the
> simple way, we actually physically reset the core. =A0We really shouldn't
> do that. =A0And we *really* shouldn't do it just because CONFIG_KEXEC is
> defined, regardless of whether we're actually booting from kexec.

How would one rocver a core that's off in the weeds? We need to at
least stop it somehow before we restart into the kdump kernel. kexec
seems feasible since we have all the cores in a known state...

-M=
