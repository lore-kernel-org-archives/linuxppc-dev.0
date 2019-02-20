Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B282C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:49:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DC32147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4444rV37zlzDqGl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 15:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4444pp215szDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 15:47:45 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K4cejH047092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 23:47:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qrx6qbmea-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 23:47:42 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 20 Feb 2019 04:47:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 04:47:39 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K4lcnZ27394274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 04:47:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D166AE055;
 Wed, 20 Feb 2019 04:47:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CDA2AE053;
 Wed, 20 Feb 2019 04:47:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Feb 2019 04:47:38 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ED854A018C;
 Wed, 20 Feb 2019 15:47:34 +1100 (AEDT)
Subject: Re: [PATCH v2 2/2] powerpc: Enable kcov
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
References: <20190211002002.26038-1-andrew.donnellan@au1.ibm.com>
 <20190211002002.26038-2-andrew.donnellan@au1.ibm.com>
 <87o9772ih2.fsf@dja-thinkpad.axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 20 Feb 2019 15:47:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87o9772ih2.fsf@dja-thinkpad.axtens.net>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19022004-0008-0000-0000-000002C28AA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022004-0009-0000-0000-0000222EBEF6
Message-Id: <0c122e1d-8f7f-cd5e-b7e5-5b859c2df4c5@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=603 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200031
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
Cc: syzkaller@googlegroups.com, npiggin@gmail.com, dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 20/2/19 3:26 pm, Daniel Axtens wrote:
> I needed the following diff to get this booting on a T4240RDB:
> 
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 961f44eabb65..fbe9894d6305 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -3,6 +3,10 @@
>   # Makefile for the linux kernel.
>   #
>   
> +KCOV_INSTRUMENT_cputable.o := n
> +KCOV_INSTRUMENT_setup_64.o := n
> +KCOV_INSTRUMENT_paca.o := n
> +
>   CFLAGS_ptrace.o                += -DUTS_MACHINE='"$(UTS_MACHINE)"'
>   
>   # Disable clang warning for using setjmp without setjmp.h header
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index f965fc33a8b7..0140e7e12c29 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -5,6 +5,9 @@
>   
>   ccflags-$(CONFIG_PPC64)        := $(NO_MINIMAL_TOC)
>   
> +KCOV_INSTRUMENT_tlb_nohash.o := n
> +KCOV_INSTRUMENT_fsl_booke_mmu.o := n
> +
>   CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>   
>   obj-y                          := fault.o mem.o pgtable.o mmap.o \
> 
> 
> The change to kernel/ is required to get the kernel to even begin to
> boot, and the change to mm/ is required to successfully set up SMP. I'm
> not sure preciesly why they cause issues.

Thanks for testing this - I'll roll this into v3.

> 
> I was then able to run kcovtrace and the results seem to make sense. >
> Perhaps in the future some further stuff should be trimmed down to make
> the coverage results less noisy (restore_math is probably not telling us
> anything interesting, for example), but certainly this is a great start.

I think syzkaller (as the main kcov consumer) can probably cope...

> 
> With those changes,
> Tested-by: Daniel Axtens <dja@axtens.net> # e6500


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

