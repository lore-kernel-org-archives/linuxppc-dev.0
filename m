Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E9C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 06:58:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3021520870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="U17qv4U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3021520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zc3j2CMVzF3SH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 17:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="U17qv4U4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="U17qv4U4"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zc140GkHzF36t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 17:55:49 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id gn14so512866plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Imr1XUfmzmsy9gv96nhO5oBvtZ2mMJEqNM6eqE+ppqU=;
 b=U17qv4U4GJt9F4FnW21aiorDdZmdHfy4peaCaIg1l4OUBmqFvv/euL/8P9/6a/MrSO
 ztl1FU7raSU0eUi9W/9YzfqaCEIX6wPXbcYoXZHgYxW2nE2QTfsaYwQp66yseLI6/fhD
 3leAnEtbv+z5mF3Z/ayHRip1S5v/p5NAdW+2GmB4IWj+uvyFWrqYfNy/n0IeN5ThKLWV
 gi7HoS7/qilo1PgpKz9+HAnUVsZxKzFqMQzxBJkLbEeYUvMb3IiXclHFp20LQQ4f5sqC
 08kgHIaNRIZ4pTMYXX4O11l/UyUDfl42X6QZhU/lfIj+lQt1nQqo2/s+nbbn+XyI0Lt7
 jfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Imr1XUfmzmsy9gv96nhO5oBvtZ2mMJEqNM6eqE+ppqU=;
 b=B/AQ4GpzfBXqDSj/9oFdkxr2tftiJVCnUH/2qn2Ta7rZm1auYiqCngvDrpbAV9upba
 MFJIHbnC1JcdZHpHpNvuYTjKYAML7Rgus6LHNoFBkleCyw5QAqXobM/pwtRudmaHQq8x
 ZMu0LeHig70lZfuVH/bMjDYk9R6Z+i+zyWorHB5AbTZQclZ44fbMjfVsjyZ3ALwFn3L4
 6NsQZ8zRUolBogBOEiUg9N4+vDEoq+aEa5Q2roDZ6fDdF8YmkJrpwQ/0wL8HVQimEmD2
 DztWpouiKUjk3OvpHHmFq5LADArt1jWkLFAClVa/HjLOj4NfWjUIItVD5B7ZJA2z2k2S
 teRQ==
X-Gm-Message-State: AA+aEWa7tQZCAM3AfgvacOpGH4VZq/zQRNzACdZMUjIh3+D09mXmVQSv
 ERwPVlmD19qopIAink/e56b40w==
X-Google-Smtp-Source: AFSGD/W6YZtMGG91+PC6uK5AU+79Sx/VVHS/2uixYEwKBeeha/NcfW3ha2vdLmgHPceVWCwFYkbm2Q==
X-Received: by 2002:a17:902:1122:: with SMTP id
 d31-v6mr973079pla.259.1542696947883; 
 Mon, 19 Nov 2018 22:55:47 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b5sm30324432pfc.150.2018.11.19.22.55.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Nov 2018 22:55:47 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
To: Sam Bobroff <sbobroff@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181119042517.45075-1-aik@ozlabs.ru>
 <877eh831id.fsf@concordia.ellerman.id.au>
 <20181120035123.GB9175@tungsten.ozlabs.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <1c7660de-68fd-60b7-087d-b013479154e0@ozlabs.ru>
Date: Tue, 20 Nov 2018 17:55:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120035123.GB9175@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 20/11/2018 14:51, Sam Bobroff wrote:
> On Tue, Nov 20, 2018 at 01:51:06PM +1100, Michael Ellerman wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>
>>> The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS call in
>>> skiboot's NPU driver does not touch the pci_error_type parameter so
>>> it might have garbage but the powernv code analyzes it nevertheless.
>>>
>>> This initializes pcierr and fstate to zero in all call sites.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>
>> Can we tag this with a Fixes? And seems like it should probably go to
>> stable, or can we not trigger this path on older kernels?
>>
>> cheers
> 
> Hmm, it's triggered by use on an NPU PE so that would be any kernel that
> can run on P8 or later (AFAIK).
> 
> It looks like the issue was present earlier, but the code was last
> touched when it was moved, in...
> 
> 40ae5f693f6a ("powerpc/powernv: Drop PHB operation get_state()")
> 
> ... which was back in v4.1.


The original commit is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c41a7f3f7593fe57

2013-06-20 13:21:09 +0800
===
powerpc/eeh: I/O chip EEH state retrieval

The patch adds I/O chip backend to retrieve the state for the
indicated PE. While the PE state is temperarily unavailable,
the upper layer (powernv platform) should return default delay
(1 second).
===

This was 3.10-rc5 (this is what that sha1's Makefile has).

But this was not the issue till skiboot decided not to zero these
parameters so "Fixes:" should point to what?


> 
> Sam.
> 
>>> Without this, this happens:
>>>
>>> pnv_eeh_get_phb_diag: Failure -7 getting PHB#6 diag-data
>>> EEH: PHB#6 failure detected, location: N/A
>>> CPU: 23 PID: 5939 Comm: qemu-system-ppc Not tainted 4.19.0-le_f5a7bb7_aikATfstn1-p1 torvalds#106
>>> Call Trace:
>>> [c000003fea9df9c0] [c000000000a990ec] dump_stack+0xb0/0xf4 (unreliable)
>>> [c000003fea9dfa00] [c000000000038480] eeh_dev_check_failure+0x1f0/0x5f0
>>> [c000003fea9dfaa0] [c0000000000a2768] pnv_pci_read_config+0x128/0x160
>>> [c000003fea9dfae0] [c0000000005d2b0c] pci_bus_read_config_dword+0x9c/0xf0
>>> [c000003fea9dfb40] [c0000000005df3d4] pci_save_state+0x64/0x250
>>> [c000003fea9dfbc0] [c0000000005e0730] pci_dev_save_and_disable+0x70/0xa0
>>> [c000003fea9dfbf0] [c0000000005e4078] pci_try_reset_function+0x48/0xc0
>>> [c000003fea9dfc20] [c00800001cbc1b1c] vfio_pci_ioctl+0x334/0xea0 [vfio_pci]
>>> [c000003fea9dfcf0] [c00800001ca9046c] vfio_device_fops_unl_ioctl+0x44/0x70 [vfio]
>>> [c000003fea9dfd10] [c00000000039fd84] do_vfs_ioctl+0xd4/0xa00
>>> [c000003fea9dfdb0] [c0000000003a07b4] ksys_ioctl+0x104/0x120
>>> [c000003fea9dfe00] [c0000000003a07f8] sys_ioctl+0x28/0x80
>>> [c000003fea9dfe20] [c00000000000b3a4] system_call+0x5c/0x70
>>> EEH: Detected error on PHB#6
>>> EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 fail
>>> ures.
>>> EEH: Notify device drivers to shutdown
>>> EEH: Beginning: 'error_detected(IO frozen)'
>>> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
>>> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
>>> EEH: PE#c (PCI 0006:00:01.0): Invoking vfio-pci->error_detected(IO frozen)
>>> EEH: PE#c (PCI 0006:00:01.0): vfio-pci driver reports: 'can recover'
>>> EEH: PE#c (PCI 0006:00:01.1): Invoking vfio-pci->error_detected(IO frozen)
>>> EEH: PE#c (PCI 0006:00:01.1): vfio-pci driver reports: 'can recover'
>>> EEH: PE#b (PCI 0006:00:02.0): Invoking vfio-pci->error_detected(IO frozen)
>>> EEH: PE#b (PCI 0006:00:02.0): vfio-pci driver reports: 'can recover'
>>> EEH: PE#b (PCI 0006:00:02.1): Invoking vfio-pci->error_detected(IO frozen)
>>> EEH: PE#b (PCI 0006:00:02.1): vfio-pci driver reports: 'can recover'
>>> EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'can recover'
>>> EEH: Collect temporary log
>>> pnv_pci_dump_phb_diag_data: Unrecognized ioType 0
>>> EEH: Reset without hotplug activity
>>> iommu: Removing device 0006:00:01.0 from group 4
>>> iommu: Removing device 0006:00:01.1 from group 4
>>> iommu: Removing device 0006:00:02.0 from group 4
>>> iommu: Removing device 0006:00:02.1 from group 4
>>> pnv_ioda_freeze_pe: Failure -7 freezing PHB#6-PE#0
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
>>> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
>>> EEH: Sleep 5s ahead of partial hotplug
>>> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
>>> pci 0004:05     : [PE# 18] Setting up window#0 0..3fffffff pg=1000
>>> pci 0004:06     : [PE# 30] Setting up window#0 0..3fffffff pg=1000
>>> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
>>> pci 0006:00:01.0: [PE# 0c] Setting up window 0..3fffffff pg=1000
>>> pci 0006:00:02.0: [PE# 0b] Setting up window 0..3fffffff pg=1000
>>> EEH: Beginning: 'slot_reset'
>>> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
>>> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
>>> EEH: Finished:'slot_reset' with aggregate recovery state:'none'
>>> EEH: Notify device driver to resume
>>> EEH: Beginning: 'resume'
>>> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
>>> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
>>> EEH: Finished:'resume'
>>> EEH: Recovery successful.
>>> ---
>>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
>>>  arch/powerpc/platforms/powernv/pci-ioda.c    | 4 ++--
>>>  arch/powerpc/platforms/powernv/pci.c         | 4 ++--
>>>  3 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index abc0be7..f380789 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -564,8 +564,8 @@ static void pnv_eeh_get_phb_diag(struct eeh_pe *pe)
>>>  static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>>>  {
>>>  	struct pnv_phb *phb = pe->phb->private_data;
>>> -	u8 fstate;
>>> -	__be16 pcierr;
>>> +	u8 fstate = 0;
>>> +	__be16 pcierr = 0;
>>>  	s64 rc;
>>>  	int result = 0;
>>>  
>>> @@ -603,8 +603,8 @@ static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>>>  static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
>>>  {
>>>  	struct pnv_phb *phb = pe->phb->private_data;
>>> -	u8 fstate;
>>> -	__be16 pcierr;
>>> +	u8 fstate = 0;
>>> +	__be16 pcierr = 0;
>>>  	s64 rc;
>>>  	int result;
>>>  
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index dd80744..72b5cc0 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -604,8 +604,8 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
>>>  static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>>>  {
>>>  	struct pnv_ioda_pe *slave, *pe;
>>> -	u8 fstate, state;
>>> -	__be16 pcierr;
>>> +	u8 fstate = 0, state;
>>> +	__be16 pcierr = 0;
>>>  	s64 rc;
>>>  
>>>  	/* Sanity check on PE number */
>>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>>> index 13aef23..db230a35 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>> @@ -602,8 +602,8 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
>>>  static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
>>>  {
>>>  	struct pnv_phb *phb = pdn->phb->private_data;
>>> -	u8	fstate;
>>> -	__be16	pcierr;
>>> +	u8	fstate = 0;
>>> +	__be16	pcierr = 0;
>>>  	unsigned int pe_no;
>>>  	s64	rc;
>>>  
>>> -- 
>>> 2.17.1
>>

-- 
Alexey
