Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ED443B70B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 20:29:41 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled
 by KEXEC patch
Date: Tue, 22 Nov 2011 09:29:02 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052D942C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
 <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
 <20111118180114.GB28562@schlenkerla.am.freescale.net>
In-Reply-To: <20111118180114.GB28562@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled
>by KEXEC patch
>
>On Fri, Nov 18, 2011 at 08:35:02AM -0600, Kumar Gala wrote:
>>
>> On Nov 16, 2011, at 12:42 PM, Scott Wood wrote:
>>
>> > On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
>> >> From: Li Yang <leoli@freescale.com>
>> >>
>> >> The timebase sync is not only necessary when using KEXEC. It should
>also
>> >> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>> >> the KEXEC patch.
>> >
>> > Again, no it should not be used by normal boot up (whether KEXEC
>support
>> > is enabled or not).  We should only do timebase sync when we actually
>> > need to (when we've actually just reset a core), and we should do it
>the
>> > way U-Boot does rather than with smp-tbsync.c.

While looking into the timebase sync code in u-boot, I have a few questions=
.

        /* enable time base at the platform */
        if (whoami)
                devdisr |=3D MPC85xx_DEVDISR_TB1;
        else
                devdisr |=3D MPC85xx_DEVDISR_TB0;
        out_be32(&gur->devdisr, devdisr);

        /* readback to sync write */
        in_be32(&gur->devdisr);

        mtspr(SPRN_TBWU, 0);
        mtspr(SPRN_TBWL, 0);

What are the TBWU/TBWL registers?  I can't find the definition of them in e=
ither e500 RM or booke RM.  Are they valid to be used?  What is the result =
of writing to them?  Aren't the SPR registers core specific?  How can we se=
t the TB for the other cores?

        devdisr &=3D ~(MPC85xx_DEVDISR_TB0 | MPC85xx_DEVDISR_TB1);
        out_be32(&gur->devdisr, devdisr);

Also in the UM, I read "Blocks disabled by DEVDISR must not be re-enabled w=
ithout a hard reset."  Is it safe we enable it here?

- Leo
