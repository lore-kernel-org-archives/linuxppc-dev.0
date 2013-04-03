Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A87972C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 10:23:37 +1100 (EST)
Date: Wed, 3 Apr 2013 18:23:28 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH v3 5/6] kvm/ppc/mpic: in-kernel MPIC emulation
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <1365026850.25627.16@snotra> (from scottwood@freescale.com on
 Wed Apr  3 17:07:30 2013)
Message-ID: <1365031408.25627.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, "<paulus@samba.org>" <paulus@samba.org>,
 Alexander Graf <agraf@suse.de>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2013 05:07:30 PM, Scott Wood wrote:
> On 04/03/2013 04:58:56 PM, Alexander Graf wrote:
>>=20
>>=20
>> Am 03.04.2013 um 23:38 schrieb Scott Wood <scottwood@freescale.com>:
>>=20
>> > On 04/03/2013 11:19:42 AM, Alexander Graf wrote:
>> >> On 03.04.2013, at 03:57, Scott Wood wrote:
>> >> > +    switch (attr->group) {
>> >> > +    case KVM_DEV_MPIC_GRP_MISC:
>> >> > +        switch (attr->attr) {
>> >> > +        case KVM_DEV_MPIC_BASE_ADDR:
>> >> > +            mutex_lock(&opp->kvm->slots_lock);
>> >> > +            attr64 =3D opp->reg_base;
>> >> > +            mutex_unlock(&opp->kvm->slots_lock);
>> >> > +
>> >> > +            if (copy_to_user((u64 __user *)(long)attr->addr,
>> >> > +                     &attr64, sizeof(u64)))
>> >> u64 is tricky with put_user on 32bit hosts, so here copy_to_user =20
>> makes sense
>> >
>> > What are the issues with put_user?  It looks like it's supported =20
>> with a pair of "stw" instructions.
>>=20
>> Oh? Last time I tried to use get/put_user for one_reg it failed on =20
>> ppc32. So maybe the u64 support is new?
>=20
> Not new according to git -- though I haven't tried to use it yet; =20
> maybe it's broken.

Yeah, it's broken. :-P

__get_user_size() looks OK, but __get_user_check/nocheck() goes through =20
an intermediary "unsigned long __gu_val".

There's a separate __get_user64_nocheck() that uses "long long", but no =20
"check" variant, no "put", and it's only available in 32-bit builds.  =20
And it's not used anywhere (barring ungreppable token-pasting magic).  =20
Sigh.

-Scott=
