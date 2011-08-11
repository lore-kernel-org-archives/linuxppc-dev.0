Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BD0EB7090
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 11:00:39 +1000 (EST)
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
	<4E37EB8C.8040408@suse.de>
	<20110810235818.GC5536@bloggs.ozlabs.ibm.com>
In-Reply-To: <20110810235818.GC5536@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <354F7A88-4E9B-4F49-AF01-34263D99F8D6@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] KVM: PPC: Assemble book3s{,
	_hv}_rmhandlers.S separately
Date: Thu, 11 Aug 2011 03:00:22 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





Am 11.08.2011 um 01:58 schrieb Paul Mackerras <paulus@samba.org>:

> On Tue, Aug 02, 2011 at 02:20:28PM +0200, Alexander Graf wrote:
>> On 07/23/2011 09:41 AM, Paul Mackerras wrote:
>>> This makes arch/powerpc/kvm/book3s_rmhandlers.S and
>>> arch/powerpc/kvm/book3s_hv_rmhandlers.S be assembled as
>>> separate compilation units rather than having them #included in
>>> arch/powerpc/kernel/exceptions-64s.S.  We no longer have any
>>> conditional branches between the exception prologs in
>>> exceptions-64s.S and the KVM handlers, so there is no need to
>>> keep their contents close together in the vmlinux image.
>>>=20
>>> In their current location, they are using up part of the limited
>>> space between the first-level interrupt handlers and the firmware
>>> NMI data area at offset 0x7000, and with some kernel configurations
>>> this area will overflow (e.g. allyesconfig), leading to an
>>> "attempt to .org backwards" error when compiling exceptions-64s.S.
>>>=20
>>> Moving them out requires that we add some #includes that the
>>> book3s_{,hv_}rmhandlers.S code was previously getting implicitly
>>> via exceptions-64s.S.
>>=20
>> So what if your kernel binary is bigger than the 24 bits we can jump
>> and the KVM code happens to be at the end? Or do we just not care
>> here?
>=20
> Actually we can jump +/- 32MB (26 bits).  I believe that the linker
> inserts trampolines if the branch target is more than 32MB away, so it
> should still work if the kernel is really large and the KVM code
> happens to be at the end.
>=20
> Stephen Rothwell has been asking me about this patch.  He wants it in
> (or something like it) so that he can get his daily linux-next powerpc
> allyesconfig builds to stop failing.

Yup, currently running autotest with this and other patches applied. Will se=
nd out a pullreq soon.


Alex

>=20
> Paul.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
