Return-Path: <linuxppc-dev+bounces-24260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DE4C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 17:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h05Yl16xpz2yXj;
	Wed, 15 Jul 2026 03:16:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784049371;
	cv=none; b=XudPB7uQIOIyA69URjpDqx/rRQE0iJiUuhcNmqpCa2Qmgtzb05vEqCavdouBD4N2T26wevtdxWSGIDPxdlGE6e0qmg9gGnceZcHZ1alWUYY9YRCjsLdd3Sa1FAaT54ECyfY2Y64Z24yMiYLVjPql+PlbF0lm3qNBMLQtHuAKFDwDtZlAXmRdzjh8BbWNt7FvuC5yWunZvmHReVvQMh0MA0gqyPoKB6xYms49O0l5zauJDOorIceYcxeC/FgfoFrKATxPtamYIfb9ViovV7csrRUfRR6Jx71EzYEI42+kwnYmP9UOuw8Ap5gjtlNCEYlqpr/h7wNkAxSQs/EKNeRvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784049371; c=relaxed/relaxed;
	bh=3dQlqtI/pfI1NhGUATa1BRaHfwp8yOMI9IQz2QGREmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBKXsm8NfF+Zck8C04uu7I4BH3rZZn2HZMlfZfpN1fWI3MzuahnhyKqlLMs++XIKUDFghObQtlsNOR/GCK3+vdHe9NxPhCwS+2y0rLUItxVMnvzfEnggWJBdhrq2klYnwZCqU68UhGGhvTMioVEuaSzJBSwQrgfTq5vIu8dEZz4FoTwDnkkxMVkXafOxAxYn6gE78SKKLq3npUQo7GY9fqgYrMsUmzNcVSRyk2kaM5hziKlJMRSZf+p9N+Stv4dxfX+uC2MDvA/3Q7ibpc1yCwtOf493ppDoVa6iTVSCOF0y5LZbwV1QUa0N9hqNcaLtA54iIgc6qarX+Xpm4UixFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BHW/plWH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BHW/plWH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h05Yk0FxSz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 03:16:09 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EGC4O71721359;
	Tue, 14 Jul 2026 17:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3dQlqt
	I/pfI1NhGUATa1BRaHfwp8yOMI9IQz2QGREmI=; b=BHW/plWHILL1BVaEJrYdog
	lrdkg9dvvjgIj1UbuGeUEGYpnh3s0st8BqsalDNxzjbzjRGGiCtJ7FZoBt5DBffB
	Nht0TAGyhXOciC/Yos0b51LFbDdpyqvL7H+qGy85Ce2Ur4SHwi405u8Fkp6Pd8gT
	ub3RvMuB3CHLxeFX185q7PEHDH4TTRWo4vLDuTOsVDwiGgVh8me42sO0ApwM10vF
	bdtH67UmF9INGeU8zUBWYOn1WsZKZYQybIhBGBC31M6RPKeq1IU2KVX3l6fHbdK4
	Bqu9lYHEez4tXvBJsd28lNqlMGv8lnwl57B+vUUQy2f0laJfrk+S0u6LvuekyjEg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwpur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:15:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EH4cNh001196;
	Tue, 14 Jul 2026 17:15:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15juvqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 17:15:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EHFsJ649414528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 17:15:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFB962004B;
	Tue, 14 Jul 2026 17:15:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC9220043;
	Tue, 14 Jul 2026 17:15:52 +0000 (GMT)
Received: from [9.67.105.149] (unknown [9.67.105.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 17:15:51 +0000 (GMT)
Message-ID: <265aa885-f087-4bf5-a30f-c9f40a9b554c@linux.ibm.com>
Date: Tue, 14 Jul 2026 22:45:49 +0530
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
Subject: Re: [PATCH] powerpc/eeh: Fix recursive locking on devices without EEH
 sensitive driver
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725885065.13410.12259326756082237538.stgit@linux.ibm.com>
 <h5m9wmeo.ritesh.list@gmail.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <h5m9wmeo.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Emh0CXAqtG5qxWcNl2N-gUnc-AG9muPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX4ZJR4s5fLfVV
 OxiQ847X15Lprp2s04gsZvVtPyv6sL+oGECSBJK52LoBZKZm4mWRF2dPaCB6f/qR6OXf7rKEA8Z
 S4z6XfoGNTtUArL8XJbzJiz4EQ+NJqk2fbJ6K58+gwhMpy6Kzz2WHiSzdnfW04AszmZBfMHjT79
 uJ//vn5fqsXw7BnKfEE5G+iph75vY+zNjbSeWY6jzxprDQPgMi+WnUxr/xd8uveVa30EtowvFTt
 iOUxCxpW8OpL5yqrrSWf59cUIhAb3CHhp51ICDswTohRBAHKpdFN3+gYqlg08AoeQqq7f0dqcRu
 PTRoJ80cVWJShl3TrxjLFf8vV6P11d0DytlhqKc087rDjXxdJueI6WIzdVizi5DBOPY/fZerpwX
 UQdnCpEkL5xMXBfER3aeeKVbq4+acJ68IVyuDnSj9R+tPx67k1Pwdiw7bRso6oZ5pLhBHv32uK0
 2najucT09W+f4rzY/rg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a566ece cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=N1q1UTQko89L4O4iEI0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: m0ERL_I6XuuDQ9sBwpMyDrp2Df7jMcrC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX/q0WWrPkRUtv
 1kuSjpc8pQlj+wNWsQimsZbPrMSAkdj4Bw5J/PGrn90bv/H5hyMmwPy51gwrmQLoS0/lP4KSoKn
 Y9Mv2H0Ly2tx5CNcgBy54DlXW/JMsbI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

Hi Ritesh,

Thanks for the review.

On 7/8/26 8:36 PM, Ritesh Harjani (IBM) wrote:
> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>
> hey, sorry looks like this fall through the cracks.
>
>> The commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug
>> safe") refactored the EEH code such that the pci_rescan_remove_lock is
>> held at the beginning of eeh_handle_normal_event() and the
>> eeh_reset_device() is called with that lock being held. Looks like the
>> commit missed to remove the existing lock/unlock inside eeh_rmv_device()
>> which is no longer necessary. This is causing the eehd to hang on the
>> lock which it actually holds when that code path is taken.
>>
>> [<0>] 0xc00000011c78f870
>> [<0>] __switch_to+0xfc/0x1a0
>> [<0>] pci_lock_rescan_remove+0x30/0x44
>> [<0>] eeh_rmv_device+0x290/0x2e0
>> [<0>] eeh_pe_dev_traverse+0x80/0x130
>> [<0>] eeh_reset_device+0xcc/0x23c
>> [<0>] eeh_handle_normal_event+0x830/0xa80
>> [<0>] eeh_event_handler+0xf8/0x190
>> [<0>] kthread+0x194/0x1b0
>> [<0>] start_kernel_thread+0x14/0x18
>>
> yup. I see eeh_handle_normal_event(), already holds this lock,
> pci_lock_rescan_remove().
>
> And eeh_rmv_device() only ever gets called from
>
> eeh_handle_normal_event()
>    eeh_reset_device()
>      eeh_pe_dev_traverse(pe, eeh_rmv_device,...)
>
> OR
>
> eeh_handle_normal_event()),
>      eeh_pe_dev_traverse(pe, eeh_rmv_device,...)
>
> In both the paths, eeh_handle_normal_event() holds this lock. Although I
> am not an expert in eeh area - but looking at the relevant code paths,
> the race looks real and this patch fixes that. So feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>
> I wonder whether clang context analyzer [1] could catch this. This is a
> good candidate to try that out.
>
> [1]: https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/


I did give it a try.

https://gist.github.com/shivaprasadbhat/473ea8bcb63afda669bcb5de24ac22f8

It couldnt catch it. May need some more work.


>> The issue is seen for cases where the errors are detected on the PHB
>> directly AND|OR for devices where the driver error_detected() returns
>> PCI_ERS_RESULT_NEED_RESET, and driver being not EEH sensitive(i.e no
>> error handlers like slot_reset(), resume() etc defined).
>>
> I am just wondering how did we catch this issue and whether we have some
> ways to test eeh scenarios. Although the patch looks good to me.


Two ways to recreate, Mostly with drivers not having eeh_handlers like

slot_reset(), resume defined.

- On Baremetal, eeh on multi-function device bound to vfio.

- On PowerVM, eeh on a device behind a switch or IO drawer.


>> Fixes: 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug safe")
> Cc: stable@vger.kernel.org
>
> Let's add the above tag so that this also goes to stable trees.  Since
> it's been sometime since this was last posted - maybe we should rebase
> and resend this with the above tag.

Sure.


Thanks,

Shivaprasad

> -ritesh
>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/eeh_driver.c |    2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index 028f69158532..d64cce17a4e0 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -533,9 +533,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
>>   		if (rmv_data)
>>   			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
>>   	} else {
>> -		pci_lock_rescan_remove();
>>   		pci_stop_and_remove_bus_device(dev);
>> -		pci_unlock_rescan_remove();
>>   	}
>>   }
>>   

