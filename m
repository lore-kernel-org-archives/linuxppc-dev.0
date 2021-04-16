Return-Path: <SRS0=vApQ=JN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A4C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 18:08:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2D3613C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 18:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2D3613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMPNN456Yz3byr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 04:08:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F6iBjdXr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=srs0=sb2e=jn=linux.ibm.com=hbathini@ozlabs.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=F6iBjdXr; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMPMt5859z300X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 04:08:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by ozlabs.org (Postfix) with ESMTP id 4FMPMs4vvtz9sWX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 04:08:25 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4FMPMs4hDRz9sWK; Sat, 17 Apr 2021 04:08:25 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=F6iBjdXr; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FMPMs13QFz9sWQ;
 Sat, 17 Apr 2021 04:08:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13GI3Gwu026725; Fri, 16 Apr 2021 14:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dFo2M1YTU8VLzDurtHX/E4svV4jpnVaFDV/VvhJHwFA=;
 b=F6iBjdXrtQ4RMDce9HxEC9Ck7mmqUHOwWgliJq0uhSy3LmXWqbiRYkljX0SaODpg0p20
 JnvzB4SNHIZfPgu9gfW7khe+P0J0hMSZ9GejN83WrVvocIrqflgqXMET0p6itHrYxGCu
 1rVfcxrcyYT5WpkfrUqnMMFMzWLyvTZHCopYx3ptSNDoSvC9NxKja7U2c6xcGzyqN+8/
 Up5EjtW51U/FMoWZStOiTU1Og6BBC2Lp0BloThzWnNAE4XQ33fvBl0/C35sBXj7LoReH
 1vetnbgu59SDGzLOiQZrjbKd3xkfPOdy/3tEVSlS2pBpyEiVo/rPoIFxmd3bQFb4P17a xQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37yecx25yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Apr 2021 14:08:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GI28mD026269;
 Fri, 16 Apr 2021 18:08:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 37u3n8ck8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Apr 2021 18:08:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13GI8EfB40698186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Apr 2021 18:08:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A462442041;
 Fri, 16 Apr 2021 18:08:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D5AE42042;
 Fri, 16 Apr 2021 18:08:12 +0000 (GMT)
Received: from [9.211.53.99] (unknown [9.211.53.99])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 16 Apr 2021 18:08:11 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/kexec_file: use current CPU info while setting
 up FDT
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
References: <20210416124658.718860-1-sourabhjain@linux.ibm.com>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <423d12b5-d8fa-d9ad-147d-efca5fce5c2c@linux.ibm.com>
Date: Fri, 16 Apr 2021 23:38:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416124658.718860-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JK4VMeYWwRSpt9VSCbq81dQhMvTHqM14
X-Proofpoint-GUID: JK4VMeYWwRSpt9VSCbq81dQhMvTHqM14
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-16_09:2021-04-16,
 2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160129
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
Cc: mahesh@linux.vnet.ibm.com, bauerman@linux.ibm.com, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 16/04/21 6:16 pm, Sourabh Jain wrote:
> kexec_file_load uses initial_boot_params in setting up the device-tree
> for the kernel to be loaded. Though initial_boot_params holds info
> about CPUs at the time of boot, it doesn't account for hot added CPUs.
> 
> So, kexec'ing with kexec_file_load syscall would leave the kexec'ed
> kernel with inaccurate CPU info. Also, if kdump kernel is loaded with
> kexec_file_load syscall and the system crashes on a hot added CPU,
> capture kernel hangs failing to identify the boot CPU.
> 
>   Kernel panic - not syncing: sysrq triggered crash
>   CPU: 24 PID: 6065 Comm: echo Kdump: loaded Not tainted 5.12.0-rc5upstream #54
>   Call Trace:
>   [c0000000e590fac0] [c0000000007b2400] dump_stack+0xc4/0x114 (unreliable)
>   [c0000000e590fb00] [c000000000145290] panic+0x16c/0x41c
>   [c0000000e590fba0] [c0000000008892e0] sysrq_handle_crash+0x30/0x40
>   [c0000000e590fc00] [c000000000889cdc] __handle_sysrq+0xcc/0x1f0
>   [c0000000e590fca0] [c00000000088a538] write_sysrq_trigger+0xd8/0x178
>   [c0000000e590fce0] [c0000000005e9b7c] proc_reg_write+0x10c/0x1b0
>   [c0000000e590fd10] [c0000000004f26d0] vfs_write+0xf0/0x330
>   [c0000000e590fd60] [c0000000004f2aec] ksys_write+0x7c/0x140
>   [c0000000e590fdb0] [c000000000031ee0] system_call_exception+0x150/0x290
>   [c0000000e590fe10] [c00000000000ca5c] system_call_common+0xec/0x278
>   --- interrupt: c00 at 0x7fff905b9664
>   NIP:  00007fff905b9664 LR: 00007fff905320c4 CTR: 0000000000000000
>   REGS: c0000000e590fe80 TRAP: 0c00   Not tainted  (5.12.0-rc5upstream)
>   MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000242
>         XER: 00000000
>   IRQMASK: 0
>   GPR00: 0000000000000004 00007ffff5fedf30 00007fff906a7300 0000000000000001
>   GPR04: 000001002a7355b0 0000000000000002 0000000000000001 00007ffff5fef616
>   GPR08: 0000000000000001 0000000000000000 0000000000000000 0000000000000000
>   GPR12: 0000000000000000 00007fff9073a160 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 00007fff906a4ee0 0000000000000002 0000000000000001
>   GPR24: 00007fff906a0898 0000000000000000 0000000000000002 000001002a7355b0
>   GPR28: 0000000000000002 00007fff906a1790 000001002a7355b0 0000000000000002
>   NIP [00007fff905b9664] 0x7fff905b9664
>   LR [00007fff905320c4] 0x7fff905320c4
>   --- interrupt: c00
> 
> To avoid this from happening, extract current CPU info from of_root
> device node and use it for setting up the fdt in kexec_file_load case.
> 
> Fixes: 6ecd0163d360 ("powerpc/kexec_file: Add appropriate regions for memory reserve map")

Missed marking stable@vger.kernel.org on Cc for this fix..


> +int add_node_prop(void *fdt, int node_offset, const struct device_node *np)
> +{

<SNIP>

> +int update_cpus_node(void *fdt)
> +{

I think the above two new functions should be marked 'static'...

Thanks
Hari
