Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D552FB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:50:32 +1000 (EST)
Message-ID: <4C271EE5.1060401@redhat.com>
Date: Sun, 27 Jun 2010 12:50:29 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 02/26] KVM: PPC: Convert MSR to shared page
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-3-git-send-email-agraf@suse.de>
	<4C2708EB.9020500@redhat.com>
	<651805F1-54AB-466F-8D23-D053D8082177@suse.de>
In-Reply-To: <651805F1-54AB-466F-8D23-D053D8082177@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/27/2010 12:38 PM, Alexander Graf wrote:
>
> Am 27.06.2010 um 10:16 schrieb Avi Kivity <avi@redhat.com>:
>
>> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>>> One of the most obvious registers to share with the guest directly 
>>> is the
>>> MSR. The MSR contains the "interrupts enabled" flag which the guest 
>>> has to
>>> toggle in critical sections.
>>>
>>> So in order to bring the overhead of interrupt en- and disabling 
>>> down, let's
>>> put msr into the shared page. Keep in mind that even though you can 
>>> fully read
>>> its contents, writing to it doesn't always update all state. There 
>>> are a few
>>> safe fields that don't require hypervisor interaction. See the guest
>>> implementation that follows later for reference.
>>>
>>
>>
>> You mean, see the documentation for reference.
>>
>> It should be possible to write the guest code looking only at the 
>> documentation.
>
> *shrug* since we're writing open source I don't mind telling people to 
> read code for a reference implemenration. 

It's impossible to infer from the source what's a guaranteed part of the 
interface and what is just an implementation artifact.  So people rely 
on implementation artifacts (or even bugs) and that reduces our ability 
to change things.

> If well written, that's more comprehensible than documentation anyways 
> :).

If the documentation is poorly written, yes.

-- 
error compiling committee.c: too many arguments to function
