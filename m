Return-Path: <linuxppc-dev+bounces-23894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B90CC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwkvp6Bl5z3c9q;
	Thu, 09 Jul 2026 16:05:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783577110;
	cv=none; b=jQY4A4Q+K4px+FWKQeFUzACZn+MSpbyIWuuR3Qriveq/C9IlTHew/Nr7q6eq+yRkFp8vDhjrIuVRxQOU9aBGwLypoFMZPWM1L7S/Nk+cKyn4ClxnWdGq9HGTdfSxzIYNw9lHN+Y7FPNCEoVysvg04K3sP+91XhuNWiIKVTgDCVGdL0I/C/dMYT0AwIwCK81jX0EaNXECCPMNx/PP8US7JghwBavYamjejXf6eLPGFTHRM6GbTisF2vGa0mgPh6nVimSl4QYLm/iSsUjnb4RaW6WS3k05W2HbtYFiTOuX7tsqE8Qi73uQKD4+PvSWt3+OM8WCWFonvzaAq6DcjzWBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783577110; c=relaxed/relaxed;
	bh=MaURNeDpnjqRSQau6Nhr2Y5wDApW/HZMFelrdRwArdM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=i+B4ycO3nV4UVQ1ATT0P7mdums2bYcw/Or3sdZabRAE5NOp046JD0d/UtaRM6AmcpU8a3U09U7Iqez0GWTw6IaYn+usMmgh/YdRs2srmj425atzZZ3EZBQUmrFUUyu6ozAFONEtLDkel/IE749odSYjMffDie5Oz+J46kLy6o5534oXqdq1Jj82aMeab/WCbcUpCJ3nJECPMer3bj91d1TwOMlTnnVF85+YSgg2fqtyNxkOGgsLObEYbZlcR5lrkm+v2lxVIBzYYQguhXWb1TsR1XfbP04Ka9puJsbKi9R6jyQkSkdSasbiD2EwcXahBbzdL3ZDGPfFED0pLUyKsdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dWndSqvm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dWndSqvm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwkvn0Qq0z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:05:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NIOHP517254
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 06:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MaURNeDpnjqRSQau6Nhr2Y5wDApW/H
	ZMFelrdRwArdM=; b=dWndSqvmmIh/bwur5tOlcXIZaxOR0+LKwE7Qynq2Xzknkj
	TDZmtjIxTcf6zyWVngdtDZZ/R197QPnx8+7Ys0ek3Z5/gsuoP3KzhauL4rgu/Pul
	7cnEE0U+VKofzG7qt4M7VdjzdNHqCKKyLedjmLGzhtDYcFZEzAM2FNQvSLaGu6oS
	uBqifMKhSvbTRG9mVLgIUAfT1XPBWBybPyeic8Z7yP6LANYFkw4htxPIFEYreznM
	fG4pmFbzlDvhUSp2jQpfDorkDcsmq/sCRAqnbkQj/aUazs82fTpKQ0WCM/eLNUOt
	WkYOq6MZZBEX+H6rHAm1/HSKs3CFpRyejctCtrew==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp40b9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 06:05:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66964wjU028564
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 06:05:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkbtpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 06:05:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669651jT14811576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:05:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFCD20043;
	Thu,  9 Jul 2026 06:05:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A412020040;
	Thu,  9 Jul 2026 06:05:00 +0000 (GMT)
Received: from [9.123.10.251] (unknown [9.123.10.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:05:00 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------CfFEaH37DQxDBboiwVJ43hV7"
Message-ID: <38c260b6-2811-427b-9a3c-fa15a6610f87@linux.ibm.com>
Date: Thu, 9 Jul 2026 11:34:59 +0530
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
Subject: Re: [PATCH v2] powerpc/powernv: Cache OPAL check_token() results
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
References: <20260626123534.396456-1-shivangu@linux.ibm.com>
 <1be96e32-ac9c-4160-9f2b-23eb29c22893@linux.ibm.com>
 <fa47cb85e275b9374efbf0f992281fa196ddf8ec.camel@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <fa47cb85e275b9374efbf0f992281fa196ddf8ec.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4f3a12 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=Y61ikR5K0xEnZfnFPYIA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=X53qnVIy8OwRMfglmxkA:9
 a=DAU0tV2CR2rgxFh8:21 a=_W_S_7VecoQA:10 a=3ZKOabzyN94A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX0sz10tfGjQlJ
 0f0W8ezfhTfYUJV7uN3w0HeSZpyEhEF7ET0Q6xiTKfp7OqVkC0XoExOHYnaBztKMpLSPYeDtakg
 yVV+JVsqlsMpilqVfoq8EjGhC5ycbL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX3IEdsdyH57p1
 PL+N9Ei99cpRiiClTegeVmoO5UfvskDANBSnNVIWI16LvvB2qteIEBqza9LOWqnVCJ/7cIs9ddF
 tHUNwwKPtwVHzuaCFMvj6LHqDz6roHR8jBZ7tXaEw0vFBXVxT2naB9a991xX+cs0bRdYjz9WWsL
 8Yh1YwcMkHrnj03aQJITBFtfumnJ2NQrk4NmyPoQMewlr42Zojy3YtrOCHw2SgpQ6M931HmJTuk
 U8MUjBwbHOeSNS9nBdZou+X4KyNh39/F/IwnglrTIK1Gw4NmcZoisnAXcnlu4Vdid9h8UA6KC8T
 +2GpI3nubITvHR58Y+5ae8rorX7XiCq9Em+Wek8jpKPqMILmujCfZVUTv10PgCZ08p11v9iw+sm
 ixFIg7PXT6oGQv9FBns8ANRKJ1Pav6+7sJ8KQcu1biKttPPskWd52m+OnI2CsuB78KAxYLIhoqC
 xip3kWqbP7/UV/S1VwA==
X-Proofpoint-ORIG-GUID: swEogFKYWg4R30_qbDRO9kkHDkBPIX8z
X-Proofpoint-GUID: swEogFKYWg4R30_qbDRO9kkHDkBPIX8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090052

This is a multi-part message in MIME format.
--------------CfFEaH37DQxDBboiwVJ43hV7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I discussed this with Sourabh, and we confirmed this function is 
actually not on a hot path. However, he is open to the idea. Please take 
a look and see if adding unlikely() provides a meaningful benefit here, 
or if it falls into premature optimization.

Thanks
~ Nikhil

On 08/07/26 14:02, Shivang Upadhyay wrote:
> On Tue, 2026-07-07 at 12:36 +0530, Nikhil Kumar Singh wrote:
>> You can wrap the if (token_cache[token] == SUPP_UNKNOWN) check, as 
>> well as the if (token > OPAL_LAST) check above it, with unlikely(), 
>> since this function is in the hot path. Out-of-bounds tokens are very 
>> rare, and after the cache is populated, the SUPP_UNKNOWN condition is 
>> expected to be false in almost all cases. Wrapping these checks with 
>> unlikely() will help the compiler optimize branch
>
> Thanks for your suggestion, but Which hotpath code is calling this?
> we can maybe change that hotpath to not do rtas calls.
>
> ~Shivang.
--------------CfFEaH37DQxDBboiwVJ43hV7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>I discussed this with Sourabh, and we confirmed this function is
      actually not on a hot path. However, he is open to the idea.
      Please take a look and see if adding unlikely() provides a
      meaningful benefit here, or if it falls into premature
      optimization.<br>
      <br>
      Thanks<br>
      ~ Nikhil</p>
    <div class="moz-cite-prefix">On 08/07/26 14:02, Shivang Upadhyay
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:fa47cb85e275b9374efbf0f992281fa196ddf8ec.camel@linux.ibm.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Tue, 2026-07-07 at 12:36 +0530, Nikhil Kumar Singh wrote:</div>
      <blockquote type="cite"
style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div>You can wrap the if (token_cache[token] == SUPP_UNKNOWN)
          check, as well as the if (token &gt; OPAL_LAST) check above
          it, with unlikely(), since this function is in the hot path.
          Out-of-bounds tokens are very rare, and after the cache is
          populated, the SUPP_UNKNOWN condition is expected to be false
          in almost all cases. Wrapping these checks with unlikely()
          will help the compiler optimize branch </div>
      </blockquote>
      <div><br>
      </div>
      <div>Thanks for your suggestion, but Which hotpath code is calling
        this?</div>
      <div>we can maybe change that hotpath to not do rtas calls.</div>
      <div><br>
      </div>
      <div>~Shivang.</div>
      <div><span></span></div>
    </blockquote>
  </body>
</html>

--------------CfFEaH37DQxDBboiwVJ43hV7--


