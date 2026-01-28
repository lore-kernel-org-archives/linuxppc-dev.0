Return-Path: <linuxppc-dev+bounces-16356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C710D25B48
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:51:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1LG00HMPz2xlK;
	Wed, 28 Jan 2026 22:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=61.152.208.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769595974;
	cv=none; b=KqV23Is0ZMfX6/G5dOQ2J3thYZtm74Fene0ydJxktAdAAlnBxpqCAN6gvHQ//2VlGsd2Eu7n+mBlQNxtmnEGA2BhAtd82Z842F1aUZBHml3D/7YfzbdBU3Oby95SsdYkL4HaotsdC8WTUnzn+MPeWPh3xOONlG5iDgPV4JOxmLWVD2bA91OyXrKLfmHJhlsHtG+28OyIKtCmPP/TAmZBbUIVIbgfyjP9WHyQPh1+oCMewOxp6OTbre14pXA3sai7VGuauP1sGPkRgeo5pJKFgL/T+O147MolPIUdDxZW0OBCKnguJc1g9ni3VGMksE/OdTVQ7urj+hv/T6mq4sUQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769595974; c=relaxed/relaxed;
	bh=6q4lC4pF/slRu02qeWpo+FxWoaj0Y2OTo9oRpIdlZxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Js12+HAwUPzYFoyQPsvQBdeHuMhVN7Dy0TKZFwJM7NYF5U6QkqXsfL1wFscHmHBpD35woG/r76Da/vgin7hIqa3l/rwb3h5KDBeRGi6jGzBMDG/bQF5v7zw3zVbnlWPi0WnXz6Aa/r0vg5ICttii8rFgxxUYubauuV9iQ7IZotcd1KSAueI0RSjQeg335I4qKiqwnS7cNKeqhx1RWWqzKmZaqbfcpErrXQiOHhYdWpwJiOTxj1HdT9eb12Jas3LIYgBmFdHRzXSANIReads6qkvTM9gJ3/5uSKBf95dTkXfvw6vQhuvPwsW3tfqX92+V+SPPcoNWhzeUxZUp9pfvAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass (client-ip=61.152.208.219; helo=mx2.zhaoxin.com; envelope-from=leoliu-oc@zhaoxin.com; receiver=lists.ozlabs.org) smtp.mailfrom=zhaoxin.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zhaoxin.com (client-ip=61.152.208.219; helo=mx2.zhaoxin.com; envelope-from=leoliu-oc@zhaoxin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 992 seconds by postgrey-1.37 at boromir; Wed, 28 Jan 2026 21:26:12 AEDT
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1JMm6r44z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 21:26:10 +1100 (AEDT)
X-ASG-Debug-ID: 1769594970-1eb14e7c0137290001-v7v7hK
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id O3s3E7PRvfVJ8Zj0 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Jan 2026 18:09:30 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 18:09:30 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 28 Jan 2026 18:09:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.64.5] (10.32.64.5) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 18:08:46 +0800
Message-ID: <3af9f754-d282-485c-a3f2-49a230bfe143@zhaoxin.com>
Date: Wed, 28 Jan 2026 18:07:51 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
To: Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
CC: <mahesh@linux.ibm.com>, <oohall@gmail.com>, <bhelgaas@google.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>, Lukas Wunner
	<lukas@wunner.de>
References: <20260123202140.GA84703@bhelgaas>
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20260123202140.GA84703@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.32.64.5]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/28/2026 6:09:29 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1769594970
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3796
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153689
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



=E5=9C=A8 2026/1/24 4:21, Bjorn Helgaas =E5=86=99=E9=81=93:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> [+cc Lukas, pciehp expert and author of a97396c6eb13]
>=20
> On Fri, Jan 23, 2026 at 06:40:34PM +0800, LeoLiu-oc wrote:
>> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
>> amended PCIe hotplug to not bring down the slot upon Data Link Layer Sta=
te
>> Changed events caused by Downstream Port Containment.
>>
>> However, PCIe hotplug (pciehp) waits up to 4 seconds before assuming tha=
t
>> DPC recovery has failed and disabling the slot. This timeout period is
>> insufficient for some PCIe devices.
>> For example, the E810 dual-port network card driver needs to take over
>> 10 seconds to execute its err_detected() callback.
>> Since this exceeds the maximum wait time allowed for DPC recovery by the
>> hotplug IRQ threads, a race condition occurs between the hotplug thread =
and
>> the dpc_handler() thread.
>=20
> Add blank lines between paragraphs.
>=20
> Include the name of the E810 driver so we can easily find the
> .err_detected() callback in question.  Actually, including the *name*
> of that callback would be a very direct way of doing this :)
>=20
> I guess the problem this fixes is that there was a PCIe error that
> triggered DPC, and the E810 .err_detected() works but takes longer
> than expected, which results in pciehp disabling the slot when it
> doesn't need to?  So the user basically sees a dead E810 device?
>=20
Yes, this patch is to solve this problem.

> It seems unfortunate that we have this dependency on the time allowed
> for .err_detected() to execute.  It's nice if adding arbitrary delay
> doesn't break things, but maybe we can't always achieve that.
>=20
I think this is a feasible solution. For some PCIE devices, executing
the .err_detect() within 4 seconds will not have any impact, for a few
PCIE devices, it might increase the execution time of pciehp_ist().
Without this patch, PCIE devices may not be usable and could even cause
more serious errors, such as a kernel panic. For example, the following
log is encountered in hardware testing:

list_del corruption, ffff8881418b79e8->next is LIST_POISON1
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
...
Kernel panic - not syncing: Fatal exception

> I see that pci_dpc_recovered() is called from pciehp_ist().  Are we
> prepared for long delays there?
>=20
This patch may affect the hotplug IRQ threads execution time triggered
by DPC, but it has no effect for normal HotPlug operation, e.g.
Attention Button Pressed or Power Fault Detected. If you have better
modification suggestions, I will update to the next version.

>> Signed-off-by: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
>> ---
>>  drivers/pci/pcie/dpc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fc18349614d7..08b5f275699a 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -121,7 +121,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>>        * but reports indicate that DPC completes within 4 seconds.
>>        */
>>       wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
>> -                        msecs_to_jiffies(4000));
>> +                        msecs_to_jiffies(16000));
>=20
> It looks like this breaks the connection between the "completes within
> 4 seconds" comment and the 4000ms wait_event timeout.
>=20
Thanks for your suggestion, I will change it in the next version.

Yours sincerely.
LeoLiu-oc

>>       return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>  }
>> --
>> 2.43.0
>>


