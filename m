Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60B0BB71E4
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:49:41 +1000 (EST)
Message-ID: <4E41651F.7010508@suse.de>
Date: Tue, 09 Aug 2011 18:49:35 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 00/10] PAPR virtualization on PR KVM
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<4E41638A.2010707@redhat.com>
In-Reply-To: <4E41638A.2010707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 06:42 PM, Avi Kivity wrote:
> On 08/09/2011 07:31 PM, Alexander Graf wrote:
>> In KVM for Book3S PPC we currently have 2 implementations. There
>> is the PR based implementation which works on any POWER system
>> you pass in and the super fast HV implementation which requires
>> libre firmware (so almost nobody can use it).
>
> Did you mean, non-libre?

No, I did mean libre :). Usually firmware on IBM POWER systems already 
uses the hypervisor mode for itself, so we can't leverage it. The only 
system that is publicly available and can run HV KVM is the YDL 
PowerStation which is running SLOF, an open source firmware.

>
>>
>> Currently, the two target two different machine types, with PR KVM
>> being used for bare metal system virtualization, while the HV KVM
>> is used to virtualize PAPR.
>>
>> In an effort to make things more cozy and transparent to the user,
>> this patch set implements PAPR capabilities to the PR KVM side, so
>> a user doesn't have to worry what the respective kernel module
>> supports. Any machine he's virtualizing "just works".
>>
>
> Nice.  I went though it and nothing shouted "I'm wrong, kill me 
> please", though I don't claim to understand more than 5% of it.

Heh :). The thing giving me the most headaches here is the ENABLE_CAP 
part on PAPR. I'd love to have a more flexible framework there that can 
configure kvm into the right mode of operation completely, so we get the 
chance of passing back "Sorry, that mode doesn't work for me" at the end 
of the day.

But I guess we can just do that with the cap enablings too. It's just 
slightly more icky.


Alex
