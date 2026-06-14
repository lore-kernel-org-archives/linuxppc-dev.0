Return-Path: <linuxppc-dev+bounces-22614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E37CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 04:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdxvM54vRz3bqD;
	Mon, 15 Jun 2026 14:28:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=152.66.115.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781469753;
	cv=none; b=CId0WFva8VjV5VOpGQlSD/tqw1sctcOEvdVaecqFwsbxtvu/Yr/VPQEQQELFqg3pWzahIVEqXbhezpwAOCJ2HCDflaeoxvmAtRI7e/RhFMfBcUWpQbNH97PnPayzwfiiIZfqH3vJ1Aep0djbp5fS2V1J0jdgwAGtVPUSu+RM6avs+xR1Cx/VFJQhZ3kDWR3doPceyU0JiZfdo7ld3vPVWkG0upySJMkiBoInsUddCe5Lc8B52BcfEM4z9oNhRs5VKAapPAZ13pIvgE9WU7rd99mVLe1inmk3eBL2f0NAdSOjJb/LoeHSyui+juXWM17+fFzwWcBcgDmwJ2Je2bv98w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781469753; c=relaxed/relaxed;
	bh=YULG7w4wJ39NNUVSvI6EOpjSUYXWwAY90cURpKSz348=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AG5KOaAjBcU573muptgpnwoAyioaDFkK/cP+gAuIW9fh08U0kesXhW7MBWdqWSQwIRj3eLRIaax+UJRlmBRMuOr8HJj+JK5wOGvGrUvIJ1z/5STgZDYXYY0vSurJEi3njOadd8d7BNvW7ai5BPng0geHkmmS0vAh4Hsdv6t1FpOgLx+n6xNGCaGR4X4+TU+Tx5KS/vm02lGLHrRO2be4vgTpf2sBp+1NVyaVwWJQ4ncDrh7/Re+0JoSGtr0bLWQx7ZTvRaIPd9Q+usXwUoB9xqnebbi4iS+Ozp0O5zjJcJNG2dqeesEzyok61mPjRepzABapQEC3nz4s3BOIQDqY9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org) smtp.mailfrom=eik.bme.hu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=eik.bme.hu (client-ip=152.66.115.2; helo=zero.eik.bme.hu; envelope-from=balaton@eik.bme.hu; receiver=lists.ozlabs.org)
X-Greylist: delayed 409 seconds by postgrey-1.37 at boromir; Mon, 15 Jun 2026 06:42:31 AEST
Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdlYg2Mx9z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 06:42:31 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 9FA04596948;
	Sun, 14 Jun 2026 22:35:36 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZsID2rzwcMKI; Sun, 14 Jun 2026 22:35:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 0D8DB596945; Sun, 14 Jun 2026 22:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 0BD0A5968DE;
	Sun, 14 Jun 2026 22:35:33 +0200 (CEST)
Date: Sun, 14 Jun 2026 22:35:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
In-Reply-To: <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
Message-ID: <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com> <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu> <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-229711801-1781469333=:75274"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-229711801-1781469333=:75274
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:
> вс, 14 июн. 2026 г., 17:29 BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:
>>> I tried qemu 10.0.10 (qemu-system-ppc) compiled as ppc32 binary - fail
>>>
>>> I tried qemu 2.2.0 compiled as ppc64 binary (qemu-system-ppc and ppc64
>>> variants) -fail
>>>
>>> I tried qemu 5.0.0 compiled as 32bit ppc (qemu-system-ppc) - fail.
>>>
>>> I tried qemu 6.1.1 compiled as 32bit ppc binary - qemu-system-ppc. Fail.
>>>
>>> I tried recompiling host kernel without preemtion - still fail.
>>>
>>> :(
>>>
>>> fail like this in dmesg
>>>
>>> [75573.287328] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>>>                        [75573.287334] kvmppc_exit_pr_progint: emulation
>> at
>>> 100 failed (00000000)
>>>
>>>
>>> lscpu output:
>>> Architecture:                ppc64
>>>
>>> CPU op-mode(s):            32-bit, 64-bit
>>> Byte Order:                Big Endian
>>> CPU(s):                      2
>>>
>>> On-line CPU(s) list:       0,1
>>>
>>> Model name:                  PPC970MP, altivec supported
>>> Model:                     1.1 (pvr 0044 0101)
>> [...]
>>> Why so old qemu? Well, it worked on OSX Leopard 10.5.8 on same machine,
>> so
>>> I compiled it as 64bit ppc64 binary - new qemu grow a lot  ... and
>> keeping
>>> effectively 3 different dev systems makes this 160 gb hdd look small :)
>>
>> I don't know about it but I think the only combination that ever worked
>> was ppc on ppc (i.e. KVM on G4 Macs) or maybe ppc64 on ppc64. Running ppc
>> on ppc64 is known not to work and I haven't heard about anybody fixing
>> that. There was a blog entry about running MacOS on Power10:

Actually I meant POWER9 not POWER10.

>> https://www.talospace.com/2018/08/making-your-talos-ii-into-power-mac_29.html
>> but I think that was on ppc64le (which does not work on G5 as that's big
>> endian only) and you still needed a guest kernel that could handle the G5
>> due to different cache line size that affects at least dcbz which is used
>> to clear memory so unless that's correctly emulated by KVM it may clear
>> more bytes than intended and break.
>>
>
> https://forum.hyperion-entertainment.com/viewtopic.php?t=4736&start=1410
>
> I thought this picture showed ppc64 kernel at host (not mac, neo amiga) and
> qemu-system-ppc with non-obvious bitness?

But that's BookE e500 not the BookS POWER4 variant G5 you have so KVM may 
work differently on that and maybe it even has HV which probably works 
better than PR. I think KVM was used on G4, e500 and newer POWER mostly 
with HV but I'm not sure if KVM PR on G5 was ever well supported. Did you 
try running the same Linux version that you have on your host under KVM PR 
first to verify that at least that works? I think that's where everybody 
should start with KVM before trying to boot other guest OSes.

>> So considering the above, what may work is if you run a 32 bit ppc kernel
>> (G4 version) on your G5 for the host not using it as 64 bit instead of
>> ppc64 kernel and try a guest kernel that detects G5 CPU and knows how to
>> handle the different cache line size.
>
>
> Are you saying 32bit *Linux* ppc kvm as host can handle 64bit guest kernel ?

No I meant trying a 32 bit host with 32 bit guest but the cache line size 
issue may still get in the way so maybe this does not help but for 
debugging may worth a try.

> I am not ever sure firmware here can load 32bit ppc Linux .. I'll try of
> course.

Since G5 is backwards compatible with PPC32 maybe it should work but I 
know nothing about real PowerPC machines.

> Or find and fix the emulation of
>> different instructions on ppc64 in Linux KVM when running 32 bit ppc code
>> on 64 but host. There supposed to be some support for that but maybe it's
>> broken or never finished.
>>
>> But as I said I don't know this and don't have PPC hardware to try, nor
>> interest to do it so it's just my understanding and guess, which may be
>> wrong, but that's probably where you should start looking. Hopefully there
>> are others here with more knowledge about it or who want to look at it.
>> You should also look at how to enable KVM debug logs in Linux kernel and
>> see if you get any errors in the syslog. The usual QEMU debug options are
>> not that helpful with KVM and you should look for KVM logs instead.
>>
>
> In theory I subscribed to linux-ppc (kernel) list. May be I should cc them
> ? (added to cc)
>
> I tried kvm-unit-tests but they apparently require qemu (to my surprise!)
> and mostly focus on pseries / kvm HV (not surprisingly)?
>
> Is there anything smaller to test kvm_pr specifically?
>
> I even tried to d/l svn version of Mac on Linux but this one failed to
> compile with gcc 15.
>
> svn checkout svn://svn.code.sf.net/p/mac-on-linux/code/trunk
> mac-on-linux-code

I think you may have better luck trying an older Linux distro from the 
time this was still used and had MoL as a package as that may have been 
tested back then on real machines and used to work. Anything newer is 
likely untested and thus could be broken without anybody noticing and 
fixing it so finding something older that worked at least would give a 
baseline to find regressions against.

Regards,
BALATON Zoltan
--3866299591-229711801-1781469333=:75274--

