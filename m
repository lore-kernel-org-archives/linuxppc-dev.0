Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8BFBB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:49:32 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-27-git-send-email-agraf@suse.de>
	<4C270CFE.2040600@redhat.com>
Message-Id: <0066CB6A-917A-42F0-93AA-E0934D15096A@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C270CFE.2040600@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
Date: Sun, 27 Jun 2010 11:49:43 +0200
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


Am 27.06.2010 um 10:34 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:25 AM, Alexander Graf wrote:
>> We just introduced a new PV interface that screams for  
>> documentation. So here
>> it is - a shiny new and awesome text file describing the internal  
>> works of
>> the PPC KVM paravirtual interface.
>>
>>
>> +Querying for existence
>> +======================
>> +
>> +To find out if we're running on KVM or not, we overlay the PVR  
>> register. Usually
>> +the PVR register contains an id that identifies your CPU type. If,  
>> however, you
>> +pass KVM_PVR_PARA in the register that you want the PVR result in,  
>> the register
>> +still contains KVM_PVR_PARA after the mfpvr call.
>> +
>> +    LOAD_REG_IMM(r5, KVM_PVR_PARA)
>> +    mfpvr    r5
>> +    [r5 still contains KVM_PVR_PARA]
>> +
>> +Once determined to run under a PV capable KVM, you can now use  
>> hypercalls as
>> +described below.
>>
>
> On x86 we allow host userspace to determine whether the guest sees  
> the paravirt interface (and what features are exposed).  This allows  
> you to live migrate from a newer host to an older host, by not  
> exposing the newer features.

A very good idea indeed. Let's postpone that to when we expose enough  
state to make live migration possible.

Alex
