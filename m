Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42AF01007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 06:36:12 +1100 (EST)
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F0B8B7D.4@freescale.com>
Date: Wed, 15 Feb 2012 20:36:07 +0100
Message-Id: <ADC42EDC-6F11-419E-9F31-B9E23D80FFE1@suse.de>
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.01.2012, at 01:51, Scott Wood wrote:

> On 01/09/2012 11:46 AM, Alexander Graf wrote:
>>=20
>> On 21.12.2011, at 02:34, Scott Wood wrote:
>=20

[...]

>>> Current issues include:
>>> - Machine checks from guest state are not routed to the host =
handler.
>>> - The guest can cause a host oops by executing an emulated =
instruction
>>>  in a page that lacks read permission.  Existing e500/4xx support =
has
>>>  the same problem.
>>=20
>> We solve that in book3s pr by doing
>>=20
>>  LAST_INST =3D <known bad value>;
>>  PACA->kvm_mode =3D <recover at next inst>;
>>  lwz(guest pc);
>>  do_more_stuff();
>>=20
>> That way when an exception occurs at lwz() the DO_KVM handler checks =
that we're in kvm mode "recover" which does basically srr0+=3D4; rfi;.
>=20
> I was thinking we'd check ESR[EPID] or SRR1[IS] as appropriate, and
> treat it as a kernel fault (search exception table) -- but this works
> too and is a bit cleaner (could be other uses of external pid), at the
> expense of a couple extra instructions in the emulation path (but
> probably a slightly faster host TLB handler).
>=20
> The check wouldn't go in DO_KVM, though, since on bookehv that only
> deals with diverting flow when xSRR1[GS] is set, which wouldn't be the
> case here.

Thinking about it a bit more, how is this different from a failed =
get_user()? We can just use the same fixup mechanism as there, right?

Alex
