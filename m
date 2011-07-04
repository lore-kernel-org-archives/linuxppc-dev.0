Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80C76B6F74
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2011 21:36:12 +1000 (EST)
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4E11A293.2010505@redhat.com>
Date: Mon, 4 Jul 2011 13:36:02 +0200
Message-Id: <BC4ECEFA-15A4-49A9-AE53-9635F3F6F996@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de> <4E0C9339.2080601@redhat.com>
	<4E0C94A0.3090301@suse.de> <4E0C9D98.5000904@redhat.com>
	<2EDDAC02-4BDC-4007-82E1-2C6D732C24D5@suse.de>
	<4E102516.1040805@redhat.com>
	<70A08140-B592-4B2F-985B-D8E5C78C743B@suse.de>
	<4E102ECE.1060004@redhat.com>
	<CBE84140-B1FC-48B6-A000-77CB58C5F928@suse.de>
	<4E1030E1.6070101@redhat.com>
	<77E6DEE3-F00A-46EA-B8AF-58BC62A8143D@suse.de>
	<4E103270.4040506@redhat.com>
	<40F62A22-6A47-4414-8FF9-0534568353DA@suse.de>
	<4E11A293.2010505@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2011, at 13:22, Avi Kivity wrote:

> On 07/04/2011 01:59 PM, Alexander Graf wrote:
>> On 03.07.2011, at 11:12, Avi Kivity wrote:
>>=20
>> >  On 07/03/2011 12:09 PM, Alexander Graf wrote:
>> >>  >
>> >>  >   Right.  The idea is that if KVM_FLAG_BLAH implies a field =
kvm_struct::blah, then either both are present in the headers, or none  =
of them.
>> >>
>> >>  Yup, makes sense. I like the idea :). Gets rid of all the useless =
paddings and reserved fields. We could even truncate the structs that =
already have paddings in them if we only copy min(sizeof(real_struct), =
ioctl_passed_size); (which we should anyways).
>> >>
>> >
>> >  No, we can't change anything that is already out.  If will change =
the ioctl numbers, so building against new headers but running against =
an old kernel will fail.
>>=20
>> So this will only be enabled for completely new ioctls?
>=20
> Yes, unfortunately.
>=20
>> >
>> >>  How long until we get a patch set? :)
>> >
>> >  Well, I'd really like to get the qemu memory API out first.
>>=20
>> Can we add the ioctl without padding now then and add your awesome =
extensibility stuff to it later on?
>=20
> Yes.
>=20
>> We only have to make sure we don't actually release the intermediate =
steps as an upstream kernel then, right?
>=20
> What intermediate steps?  We can't add fields to the structure before =
we get the extensibility infrastructure, but that's all.

If we add it now without extensibility code, we will have a kernel that =
only knows the ioctl with the size as it is now. If we later add another =
field, the ioctl size changes which would render new user space running =
on that particular kernel to fail, because it doesn't have the "just =
truncate the ioctl param to the size" logic yet.


Alex
