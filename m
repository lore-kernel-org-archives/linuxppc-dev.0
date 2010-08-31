Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC5CAB70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 10:56:46 +1000 (EST)
Subject: Re: [PATCH 13/26] KVM: PPC: Add feature bitmap for magic page
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C715382.6050809@redhat.com>
Date: Tue, 31 Aug 2010 02:56:38 +0200
Message-Id: <FAAE3BB9-E58E-4319-903A-B6C25D88D0E3@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
	<1282053481-18787-14-git-send-email-agraf@suse.de>
	<4C715382.6050809@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 22.08.2010, at 18:42, Avi Kivity wrote:

> On 08/17/2010 04:57 PM, Alexander Graf wrote:
>> We will soon add SR PV support to the shared page, so we need some
>> infrastructure that allows the guest to query for features KVM =
exports.
>>=20
>> This patch adds a second return value to the magic mapping that
>> indicated to the guest which features are available.
>>=20
>=20
> You need to make that feature controllable from userspace, to allow =
new->old save/restore.

Good one :). We're still missing too much stuff to even run without =
losing interrupts yet and you're thinking about new->old save/restore. =
Who'd want to migrate onto a system that's broken anyways? Besides - =
we're missing too many register values from the kernel side to even be =
able to perform a migration.

I'm planning to add migration, probably after SMP. But that will be =
another CAP and anything before that won't be able to save/restore.


Alex
