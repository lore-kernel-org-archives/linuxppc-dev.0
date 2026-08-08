Return-Path: <linuxppc-dev+bounces-25634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB1C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 05:00:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH83T6SV5z2xd2;
	Sat, 08 Aug 2026 15:00:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786165237;
	cv=none; b=TgOF3E60wHrVFOM8lryl1BHSWcfVDXb1iaYhqboHkv9CqXlqRjoQ5wsVxu4oj3xuQJ6ddIml4yE8Qw5WakYut5uZAoqSwltDwtz13kwiVuA0sIHTm0Tvwf71cFsfVyRnH1fXcIByXt+4ZDabn/Y2+WoHLpZpYYwDQqrdCs1fBOqqHR3tj9efnviiU0fFDD7rVYCmSojTQLyZh6OIoxn5mi4fGYWOk7R0hljKJ6hVunjI4w1i59Z8msHqT/h6U3KeIeOLyBCLmcHWqjA7lYKv/K874G91Mvs5LNdwDStIKXcmdfmt5YdZzxQ+0xYxS9SThICXbqiPGX/HaOjNLj9QrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786165237; c=relaxed/relaxed;
	bh=My6MAP5M1ncNYGmKgRUT8TAjbs2c634SY+6UKvTq+Mg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GFMYheUQvI/T22qbIL6CtIHpacF2bPn4fHWHkpHVzgNw9gmgcTj1m3BqHEWHChKzV+1EJRhYTlsyRwyaZ7xEe1/nSDhplXHYa4dgws1S6q/WSIPFNTGXVULf/iz4CLV0yETkFE8aCsSKyHvvt64/nepqD2TM3E5Vlou4zPjl2TUCTowssSOXDgzo/mxEwoad0XXgknD6ScKeDJRnCb7qE33L6VT9NTpfCFfOoUZGqca8ljWsb/ZZuKnteut3J1HXSRiHAPb9C0250J8uEE71Oa7+BTHfejWNlk0Gl5CEk65Wv1bxvZotEhKp2nFnNMkfqcK6T1X5PkHt12l8uOkVJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=WaVE3DYi; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=WaVE3DYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH83Q6vnMz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 15:00:33 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D46607790B30;
	Sat,  8 Aug 2026 00:00:26 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0fbAxXTxx10a; Sat,  8 Aug 2026 00:00:26 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0457B7790D1F;
	Sat,  8 Aug 2026 00:00:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 0457B7790D1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786165226; bh=My6MAP5M1ncNYGmKgRUT8TAjbs2c634SY+6UKvTq+Mg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=WaVE3DYioCeaz/bZElJ986vg3p3e9swdLZZTbZhQZq2KsA/OU+WooSODvc2pXTLMS
	 NWby8Lw93DW9O5LPBDL9VS9PFUlsD454Zgg8cLBlw9fIcTeEGflrjnL12orNSep7C2
	 KnRrdFIF0+GtCKfIpYcf6qFQ1w7sxrSaN29Dxh9I=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vkAu5STYwExF; Sat,  8 Aug 2026 00:00:25 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id CF66E7790CE2;
	Sat,  8 Aug 2026 00:00:25 -0500 (CDT)
Date: Sat, 8 Aug 2026 00:00:22 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	Gaurav Batra <gbatra@linux.ibm.com>
Message-ID: <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <o6fflsxx.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com>
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
Thread-Index: MgeB9afmjCKu9w4GJAPxYovl1zeyNQ==



----- Original Message -----
> From: "Ritesh Harjani" <ritesh.list@gmail.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra" <gbatra@linux.ibm.com>
> Sent: Thursday, August 6, 2026 12:27:22 AM
> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA

> Hi Timothy,
> 
> Timothy Pearson <tpearson@raptorengineering.com> writes:
> 
>> On Linux 6.18, and potentially earlier Linux versions, attempting to pass
>> through any PCI device via VFIO that requires 32-bit DMA results in the
>> following error in the guest VM:
> 
> Can you confirm if you see the same issue on upstream kernel also or is
> it only till v6.18 kernel?

I'll need to check, but I don't see why it would be limited to 6.18.  This used to work, but it's fairly obvious IBM hasn't been testing or fixing any of the VFIO or nested virtualization code for years now, especially on PowerNV.

>>
>> [   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device
>> mask
>> [   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset:
>> 0x800000000000000
>>
>> The same devices work correctly on the host kernel.  It appears that somehow
>> 32-bit DMA is not available within a pSeries guest on a PowerNV host.
> 
> By any chance did you do kexec in the guest kernel? Is this issue only
> hitting with kexec or even with normal boot up of guest kernel is also
> showing up the same issue?

Yes, we kexec().  This works on every other architecture, not sure why kexec() would break it?

In any case, from where I sit at this point it's IBM's responsibility as the silicon vendor to ensure basic functionality works -- I don't see these issues on amd64 or arm64, and frankly on this end we're tired of the constant lack of QA from IBM causing every single kernel upgrade to be a game of Russian Roulette.  IBM should be able to spin up a test machine easily enough to reproduce, this isn't complex -- any card that needs 32-bit DMA is affected including inexpensive ASmedia USB 3 controllers.  Pass it through to QEMU via VFIO and watch it fail, it happens every time.

> Could you please share the dmesg logs for both guest and host kernel?
> That might give some more data about this issue.

I don't have access to the setup at this point since it was already replaced with something else to restore functionality.

