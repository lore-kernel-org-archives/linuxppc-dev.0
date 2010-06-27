Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC7F1B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:41:26 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-10-git-send-email-agraf@suse.de>
	<4C270A34.4020706@redhat.com>
Message-Id: <27BB673F-F34E-4CC6-A22D-02CF95E7529F@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C270A34.4020706@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 09/26] KVM: PPC: Add PV guest scratch registers
Date: Sun, 27 Jun 2010 11:41:49 +0200
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


Am 27.06.2010 um 10:22 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>> While running in hooked code we need to store register contents out  
>> because
>> we must not clobber any registers.
>>
>> So let's add some fields to the shared page we can just happily  
>> write to.
>>
>>
>
> How are these protected during interrupts?

By the 'critical section' bit. When in a critical section (read: using  
scratch registers), we don't issue interrupts.

Alex
