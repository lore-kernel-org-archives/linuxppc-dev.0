Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E55B7B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:40:01 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
	<4C2709F4.10805@redhat.com>
Message-Id: <77DBE095-884F-4986-BE2B-15B2EEAD8CAC@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C2709F4.10805@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
Date: Sun, 27 Jun 2010 11:40:21 +0200
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 27.06.2010 um 10:21 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>> When running in hooked code we need a way to disable interrupts  
>> without
>> clobbering any interrupts or exiting out to the hypervisor.
>>
>> To achieve this, we have an additional critical field in the shared  
>> page. If
>> that field is equal to the r1 register of the guest, it tells the  
>> hypervisor
>> that we're in such a critical section and thus may not receive any  
>> interrupts.
>>
>
> Is r1 reserved for this purpose?  Can't it match accidentally?

r1 is defined by the abi to be the stack.

>
> Why won't zero/nonzero work for this?

Because there is no store immediate opcode on powerpc :(.

Alex
