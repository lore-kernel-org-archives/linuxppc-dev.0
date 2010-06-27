Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55FB2B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:38:26 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-3-git-send-email-agraf@suse.de>
	<4C2708EB.9020500@redhat.com>
Message-Id: <651805F1-54AB-466F-8D23-D053D8082177@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C2708EB.9020500@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 02/26] KVM: PPC: Convert MSR to shared page
Date: Sun, 27 Jun 2010 11:38:43 +0200
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


Am 27.06.2010 um 10:16 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>> One of the most obvious registers to share with the guest directly  
>> is the
>> MSR. The MSR contains the "interrupts enabled" flag which the guest  
>> has to
>> toggle in critical sections.
>>
>> So in order to bring the overhead of interrupt en- and disabling  
>> down, let's
>> put msr into the shared page. Keep in mind that even though you can  
>> fully read
>> its contents, writing to it doesn't always update all state. There  
>> are a few
>> safe fields that don't require hypervisor interaction. See the guest
>> implementation that follows later for reference.
>>
>
>
> You mean, see the documentation for reference.
>
> It should be possible to write the guest code looking only at the  
> documentation.

*shrug* since we're writing open source I don't mind telling people to  
read code for a reference implemenration. If well written, that's more  
comprehensible than documentation anyways :).

But either way, you can take a look at both - documentation and code,  
yes.

What I really meant here is that the list of registers we patch should  
be taken from the patch code. I didn't want to write out all of them  
in the description.


Alex
