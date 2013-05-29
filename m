Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C64A2C032A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 10:20:49 +1000 (EST)
Received: by mail-pa0-f49.google.com with SMTP id bi5so8481595pad.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 17:20:47 -0700 (PDT)
Message-ID: <51A549D9.3080605@ozlabs.ru>
Date: Wed, 29 May 2013 10:20:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1369758773.18630.1@snotra>
In-Reply-To: <1369758773.18630.1@snotra>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2013 02:32 AM, Scott Wood wrote:
> On 05/24/2013 09:45:24 PM, David Gibson wrote:
>> On Wed, May 22, 2013 at 04:06:57PM -0500, Scott Wood wrote:
>> > On 05/20/2013 10:06:46 PM, Alexey Kardashevskiy wrote:
>> > >diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> > >index 8465c2a..da6bf61 100644
>> > >--- a/arch/powerpc/kvm/powerpc.c
>> > >@@ -396,6 +396,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>> > >+++ b/arch/powerpc/kvm/powerpc.c
>> > >         break;
>> > > #endif
>> > >     case KVM_CAP_SPAPR_MULTITCE:
>> > >+    case KVM_CAP_SPAPR_TCE_IOMMU:
>> > >         r = 1;
>> > >         break;
>> > >     default:
>> >
>> > Don't advertise SPAPR capabilities if it's not book3s -- and
>> > probably there's some additional limitation that would be
>> > appropriate.
>>
>> So, in the case of MULTITCE, that's not quite right.  PR KVM can
>> emulate a PAPR system on a BookE machine, and there's no reason not to
>> allow TCE acceleration as well.
> 
> That might (or might not; consider things like Altivec versus SPE opcode
> conflict, whether unimplemented SPRs trap, behavior of unprivileged
> SPRs/instructions, etc) be true in theory, but it's not currently a
> supported configuration.  BookE KVM does not support emulating a different
> CPU than the host.  In the unlikely case that ever changes to the point of
> allowing PAPR guests on a BookE host, then we can revisit how to properly
> determine whether the capability is supported, but for now the capability
> will never be valid in the CONFIG_BOOKE case (though I'd rather see it
> depend on an appropriate book3s symbol than depend on !BOOKE).
> 
> Or we could just leave it as is, and let it indicate whether the host
> kernel supports the feature in general, with the user needing to understand
> when it's applicable...  I'm a bit confused by the documentation, however
> -- the MULTITCE capability was documented in the "capabilities that can be
> enabled" section, but I don't see where it can be enabled.


True, it cannot be enabled (but it could be enabled a long time ago), it is
either supported or not, I'll fix the documentation. Thanks!


-- 
Alexey
