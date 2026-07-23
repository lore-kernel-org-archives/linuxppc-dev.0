Return-Path: <linuxppc-dev+bounces-24731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6813AC531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:01:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5WTn5Qv0z2ygG;
	Thu, 23 Jul 2026 23:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784802478;
	cv=none; b=R4izRyC0LIW7UJhcFIJoeIaZUfA1w+bRlLnOH1vvce6PKKTaRrJD+uh7zzaDFFuR5v4z/9AwG/sRUQ6K9EruEncWUhzU+5NEA/duKhdSg/3xZNMcuUtXmFACY4wRmW5EElLcgXGDuz2gLP2JLMr0i59CNtpYrwct7eXkHoLcdUv+pAIG5/Y6SaFJb+pcCCRtBEGAyLL7i6ot5ZWee8PbGB2blhQph4nogbgQns2pCx3abarI2f1UFPx363Ayhrm47M3/DCQ2q6H6/jO7icsY06flBspiMOH4bXZoT8e9oLDmJnsWYpFzZMVlC8ZYKDNpLvKglCJMqpKAud/71ccx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784802478; c=relaxed/relaxed;
	bh=lVb+x1eJeMDbnGatYezDXk3mRUPsqyFLA5zoJctRxBo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=YWEPDotfVb7mo1P0WixfT8eKHBzMLfkPaSnGuGP6oARxWJH14LkD6H43jFlWlV9jCDAOjom0ZUI/nhapxviJF87IT0ZBVEyrBV3RRJQR18mrP36XNPhsBnIUPRTrCsdUSTCwJOCMcm3g4lig2vbUea6hGNvsugTDCCPVpcgrgACeqXYG74A/fXIw1lq76zy35Mg7utHLDZ/3IZJSFl3RCNERXLNkwk8cBGz9xANiH52skyi0f4rlrogJyOuxI/9pgy3Gg7qA6M0WH9MtiWKpYL1jBwGXwuSNkwT8dSCp2vKDEYhJi2MYmqjOHYTy2/59ZZvuueD1mlQpSPZKfp/XSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ayIkWdbc; dkim-atps=neutral; spf=pass (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ayIkWdbc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5S4V454lz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 20:27:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784802402;
	bh=lVb+x1eJeMDbnGatYezDXk3mRUPsqyFLA5zoJctRxBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ayIkWdbcS8JO9TRkwXNVvV2cMsNZ0/V1CHIycRnvvpQJ2sIEva0zrkTBdinJ062Hc
	 JY0IFEVk8Q0Lqf/FIT6Dxt+8OiAskya3/+9VYV+Mt7kWJlDMn1pkJv1K5kLrsNd27s
	 P9av69av7dEem/7DdCYc1Tna20zTcmNKmPBB83rg=
X-QQ-mid: zesmtpip4t1784802386t9c54a72f
X-QQ-Originating-IP: memIhR9gvQ4ZmW+tM9XGn6iEAQmEwf7u2uI7gKQx180=
Received: from [IPV6:240e:659:1b0:640::113:101 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 18:26:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5317163867551177588
EX-QQ-RecipientCnt: 26
Content-Type: multipart/alternative;
 boundary="------------4HCosMQF2fkroIavSbgGnprv"
Message-ID: <2B4E356BD3ECC2A3+5e1ad5e2-b34a-4ccd-a11f-60957a20e7b5@uniontech.com>
Date: Thu, 23 Jul 2026 18:26:22 +0800
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
Subject: Re: [PATCH 1/4] powerpc/xive: remove dead NULL check after GFP_NOFAIL
 allocation
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com,
 jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, ynorov@nvidia.com,
 namcao@linutronix.de, sshegde@linux.ibm.com, nilay@linux.ibm.com,
 kees@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, gouhaojake@163.com,
 kernel@uniontech.com
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-2-gouhao@uniontech.com>
 <amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Reply-To: 20260723081813.176792-2-gouhao@uniontech.com
From: Gou Hao <gouhao@uniontech.com>
In-Reply-To: <amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MiiIZxVYHKtyBDx+D5bHAmbtn8grGwzQ35gLx0CbWpEw3ujXVkRUmP0k
	M1yxTahfQ70c0Y21c3k8c84EX63ZO1CrPvaKwU3KQgLQpqB+q0FfXYd7SSbqSuLncBx5M1p
	O8s5Gw44qym4i5gaI7NIi6fV+bWDK3Y6ndGT6GYS0qRSHi4VdEjA656RRMfckpYNGqaJ6Ct
	3Cd8aPzmSm/bv2pYcHijAtT5TMl12sDSAEdjdg6L/+Y05Ap76SAWMXUMRyr8j6+hSfqiLqK
	vXstOKEDfR24TgvCi1lezRQeRO5G/4Vox4re+htW2HdWCvyeeqnFsUzZYnwQQh/4YPXyh8y
	Fk3KMxx/VfBYczrbNO2suR5/R5SHalxOuxuleZfSuU748xnvDxrdbjgB3dA3tpA2fVuLLCw
	bMb4eKnudk5zfKzoWRJDrrs93TXYMwluzIWZSDMKzh1FzWwheHx8U+3f+0gKGqHI4liqIZO
	gJL42QL0iywC/uPKSK3nXuqxB+Mq0cayDUTmZ/ODanX+GBd99V9j5o7ZU851d0luZTLMl5e
	z4+UMTUXD7NfG8JZrUCCgsS9i2ujQtEPiOLPJCxrSV6DpcL+RPo4+O2uYtiVhZQH+w+5/pL
	odbsAVq71fX7dfmScfMPIHQ0HJv7TI6NifVipOFsteFwFjNDZXBYbXGeBGuUgzPGh0iuqLW
	8tyoyPR9nACwgeZsIETc9kUPBjY0n78hxUNB+erNlXQ3DatvVipDS8oEMYtn1j1Bc2eF5w/
	iCK2z95/fvKy4qSlUftzPASKL0RTPoEoi4LFTBZKs68Tf2p4MlV6A1CsQLZvExjXr70Z59i
	sYxz7x3LEK9NkKPOeKTRjTGu9XiCBhEAHSnI+b2UX6+jMKiBm0uEnvQFzYgE7I4heV7V7Gg
	NOSBVPzeBTZrIftWUSn7oL3OqcMm1YGvmZsgOPMicWUg8fys+0HGc5dicPReXBZCCquL6KB
	o6U3zXocSLAARRxY1xYhZ3QLwRhMa1vtDKWQGp7oNLttI73bKqXqs0C6b9nhqabt88VhPbY
	FEDa5PLEPj83qFgQMGGNBEYprayD1SqgQ66WaBIkto9FHlLOU6Tx4L9kXeLLU5UHQAm9Tz5
	rfE4qFTmp+2bKfneUmV8PBum/qECbbH2nGwDvWZj8uk+Z8SxuNgDAxJtb/VbC+Eag==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

This is a multi-part message in MIME format.
--------------4HCosMQF2fkroIavSbgGnprv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/26 17:37, Mukesh Kumar Chaurasiya wrote:
> On Thu, Jul 23, 2026 at 04:18:10PM +0800, Gou Hao wrote:
>> kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
>> subsequent NULL check is unreachable dead code. Remove it.
>>
>> Signed-off-by: Gou Hao<gouhao@uniontech.com>
>> ---
>>   arch/powerpc/sysdev/xive/common.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>> index dadd1f46ec93..79d7854259cb 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
>>   
>>   	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>>   				 GFP_KERNEL | __GFP_NOFAIL);
>> -	if (!xive_ipis)
>> -		goto out_free_domain;
> This will be an unused label after this.
>
> Regards,
> Mukesh

Thank you for the review. I will fix it in the next version.


thanks,

Gou Hao

>> -
>>   	for_each_node(node) {
>>   		struct xive_ipi_desc *xid = &xive_ipis[node];
>>   		struct xive_ipi_alloc_info info = { node };
>> -- 
>> 2.20.1
>>
--------------4HCosMQF2fkroIavSbgGnprv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
</p>
    <div class="moz-cite-prefix">On 7/23/26 17:37, Mukesh Kumar
      Chaurasiya wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Jul 23, 2026 at 04:18:10PM +0800, Gou Hao wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL check is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <a class="moz-txt-link-rfc2396E" href="mailto:gouhao@uniontech.com">&lt;gouhao@uniontech.com&gt;</a>
---
 arch/powerpc/sysdev/xive/common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dadd1f46ec93..79d7854259cb 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
 
 	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
 				 GFP_KERNEL | __GFP_NOFAIL);
-	if (!xive_ipis)
-		goto out_free_domain;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">This will be an unused label after this.

Regards,
Mukesh</pre>
    </blockquote>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">
</p>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Thank you for the review. I will fix it in the next version.</p>
    <style type="text/css">p, li { white-space: pre-wrap; }</style><br>
    <p>thanks,</p>
    <p>Gou Hao</p>
    <blockquote type="cite"
cite="mid:amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-
 	for_each_node(node) {
 		struct xive_ipi_desc *xid = &amp;xive_ipis[node];
 		struct xive_ipi_alloc_info info = { node };
-- 
2.20.1

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------4HCosMQF2fkroIavSbgGnprv--

