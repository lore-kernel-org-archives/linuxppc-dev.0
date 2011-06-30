Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B08D4B6F18
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 02:34:54 +1000 (EST)
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de> <4E0C9339.2080601@redhat.com>
	<4E0C94A0.3090301@suse.de> <4E0C9D98.5000904@redhat.com>
In-Reply-To: <4E0C9D98.5000904@redhat.com>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <2EDDAC02-4BDC-4007-82E1-2C6D732C24D5@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Date: Thu, 30 Jun 2011 18:33:21 +0200
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


On 30.06.2011, at 18:00, Avi Kivity <avi@redhat.com> wrote:

> On 06/30/2011 06:22 PM, Alexander Graf wrote:
>>> Regarding that.  There's another option - the ioctl code embeds the stru=
cture size.  So if we extend the ioctl parsing to pad up (or truncate down) f=
rom the user's size to our size, and similarly in the other direction, we ca=
n get away from this ugliness.
>>>=20
>>> Some years ago I posted a generic helper that did this (and also kmalloc=
'ed and kfree'd the data itself), but it wasn't received favourably.  Maybe I=
 should try again (and we can possibly use it in kvm even if it is rejected f=
or general use, though that's against our principles of pushing all generic i=
nfrastructure to the wider kernel).
>>=20
>>=20
>> That does sound interesting, but requires a lot more thought to be put in=
to the actual code, as we basically need to read out the feature bitmap, the=
n provide a minimum size for the chosen features and then decide if they fit=
 in.
>=20
>=20
> Why? just put the things you want in the structure.
>=20
> old userspace -> new kernel: we auto-zero the parts userspace left out, an=
d zero means old behaviour, so everthing works
> new userspace -> old kernel: truncate.  Userspace shouldn't have used any n=
ew features (KVM_CAP), and we can -EINVAL if the truncated section contains a=
 nonzero bit.

Yup, which requires knowledge in the code on what actually fits :). Logic we=
 don't have today.


Alex
