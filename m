Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3376B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 17:37:34 +1000 (EST)
In-Reply-To: <05E77C6E-7465-4A0E-B00B-F1240417281D@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-25-git-send-email-agraf@suse.de>
	<EDF0A567-C440-4F1B-9AF5-2E0F8203D566@kernel.crashing.org>
	<05E77C6E-7465-4A0E-B00B-F1240417281D@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C30D5D4-189B-4DE7-B2FA-13190C003CCA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 24/26] KVM: PPC: PV mtmsrd L=0 and mtmsr
Date: Tue, 29 Jun 2010 09:37:29 +0200
To: Alexander Graf <agraf@suse.de>
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

>>> There is also a form of mtmsr where all bits need to be  
>>> addressed. While the
>>> PPC64 Linux kernel behaves resonably well here, the PPC32 one  
>>> never uses the
>>> L=1 form but does mtmsr even for simple things like only changing  
>>> EE.
>>
>> You make it sound like the 32-bit kernel does something stupid, while
>> there is no other choice.  The "L=1" thing only exists for 64-bit.
>
> Oh, so that's why :). That doesn't really change the fact that it's  
> very hard to distinguish between a mtmsr that only changes MSR_EE  
> vs one that changes MSR_IR for example :).

Hard to predict for the CPU as well, guess why there is a separate
instruction now :-P

By the way, L=1 _does_ exist for mtmsr; it's just that no 32-bit  
"classic"
implementations support it.


Segher
