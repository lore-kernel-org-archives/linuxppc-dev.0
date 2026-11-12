Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA7606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kHiIB1bW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQKQs6Kltz308H;
	Thu, 12 Nov 2026 23:27:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794486453;
	cv=none; b=CDVKScsL6EMNTp8p2wzzE5187cbTSInSZQaUFvsbZfe4/Ivh7OFsu8FhbG+kR38Ljg/qDIB35cKNbpgtsKGb5dfk6Vtwd6ONDvScvba9yhBtYQF6lQ/j0coMw7Ji55/8DIplAkFPSbRZcv+MVJ1VYcp/UgmuT2dwxNTIMpaYul2Aiuihq69cCaYmJ9ZMXhHrAVCFUEYNVWxqFQBQfBnItFBaSOn92h5B2N8vFPeCsrxtwfVik63WsuXI9Apt4N5lUc+h1005Qh++9nmmLj+uzDENVAK7jXbnzNRTs4Q+74cilxDTxsD2Z7AfMb2cMTxWPksy/pxlroCopT2NC1VRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794486453; c=relaxed/relaxed;
	bh=6zIF2mscWWNdqPdPpywMELCgP+4wYM3ffEmTeqpAw4o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TQwi5VdiocX0pf8IG/vPGPxLqJ4TobEjaRkMQ9MD5zuRD2S+YMw4fNXmwlWttwyQs07aQ6o1D706TgnGFSpdtqaAaJS58QoPn2/20gitXuUzip520SJMOafIjW4BwksLo+ny8KdYhE0nPnr1J1hjo7rzGqfSUGlDIdHx6UaTT84m7Pq2XbX+0tk2Ct9z8XosVnHSKjF+QsEfPPIL9G+EwRN4xgkeiK639wbzLz8xdrxmo32Wu35ErYDA1Q5LyBkh9qSYLGcuQC0zNO43Gygz5APHta+an+EFex4Kf3jEYlAT6Hb0IRLNAxo2jn8gJt4xCG7UG3CJwYXV8uC3TCoNFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kHiIB1bW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kHiIB1bW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQKQs0xRMz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:27:32 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iL0A1214781;
	Thu, 12 Nov 2026 12:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6zIF2mscWWNdqPdPpywMELCgP+4w
	YM3ffEmTeqpAw4o=; b=kHiIB1bWyrkRYoH21DvGNfwM6coLugLCAeOYLOo+0O6I
	MSRSgK+Eb0gb7F9h3zi336apegwmAMLE1efwDWvP3D5plkxNxy6CKrC1VisMoz40
	4QuDUsxiBwYjOrAbQPOSHZSaU9Q8/wjXf6gEPzfuZZ1W4K+hEubHrTVXQowhdIys
	ZNnIy2KjW2NDm30seSVwjYETbJpam8hTWn05YoG99D1kvIfJiudEDy6ROUwHU3+L
	IfBerHM3bvrMI4hv4HOHOaFjtlteTKORAGBhNxsVY4Y80msceYTTnB+Gk2XiQyj/
	ttCvSNJILlFas7/Gqdm/wFYt0WT10a4ezX5PNLffEw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntfdu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:27:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8Lvmf097884;
	Thu, 12 Nov 2026 12:27:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0w7sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:27:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACCRPWQ26346036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 12:27:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F066D58059;
	Thu, 12 Nov 2026 12:27:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31E5058055;
	Thu, 12 Nov 2026 12:27:22 +0000 (GMT)
Received: from [9.61.240.49] (unknown [9.61.240.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 12:27:21 +0000 (GMT)
Message-ID: <bc84cb05-55fe-43e7-9a6e-e6bbf2f5a9ff@linux.ibm.com>
Date: Thu, 12 Nov 2026 17:57:20 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: mszeredi@redhat.com, Shuah Khan <shuah@kernel.org>
Cc: luis@igalia.com, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nandinih@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG / BUILD FAILURE] selftests/fuse: build failure with libfuse <
 3.17.0 (RHEL 10 / fuse3-3.16.2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX0JfJ6hzcRhBo
 3pYzaJxWCP83/cPc0kLSsIDPYdNyeWt8FbyWRuQat9/3XZ2iKw95G177cPiCqpYJ2tf8vfzAK1v
 BHUHeQT9VgxLgGwtPrIW9XG86dP5iBk9B5urNmoApmLLUyRuMn+HNtbu02fmAG5TY2vp3OPZqyA
 lYbrdVyHDqkVjH2vWQDVu6H23HDWtNhzb+wKoKn4jLPSWu5ZvcMgejzDYz+SR0mbaEx7jrcqXhV
 59ToqtEZ+KD40OVTp6DTSbo9QFxaACTg/HYhdMyfuKZdrqJq5wIe1mnBmLOdocp+3QsK9gpkciT
 Q5yZPCcCbmMUVabGdk38GTXGmzNZgPgByNPKrbZJD+Jprcfmtf96OjG/LhIVdEODuP1oKOi907q
 y5OBDT7ZhqsQ25ZZfoXeJWd5zdFXoTALrJ1PwmK98nNgaS83KhJSo8fqYHSY4ku91IJ9Dmgim4J
 N7wmogzN8iSjaOwOHgg==
X-Proofpoint-ORIG-GUID: 5QlD2gsgulIE-MaNq1rxj5110MS0lzWu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX1UvpJ0LrrdRE
 OpEqesTwMy+Eh2HcYAyPJoXqePAAbBSe49rAX4i57i0CGqUSXarIJFXCqGxB9WRn6sNrcEGJ+5A
 CYKwysiMIwfglqKSSzW7MubjHd6u080=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5b0af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=G8bnuFaaA9ZLbBnholgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ADQL8XVHLD3II553328d1E9yRtxsIZum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Miklos, Luis,


IBM CI has reported a build failure, while building selftests/fuse, due 
to missing definitions in libfuse3 headers.

Environment:

OS: RHEL 10 (ppc64le)
Kernel: upstream (linux-next / mainline)
libfuse package: fuse3-devel-3.16.2-5.el10.ppc64le (pkg-config 
--modversion fuse3 -> 3.16.2)

Build Errors:

In fuse_acl_cache_test.c & fuse_symlink_cache_test.c:

fuse_acl_cache_test.c: In function ‘fs_init’:
fuse_acl_cache_test.c:105:17: error: implicit declaration of function 
‘fuse_set_feature_flag’ [-Wimplicit-function-declaration]
   105 |                 fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
       |                 ^~~~~~~~~~~~~~~~~~~~~
make: *** [../../lib.mk:226: 
/home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test] 
Error 1

In fuse_mnt.c:

fuse_mnt.c: In function ‘test_readdir’:
fuse_mnt.c:51:35: error: ‘FUSE_FILL_DIR_DEFAULTS’ undeclared (first use 
in this function); did you mean ‘FUSE_FILL_DIR_PLUS’?
    51 |         filler(buf, ".", NULL, 0, FUSE_FILL_DIR_DEFAULTS);
       |                                   ^~~~~~~~~~~~~~~~~~~~~~
       |                                   FUSE_FILL_DIR_PLUS
make: *** [../../lib.mk:226: 
/home/upstreamci/linux/tools/testing/selftests/filesystems/fuse/fuse_mnt] 
Error 1


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,

Venkat.




