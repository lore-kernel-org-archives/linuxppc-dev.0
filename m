Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19B55B6F64
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jul 2011 19:09:30 +1000 (EST)
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4E1030E1.6070101@redhat.com>
Date: Sun, 3 Jul 2011 11:09:21 +0200
Message-Id: <77E6DEE3-F00A-46EA-B8AF-58BC62A8143D@suse.de>
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


On 03.07.2011, at 11:05, Avi Kivity wrote:

> On 07/03/2011 12:00 PM, Alexander Graf wrote:
>> >>          }
>> >>
>> >>  Otherwise we might write over data the user expected. And that =
logic that tells to copy_to_user how much data it actually takes to put =
all the information in is not there today and would have to be added. =
You can even verify that required_size with the ioctl passed size to =
make 100% sure user space is sane, but I'd claim that a feature bitmap =
is plenty of information to ensure that we're not doing something =
stupid.
>> >
>> >  I don't see why we have to caclulate something, then verify it =
against the correct answer.
>>=20
>> Ah, I think I'm grasping your idea. You'd simply truncate the =
resulting struct according to the size passed by the ioctl and call it a =
day. Well, that works too. User space simply wouldn't be able to know if =
all information actually fit into the struct, but I guess that's fine =
:).
>>=20
>=20
> Right.  The idea is that if KVM_FLAG_BLAH implies a field =
kvm_struct::blah, then either both are present in the headers, or none  =
of them.

Yup, makes sense. I like the idea :). Gets rid of all the useless =
paddings and reserved fields. We could even truncate the structs that =
already have paddings in them if we only copy min(sizeof(real_struct), =
ioctl_passed_size); (which we should anyways).

How long until we get a patch set? :)


Alex
