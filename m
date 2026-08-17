Return-Path: <linuxppc-dev+bounces-25904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89275C5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 15:03:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNx124dsvz2xtt;
	Tue, 18 Aug 2026 01:03:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786979014;
	cv=none; b=Nc6l9ujsSLP6IsAp2s4S9N03IdAzRYWVV+Quyf9pdU0v2mJYGEteulx2Dme67f4NmcrXr1QRkhyDwQRLoDI3hFP9m2ImlIhpujTY+jmIngwi0fvjerQjqxDfkJTXTQqPx0dCh7L2KdJYLn0Q740UqlNFtFc1duuICfttOnA/16uPRU36b+X9KhVH5nnxZZ/RB+6KcmW9AimtUDXbPI/I5n769CAcme2itNiq3QG06ZRfIIlaSZwmRl4YUr6NJuS/DhjWBl1LDB5jL/XAzHgMnhYga6wyJLgMwefoj02uxhztK//mNYokFNU/lRFkRqMH11xJdq9/wlfo+Z/B8N0/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786979014; c=relaxed/relaxed;
	bh=/tTf5scmznsPDwHimwYpLA3+scRfj1m5EczanXOnck4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n76arFoHjxsTcqTKRev0oh6MDkPgpsfODzXrv1c477sF/cECnOGJ95nxcCloUePiWwPd8grwDyz1rBe960h9uSY93OJyf2YSkaC0MLBXTNbyloQLNY607QRYXgdcavb0oyR/PVuRRfnK54OeDiQc586Fc4YPecJygAEde3oyZOiRwU8jvHNgG/++0NQCXXuwSb8e8qKrvnM44/bMgR7NM3RD1QBhfghoQJSRQ+jKGRQwCJLedJvUMUsuAjRojOWKJffNK5DgLsqPW2E5gts6o2CTzf1vxAsdLy1o0o/MiWkC5lgwEeItL+OuGWHEqooDIPuZ0a+6WRV204XFjeeRbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=DKwDeZis; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=DKwDeZis;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNx0z61N7z2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 01:03:31 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id CBD1A7792A4B;
	Mon, 17 Aug 2026 10:03:27 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ppvvIUGqtp4V; Mon, 17 Aug 2026 10:03:26 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3B2367792A59;
	Mon, 17 Aug 2026 10:03:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 3B2367792A59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786979006; bh=/tTf5scmznsPDwHimwYpLA3+scRfj1m5EczanXOnck4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=DKwDeZisxOebgQzaz3lBybqdoNtywbJIUHld4IN8FsJ07KZRuGIe16cWLDKR0hmK9
	 pYVwJnkUKfyxXraA/Z7FTjJbPduiypNr40lswFsb578kUPacncmz8LVu5XwJrOFPBq
	 h1Mj58dzGomjyo54Fe2DFu+7c7PHSE47pSflEAs8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d32HIqq9I7PB; Mon, 17 Aug 2026 10:03:26 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id F040F7792A0D;
	Mon, 17 Aug 2026 10:03:25 -0500 (CDT)
Date: Mon, 17 Aug 2026 10:03:21 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	Gaurav Batra <gbatra@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Message-ID: <1292569842.15945.1786979001939.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <qzjxk345.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com> <wlu1jj0b.ritesh.list@gmail.com> <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com> <v79kk8ei.ritesh.list@gmail.com> <192733194.2399.1786205965385.JavaMail.zimbra@raptorengineeringinc.com> <qzjxk345.ritesh.list@gmail.com>
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
Thread-Index: HgVoYW+kIQdnoNLmvcdjXe9Say+2Mg==



----- Original Message -----
> From: "Ritesh Harjani" <ritesh.list@gmail.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
> <gbatra@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>
> Sent: Sunday, August 16, 2026 7:22:18 PM
> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA

> Hi Timothy
> 
> Timothy Pearson <tpearson@raptorengineering.com> writes:
> 
>> ----- Original Message -----
>>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>>> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat"
>>> <sbhat@linux.ibm.com>, "Gaurav Batra"
>>> <gbatra@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Venkat Rao
>>> Bagalkote" <venkat88@linux.ibm.com>
>>> Sent: Saturday, August 8, 2026 9:13:09 AM
>>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>>
>>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>>> 
>>>> ----- Original Message -----
>>>> No worries, appreciated.  This is only one of several major problems with Linux
>>>> on PowerNV that we have run into after recent upgrades, and the primary focus
>>>> at the moment is on restoring broken functionality.  In many cases, that means
>>>> moving to different hardware, so gathering logs afterward can be difficult /
>>>> impossible.
>>>>
>>> 
>>> Sorry to hear that you have been facing such issues recently. I will
>>> bring this up internally. We will try to add more test matrix for
>>> upstream PowerNV (note that we already have PowerNV tested regularly as
>>> part of our upstream CI, but I suppose we could extend more KVM guest
>>> testing there), so that we can reduce down on such reports.
>>
>> That would be very helpful.  I have a number of other internal reports (and some
>> external customer reports) that I will try to get together for submission here.
>> Given the testing on PowerNV seems quite sparse at the moment, if you do need
>> additional PowerNV machines for testing we have bare metal cloud leases
>> available.
>>
> 
> Thanks for bringing up your concern. Based on your feedback, we brought
> up this topic internally. So currently w.r.t upstream maintainance work,
> we have build, boot, selftests and few other test runs, on our PowerNV
> systems, but I agree our other major testing was happening on Pseries
> platform. So, we decided to add more PowerNV machines to our internal CI
> and expand / increase our upstream CI tests and runs on these baremetal
> machines too. This is going to happen very soon, so hopefully, this
> should reduce such reports in the future.

I'm happy to hear this.  Would it be possible for you to share your intended hardware test matrix for PowerNV so that we can highlight any known gaps?  For example, AMD GPUs are very widely used on PowerNV platforms, but IBM doesn't test this combination to the best of my knowledge.

>> That sounds great, thanks.  Does IBM have any plans to support Debian LTS
>> (Freexian) so these patches can flow into the broken distribution kernels?
>>
> 
> yes, we do support that. Once the patch is merged and available in
> stable kernels, we will ensure this is backported to this distribution
> as well.

That's great to hear!  Who should I use as a contact at IBM to put the Freexian team in contact with regarding the LTS support contract?

Thanks again!

