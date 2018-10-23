Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E11C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:43:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAACC20652
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAACC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42flhX0pKdzF37D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42flfR5JDKzF36T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 07:41:19 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9NKYUiI092244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 16:41:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2na9uc2yh4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 16:41:16 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 23 Oct 2018 16:41:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Oct 2018 16:41:13 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9NKfCwH37158972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Oct 2018 20:41:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F30FAE062;
 Tue, 23 Oct 2018 20:41:12 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0D0EAE05C;
 Tue, 23 Oct 2018 20:41:11 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.156.158])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 23 Oct 2018 20:41:11 +0000 (GMT)
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 23 Oct 2018 13:41:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540326197-15537-2-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18102320-0052-0000-0000-00000348938F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009922; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106969; UDB=6.00573292; IPR=6.00887053; 
 MB=3.00023877; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-23 20:41:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102320-0053-0000-0000-00005E840727
Message-Id: <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-23_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810230168
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
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/23/2018 01:23 PM, Breno Leitao wrote:
> Current core-pkey selftest fails if the test runs without privileges to
> write into the core pattern file (/proc/sys/kernel/core_pattern). This
> causes the test to fail and give the impression that the subsystem being
> tested is broken, when, in fact, the test is being executed without the
> proper privileges. This is the current error:
> 
> 	test: core_pkey
> 	tags: git_version:v4.19-3-g9e3363be9bce-dirty
> 	Error writing to core_pattern file: Permission denied
> 	failure: core_pkey
> 
> This patch simply skips this test if it runs without the proper privileges,
> avoiding this undesired failure.
> 
> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> index e23e2e199eb4..e07949120fc8 100644
> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>  	FILE *f;
> 
>  	f = fopen(core_pattern_file, "w");
> -	if (!f) {
> -		perror("Error writing to core_pattern file");
> -		return TEST_FAIL;
> -	}
> +	SKIP_IF(!f);
> 
>  	ret = fwrite(core_pattern, 1, len, f);
>  	fclose(f);
> -	if (ret != len) {
> -		perror("Error writing to core_pattern file");
> -		return TEST_FAIL;
> -	}
> +	SKIP_IF(ret != len);

If we don't have proper privileges we should fail on the open, right? So wouldn't we still want to fail on the write if something goes wrong?

-Tyrel

> 
>  	return TEST_PASS;
>  }
> 

