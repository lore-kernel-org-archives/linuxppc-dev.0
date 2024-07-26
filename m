Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A18C3DA7F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jul 2024 12:50:17 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ko+oh1yW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVnfH450Hz3dKF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jul 2024 22:50:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ko+oh1yW;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVndT4wnqz3c05
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2024 22:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721998173;
	bh=FbjGrZAf4KleDcOMWprQnrXa/ICyg2tclBDC0d6LUpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ko+oh1yWmHuJ28MuSfSmWMSNvw/3PNVTmZhhgZO3y/QcEE8E5mIEiGRDDVZtk5SA3
	 DSwzeimB8ywiZbBMODXyn6E3xM1JH0JxV/aLtd1QGSvDmH0yzkKKa9bG8hiA5NgRKC
	 xgyhcypHpdkzlJONdYHOJh1PbUY+RfLi2lOLNVXFZ2Mtu8zBkRBjE+WI0vLEP3z9P+
	 nX0VvkHtfXlv+O+hkN8NjHNWCrXdHF7EVn8l3kuxbFtZYJJgzZUSv0ZI3+4XmjYaAj
	 XXn1CNLfxSLNtpFcC7HVKXAo4pfHsaM5mjhG0xQrBqhT3aKb+lDVY8fI/M6cV8UPKG
	 FtP423ZOyfizA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WVndS1hY7z4w2M;
	Fri, 26 Jul 2024 22:49:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
In-Reply-To: <dx32q3sa4oopk3fnm2zyeplotuq6gq3rmnbmaw3mo4q3lgjpe7@gvpgu4rdk4f4>
References: <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>
 <20240725205537.GA858788@bhelgaas>
 <dx32q3sa4oopk3fnm2zyeplotuq6gq3rmnbmaw3mo4q3lgjpe7@gvpgu4rdk4f4>
Date: Fri, 26 Jul 2024 22:49:31 +1000
Message-ID: <87sevwuxlw.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, Kowshik Jois B S <kowsjois@linux.ibm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, Lizhi Hou <lizhi.hou@amd.com>, Lukas Wunner <lukas@wunner.de>, Nicholas Piggin <npiggin@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> Hi Bjorn,
>
> On 2024/07/25 03:55 PM, Bjorn Helgaas wrote:
>> On Thu, Jul 25, 2024 at 11:15:39PM +0530, Amit Machhiwal wrote:
>> > ...
>> > The crash in question is a critical issue that we would want to have
>> > a fix for soon. And while this is still being figured out, is it
>> > okay to go with the fix I proposed in the V1 of this patch?
>> 
>> v6.10 has been released already, and it will be a couple months before
>> the v6.11 release.
>> 
>> It looks like the regression is 407d1a51921e, which appeared in v6.6,
>> almost a year ago, so it's fairly old.
>> 
>> What target are you thinking about for the V1 patch?  I guess if we
>> add it as a v6.11 post-merge window fix, it might get backported to
>> stable kernels before v6.11?  
>
> Yes, I think we can go ahead with taking V1 patch for v6.11 post-merge window to
> fix the current bug and ask Ubuntu to pick it while Lizhi's proposed patch goes
> under test and review.

Lizhi's proposed patch (v3?) looks pretty small and straight forward.
It should be possible to get it tested and reviewed and merge it as a
fix during the v6.11-rc series.

Or if the CONFIG option is completely broken as Rob suggests then it
should just be forced off in Kconfig.

cheers
