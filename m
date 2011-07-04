Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32A7EB6F76
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2011 21:41:27 +1000 (EST)
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4E11A611.3010904@redhat.com>
Date: Mon, 4 Jul 2011 13:41:20 +0200
Message-Id: <ACE6741B-F502-4426-8940-1FDDCCB2AD52@suse.de>
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
	<BC4ECEFA-15A4-49A9-AE53-9635F3F6F996@suse.de>
	<4E11A611.3010904@redhat.com>
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


On 04.07.2011, at 13:37, Avi Kivity wrote:

> On 07/04/2011 02:36 PM, Alexander Graf wrote:
>> >
>> >  What intermediate steps?  We can't add fields to the structure =
before we get the extensibility infrastructure, but that's all.
>>=20
>> If we add it now without extensibility code, we will have a kernel =
that only knows the ioctl with the size as it is now. If we later add =
another field, the ioctl size changes which would render new user space =
running on that particular kernel to fail, because it doesn't have the =
"just truncate the ioctl param to the size" logic yet.
>=20
> You're right.  So let's add the padding now, and only use the great =
new stuff after it's actually in.
>=20
> Working ugly is better than broken pretty.

Hrm. Too bad :).


Alex
