Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78644C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:48:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46CF2080A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 15:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46CF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lXmn2DBTzF3G6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 02:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lXjZ3DVjzF3Kx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 02:45:37 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9VFiadd055700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 11:45:35 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nfd9dxhtj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 11:45:35 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Wed, 31 Oct 2018 15:45:34 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 31 Oct 2018 15:45:32 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9VFjVAO20971720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Oct 2018 15:45:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C48C6055;
 Wed, 31 Oct 2018 15:45:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D84C0C6059;
 Wed, 31 Oct 2018 15:45:29 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.223.149])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 31 Oct 2018 15:45:29 +0000 (GMT)
References: <1540996702-27161-1-git-send-email-leitao@debian.org>
 <1540996702-27161-3-git-send-email-leitao@debian.org>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 3/3] selftests/powerpc: Skip test instead of failing
In-reply-to: <1540996702-27161-3-git-send-email-leitao@debian.org>
Date: Wed, 31 Oct 2018 12:45:27 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18103115-0012-0000-0000-000016D2210D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009960; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110673; UDB=6.00575520; IPR=6.00890766; 
 MB=3.00023981; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 15:45:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103115-0013-0000-0000-000054F478D1
Message-Id: <87zhuup1bc.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-31_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310131
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
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Breno Leitao <leitao@debian.org> writes:

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
> CC: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> index e23e2e199eb4..d5c64fee032d 100644
> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> @@ -352,10 +352,7 @@ static int write_core_pattern(const char *core_pattern)
>  	FILE *f;
>  
>  	f = fopen(core_pattern_file, "w");
> -	if (!f) {
> -		perror("Error writing to core_pattern file");
> -		return TEST_FAIL;
> -	}
> +	SKIP_IF_MSG(!f, "Try with root privileges");
>  
>  	ret = fwrite(core_pattern, 1, len, f);
>  	fclose(f);


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

