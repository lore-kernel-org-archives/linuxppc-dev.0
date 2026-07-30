Return-Path: <linuxppc-dev+bounces-25139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB2DC5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 21:31:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB2SV4gB4z2yH4;
	Fri, 31 Jul 2026 07:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785447066;
	cv=none; b=ZiltG3eyTgNkHUpTcLbZBzB8/qV7Ca46T8dS2pjB1qvo9f0h1RGx1QfMBaIQfGqGde+giirJumiaPsqkN9kkpK+jB8gutPXYPLhn+Par8i0krcTfA+v0zpEPlaHh6rW7eDBf+QM74WmtxhY3mJMTGX0IksDu/2FEGhtdIPdH5CB89S708xPTe/aRJj+Yny4M9ypd2IYLfQV/zL7Bbs2slTxshErULDKMrjnrJjdQwBforuUKzl0GkWBkMG7iRT8qjfM7UHx+Mz/Emdjm6hSYlE/clte5Hy4opDGeu91gEJIKNDBSB1sxR2ToNVdjU++Vaf2uwAw2VeH70R/HvdsFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785447066; c=relaxed/relaxed;
	bh=E+Wy+ys8T2YGZYU3pJ2uSk73N2E6peVZ2dFlyj+MAlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfPy7hWTFPKPSxQ+P7ueq2yq/5uSsr9d/ggZOaaAlEJEsxM0w/HZqjEYiMiTNUxIRl5HuNQgfGWeADBEBZ2XXAjoICGHIay70l9JNv72M/yPuR7Aj5yN3Y7eublGgfTuLNqXL4oFMWfAP0rYtEAexbkE50wvT9xr3MHMtBhBG0YZukizy2LNHkbA5FmjGizmZ1PWsdROsqY0BvTkMl5iwb3ro7PV92hE8RGz4NGVaSRUiktP7ulfmYKyo7AYrmTTJK8440jWhrFQBMS9j4TUBb0Fr6pGmRthq2ONbCscwlRqeLuaP8za3XoDCUejQ6dq8DfPU6JeeMkJ4BiKnaecNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y9cCSoGe; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y9cCSoGe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 123 seconds by postgrey-1.37 at boromir; Fri, 31 Jul 2026 07:31:04 AEST
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB2SS6gGkz2xg8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 07:31:04 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB2Q13np3zlfpPB;
	Thu, 30 Jul 2026 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785446930; x=1788038931; bh=E+Wy+ys8T2YGZYU3pJ2uSk73
	N2E6peVZ2dFlyj+MAlU=; b=y9cCSoGegUOcUo0HM9riyEiyZkWXAVm+kWcewRsV
	rb8wOB5M0jSAKO6dfDMf+RHp7h2XHHnwH9ONTXloihdbJLIqslNHVOU3l15Ai8wg
	VuS9REf/sNlQAGfCTo7zR4JiyaTf+gd9k71CKTjlCEzMN6eIJJ7YC0MCIt37GPm+
	jRrxtZxkFw+YIJTC/8Mm9rZYSIzzWdEyjlB44nhviGc5e4e0dpNhY4oTfZQhZ6yA
	A0yiaLPX7U8Oaxxq0O+FnoW/lTmhPeRJASTD4O6YWeriIPxEKaFGXKNZEz221n6t
	mfGli7WId9TGZ5P/MNh5Pdc2BQYn+MHDmyGoZuUOLxzsxg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7SrJBq3XEcWs; Thu, 30 Jul 2026 21:28:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB2Pr2951zlfvpx;
	Thu, 30 Jul 2026 21:28:48 +0000 (UTC)
Message-ID: <86ee4f27-7303-43c4-b772-b735b85c0229@acm.org>
Date: Thu, 30 Jul 2026 14:28:47 -0700
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
Subject: Re: [PATCH v2 25/33] ibmvfc: process NVMe/FC rports in work thread
To: Nathan Chancellor <nathan@kernel.org>,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, brking@linux.ibm.com, davemarq@linux.ibm.com
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
 <20260723000149.969416-26-tyreld@linux.ibm.com>
 <20260730065226.GA1879117@ax162>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260730065226.GA1879117@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 11:52 PM, Nathan Chancellor wrote:
> Hi Tyrel,
> 
> On Wed, Jul 22, 2026 at 05:01:41PM -0700, Tyrel Datwyler wrote:
>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
>> index 81d9229bf388..ffb579816e84 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
>> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
>> @@ -6073,6 +6119,30 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
>>   			}
>>   		}
>>   
>> +		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
>> +			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
>> +				tgt_dbg(tgt, "Deleteing NVMe rport\n");
>> +				nvme_rport = tgt->nvme_remote_port;
>> +				list_del(&tgt->queue);
>> +				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);
>> +				spin_unlock_irqrestore(vhost->host->host_lock, flags);
>> +				if (nvme_rport)
>> +					ibmvfc_nvme_unregister_remoteport(tgt);
>> +				timer_delete_sync(&tgt->timer);
>> +				kref_put(&tgt->kref, ibmvfc_release_tgt);
>> +				return;
>> +			} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
>> +				tgt_dbg(tgt, "Deleting NVMe rport with outstanding I/O\n");
>> +				nvme_rport = tgt->nvme_remote_port;
>> +				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_DELETED_RPORT);
>> +				tgt->init_retries = 0;
>> +				spin_unlock_irqrestore(vhost->host->host_lock, flags);
>> +				if (nvme_rport)
>> +					ibmvfc_nvme_unregister_remoteport(tgt);
>> +				return;
>> +			}
>> +		}
>> +
>>   		if (vhost->state == IBMVFC_INITIALIZING) {
>>   			if (vhost->action == IBMVFC_HOST_ACTION_TGT_DEL_FAILED) {
>>   				if (vhost->reinit) {
> 
> There is a warning from clang after this change landed in -next as
> commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work
> thread"), breaking the build when -Werror is enabled:
> 
>    drivers/scsi/ibmvscsi/ibmvfc-core.c:6154:15: error: variable 'rport' is uninitialized when used here [-Werror,-Wuninitialized]
>     6154 |                         } else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
>          |                                    ^~~~~
> 
> Sashiko appears to point this out as well:
> 
>    https://lore.kernel.org/20260723005006.C7EE21F00A3A@smtp.kernel.org/
> 
> But I am not sure that its suggestion to use nvme_rport is correct given
> the context of this code, hence just the report from my end.

I think that advice is wrong because nvme_rport has not yet been set if
the "else" statement is reached. How about the change below?

Thanks,

Bart.

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c 
b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index dfa231b6cc47..9e752978dad8 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -5984,8 +5984,6 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
  {
  	struct ibmvfc_target *tgt;
  	unsigned long flags;
-	struct fc_rport *rport;
-	struct nvme_fc_remote_port *nvme_rport;
  	LIST_HEAD(purge);
  	int rc;

@@ -6103,6 +6101,8 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)

  		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue) {
  			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
+				struct fc_rport *rport;
+
  				tgt_dbg(tgt, "Deleting rport\n");
  				rport = tgt->rport;
  				tgt->rport = NULL;
@@ -6115,6 +6115,8 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
  				kref_put(&tgt->kref, ibmvfc_release_tgt);
  				return;
  			} else if (tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
+				struct fc_rport *rport;
+
  				tgt_dbg(tgt, "Deleting rport with I/O outstanding\n");
  				rport = tgt->rport;
  				tgt->rport = NULL;
@@ -6141,6 +6143,8 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)

  		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
  			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
+				struct nvme_fc_remote_port *nvme_rport;
+
  				tgt_dbg(tgt, "Deleteing NVMe rport\n");
  				nvme_rport = tgt->nvme_remote_port;
  				list_del(&tgt->queue);
@@ -6151,7 +6155,9 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
  				timer_delete_sync(&tgt->timer);
  				kref_put(&tgt->kref, ibmvfc_release_tgt);
  				return;
-			} else if (rport && tgt->action == 
IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
+			} else if (tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
+				struct nvme_fc_remote_port *nvme_rport;
+
  				tgt_dbg(tgt, "Deleting NVMe rport with outstanding I/O\n");
  				nvme_rport = tgt->nvme_remote_port;
  				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_DELETED_RPORT);


