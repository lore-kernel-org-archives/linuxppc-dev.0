Return-Path: <linuxppc-dev+bounces-25638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA0FC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 05:34:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH8q14LnQz2xd2;
	Sat, 08 Aug 2026 15:34:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786167293;
	cv=none; b=ijJgaJz2BP+8HgBHgDNZJRMOy8/TP+CD7GJUvxv8DD7pNr55McJEkc7tecgO/CR/9FnNlwwLeA+0WOvpK5dB2fFE7wIQnEtwvS/fXOoc3LQiU/z0MWpQAAcqncv0n0dOwIRVp2d3iFAndqGwzIk1hPC18Umvd4ZYfMR1n8EBOrv2gJZiJ5ddSkRMxZWuEynExkJFvuZSuYFuCPUmYvWuC9URgJlvleXRllMY2JyL3kTen/8yixDVp/Ts4zDa2KWglRpbSFbCQZCIIrhrnuZCBUJdo5GFi3xvIcLoqqrBRUJUBGzsa1k/fs9/bBsz62LFnjLj7Zci8ivq8OTJrvsarA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786167293; c=relaxed/relaxed;
	bh=ePb+1uER1o8S/phXCI+oFAneLanYIRRt9Azm9hq5/IM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YUzjGrlRLzdudwVOfhfoXYhJAY1DQQOEOVFds6j7w9TTqUunCxgJ2CKgCMHqRAl7Fcjz6/BgmTLEZo7hdjnmhBaqpFNFJyEpMo3aAIdFNzh4S09yfUq8PBw0FC6NwbByEv5Mc0Y8DAUbnMyWmbIQ1oD/vfCQWnNMoZb0SPxmAIC9S4q3lJum5QuhIdP5QoM+pwHw186EPq6VHFeWZ/eH4bYZEBZUASGa97RO5kDgFqra8Eh3BLdRPDln+qe6kpBff/TF/l9MFlIsQnIn/p3hh2zyWn1bUTdNQ166kox8/Q7BCVx8NgIhDGd33V49Xlvgojwh8zbB28AJI3zywhl+iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=Jr98evV/; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=Jr98evV/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH8q04zkmz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 15:34:52 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 77A047790E32;
	Sat,  8 Aug 2026 00:34:50 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RWaLKJ7cLKBk; Sat,  8 Aug 2026 00:34:49 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 752917790E4B;
	Sat,  8 Aug 2026 00:34:49 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 752917790E4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786167289; bh=ePb+1uER1o8S/phXCI+oFAneLanYIRRt9Azm9hq5/IM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Jr98evV/IMYy/9TNFOvrJ/JdCQCG43uXWoPeMph5A02OiNCfcY9R60vgtNVkaoWTi
	 XGYM2aBadCL26L8HcV/1O+LKyTQ14Va7Cr1qVjMLS0/gIYjOOXQxhbuFqN1b8lh9c1
	 IhfcGbu+VAjdJGk2lsuT3fxYd0ybNbUK0m8aMsVo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iAYXqNoAj2k5; Sat,  8 Aug 2026 00:34:49 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3EE057790BB2;
	Sat,  8 Aug 2026 00:34:49 -0500 (CDT)
Date: Sat, 8 Aug 2026 00:34:44 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	Gaurav Batra <gbatra@linux.ibm.com>
Message-ID: <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <wlu1jj0b.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com> <wlu1jj0b.ritesh.list@gmail.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC151 (Linux)/8.5.0_GA_3042)
Thread-Topic: VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
Thread-Index: Rrjjg/+NomVUWGJYvmbLmtuL/FomRw==



----- Original Message -----
> From: "Ritesh Harjani" <ritesh.list@gmail.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
> <gbatra@linux.ibm.com>
> Sent: Saturday, August 8, 2026 12:09:24 AM
> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA

> Timothy Pearson <tpearson@raptorengineering.com> writes:
> 
>> ----- Original Message -----
>>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linuxppc-dev"
>>> <linuxppc-dev@lists.ozlabs.org>
>>> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
>>> <gbatra@linux.ibm.com>
>>> Sent: Thursday, August 6, 2026 12:27:22 AM
>>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>>
>>> Hi Timothy,
>>> 
>>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>>> 
>>>> On Linux 6.18, and potentially earlier Linux versions, attempting to pass
>>>> through any PCI device via VFIO that requires 32-bit DMA results in the
>>>> following error in the guest VM:
>>> 
>>> Can you confirm if you see the same issue on upstream kernel also or is
>>> it only till v6.18 kernel?
>>
>> I'll need to check, but I don't see why it would be limited to 6.18.  This used
>> to work, but it's fairly obvious IBM hasn't been testing or fixing any of the
>> VFIO or nested virtualization code for years now, especially on PowerNV.
>>
>>>>
>>>> [   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device
>>>> mask
>>>> [   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset:
>>>> 0x800000000000000
>>>>
>>>> The same devices work correctly on the host kernel.  It appears that somehow
>>>> 32-bit DMA is not available within a pSeries guest on a PowerNV host.
>>> 
>>> By any chance did you do kexec in the guest kernel? Is this issue only
>>> hitting with kexec or even with normal boot up of guest kernel is also
>>> showing up the same issue?
>>
>> Yes, we kexec().  This works on every other architecture, not sure why kexec()
>> would break it?
>>
>> In any case, from where I sit at this point it's IBM's responsibility as the
>> silicon vendor to ensure basic functionality works -- I don't see these issues
>> on amd64 or arm64, and frankly on this end we're tired of the constant lack of
>> QA from IBM causing every single kernel upgrade to be a game of Russian
>> Roulette.  IBM should be able to spin up a test machine easily enough to
>> reproduce, this isn't complex -- any card that needs 32-bit DMA is affected
>> including inexpensive ASmedia USB 3 controllers.  Pass it through to QEMU via
>> VFIO and watch it fail, it happens every time.
>>
> 
> I was trying to help by asking for basic help from you. If you report a
> problem upstream than we do expect such basic help e.g. is it only seen
> with kexec, logs etc, so that we can all save some time here.

No worries, appreciated.  This is only one of several major problems with Linux on PowerNV that we have run into after recent upgrades, and the primary focus at the moment is on restoring broken functionality.  In many cases, that means moving to different hardware, so gathering logs afterward can be difficult / impossible.

>>> Could you please share the dmesg logs for both guest and host kernel?
>>> That might give some more data about this issue.
>>
>> I don't have access to the setup at this point since it was already replaced
>> with something else to restore functionality.
> 
> I think this patch [1] might have fixed the issue that you reported and
> hence wanted to check if you only see the issue with kexec or also with
> reboots? And if you could have given it a try.
> 
> [1]: https://lore.kernel.org/all/20260803224029.60538-1-gbatra@linux.ibm.com/
> 
> But anyways - I have already asked others on that thread (who are expert
> of this area) to confirm if this patch could also fix the error you
> reported with 32-bit DMA devices.

Thank you for the link.  When / if we want to test a migration of that hardware back to VFIO on PowerNV I will ensure that patch is applied before testing.

