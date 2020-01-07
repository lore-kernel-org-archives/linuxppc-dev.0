Return-Path: <SRS0=KFH9=24=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75464C282DD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 20:09:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2DC2080A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 20:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2DC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sk3d655fzDqJH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2020 07:09:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sk1R3z2FzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2020 07:07:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47sk1R0CWhz8t0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2020 07:07:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47sk1Q6S9gz9sR1; Wed,  8 Jan 2020 07:07:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47sk1Q2Mvlz9sPK
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jan 2020 07:07:05 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007K5VGm082712
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Jan 2020 15:07:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xb925vfb7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Jan 2020 15:07:03 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 7 Jan 2020 20:07:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 20:06:58 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 007K6v8G49348720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 20:06:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DBBA5204E;
 Tue,  7 Jan 2020 20:06:57 +0000 (GMT)
Received: from [9.85.95.152] (unknown [9.85.95.152])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6847952054;
 Tue,  7 Jan 2020 20:06:55 +0000 (GMT)
Subject: Re: [PATCH v6 1/6] Documentation/ABI: add ABI documentation for
 /sys/kernel/fadump_*
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
References: <20191211160910.21656-1-sourabhjain@linux.ibm.com>
 <20191211160910.21656-2-sourabhjain@linux.ibm.com>
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Wed, 8 Jan 2020 01:36:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211160910.21656-2-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010720-0008-0000-0000-000003474AD0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010720-0009-0000-0000-00004A678D08
Message-Id: <e1e2b967-2e21-cda4-eb0b-ca2b94da3020@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-07_07:2020-01-07,
 2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070157
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
Cc: corbet@lwn.net, mahesh@linux.vnet.ibm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 11/12/19 9:39 PM, Sourabh Jain wrote:
> Add missing ABI documentation for existing FADump sysfs files.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

The patch series adds a new sysfs attribute that provides the amount of memory
reserved for FADump. It also streamlines FADump specific sysfs interfaces.
Thanks for looking into this.

For the series...

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> ---
>  Documentation/ABI/testing/sysfs-kernel-fadump_enabled     | 7 +++++++
>  Documentation/ABI/testing/sysfs-kernel-fadump_registered  | 8 ++++++++
>  Documentation/ABI/testing/sysfs-kernel-fadump_release_mem | 8 ++++++++
>  .../ABI/testing/sysfs-kernel-fadump_release_opalcore      | 7 +++++++
>  4 files changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_enabled
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_registered
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_enabled b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
> new file mode 100644
> index 000000000000..f73632b1c006
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
> @@ -0,0 +1,7 @@
> +What:		/sys/kernel/fadump_enabled
> +Date:		Feb 2012
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	read only
> +		Primarily used to identify whether the FADump is enabled in
> +		the kernel or not.
> +User:		Kdump service
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_registered b/Documentation/ABI/testing/sysfs-kernel-fadump_registered
> new file mode 100644
> index 000000000000..dcf925e53f0f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump_registered
> @@ -0,0 +1,8 @@
> +What:		/sys/kernel/fadump_registered
> +Date:		Feb 2012
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	read/write
> +		Helps to control the dump collect feature from userspace.
> +		Setting 1 to this file enables the system to collect the
> +		dump and 0 to disable it.
> +User:		Kdump service
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem b/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
> new file mode 100644
> index 000000000000..9c20d64ab48d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
> @@ -0,0 +1,8 @@
> +What:		/sys/kernel/fadump_release_mem
> +Date:		Feb 2012
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	write only
> +		This is a special sysfs file and only available when
> +		the system is booted to capture the vmcore using FADump.
> +		It is used to release the memory reserved by FADump to
> +		save the crash dump.
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore b/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
> new file mode 100644
> index 000000000000..53313c1d4e7a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
> @@ -0,0 +1,7 @@
> +What:		/sys/kernel/fadump_release_opalcore
> +Date:		Sep 2019
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	write only
> +		The sysfs file is available when the system is booted to
> +		collect the dump on OPAL based machine. It used to release
> +		the memory used to collect the opalcore.
> 

-- 
- Hari

