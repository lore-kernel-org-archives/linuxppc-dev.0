Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65D64B702E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 03:05:04 +1100 (EST)
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3F607A5180246847A760FD34122A1E052D942C@039-SN1MPN1-003.039d.mgd.msft.net>
Date: Tue, 22 Nov 2011 10:05:01 -0600
Message-Id: <8EA45BB6-57D4-4C3C-98A9-F1C252FD0714@kernel.crashing.org>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
 <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
 <20111118180114.GB28562@schlenkerla.am.freescale.net>
 <3F607A5180246847A760FD34122A1E052D942C@039-SN1MPN1-003.039d.mgd.msft.net>
To: Li Yang-R58472 <r58472@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 22, 2011, at 3:29 AM, Li Yang-R58472 wrote:

>> Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync =
disabled
>> by KEXEC patch
>>=20
>> On Fri, Nov 18, 2011 at 08:35:02AM -0600, Kumar Gala wrote:
>>>=20
>>> On Nov 16, 2011, at 12:42 PM, Scott Wood wrote:
>>>=20
>>>> On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
>>>>> From: Li Yang <leoli@freescale.com>
>>>>>=20
>>>>> The timebase sync is not only necessary when using KEXEC. It =
should
>> also
>>>>> be used by normal boot up and cpu hotplug. Remove the ifdef added =
by
>>>>> the KEXEC patch.
>>>>=20
>>>> Again, no it should not be used by normal boot up (whether KEXEC
>> support
>>>> is enabled or not).  We should only do timebase sync when we =
actually
>>>> need to (when we've actually just reset a core), and we should do =
it
>> the
>>>> way U-Boot does rather than with smp-tbsync.c.
>=20
> While looking into the timebase sync code in u-boot, I have a few =
questions.
>=20
>        /* enable time base at the platform */
>        if (whoami)
>                devdisr |=3D MPC85xx_DEVDISR_TB1;
>        else
>                devdisr |=3D MPC85xx_DEVDISR_TB0;
>        out_be32(&gur->devdisr, devdisr);
>=20
>        /* readback to sync write */
>        in_be32(&gur->devdisr);
>=20
>        mtspr(SPRN_TBWU, 0);
>        mtspr(SPRN_TBWL, 0);
>=20
> What are the TBWU/TBWL registers?  I can't find the definition of them =
in either e500 RM or booke RM.  Are they valid to be used?  What is the =
result of writing to them?  Aren't the SPR registers core specific?  How =
can we set the TB for the other cores?

TBWU/TBWL are SPR 284/285 (they might be called something a little =
different in the manual).

You can only set the TB on the core itself.  The way the u-boot code =
works is it sets TBL/TBU (TB) to 0 in release.S for secondary cores.  In =
the code you reference we are setting TB on the 'master' core to 0 since =
we turned TB on earlier for the master core and now are resetting it to =
0 to sync all the cores.

>=20
>        devdisr &=3D ~(MPC85xx_DEVDISR_TB0 | MPC85xx_DEVDISR_TB1);
>        out_be32(&gur->devdisr, devdisr);
>=20
> Also in the UM, I read "Blocks disabled by DEVDISR must not be =
re-enabled without a hard reset."  Is it safe we enable it here?

Yes this is safe, TB isn't truly a block.  Manual should technically be =
updated to exclude TB.

- k=
