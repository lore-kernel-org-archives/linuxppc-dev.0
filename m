Return-Path: <linuxppc-dev+bounces-20580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7506CD37AA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 22:34:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBRrC1PR7z2xLr;
	Fri, 08 May 2026 08:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778193259;
	cv=none; b=Bz9VMCQoeXrepOAxrlmu38w20B+tnQavUktCjppZ2siKvnWaaLeJnGV6G+k++bgUMKwK6xFHEeOQYy5xJIhMKgL4TppNlw21T/5Xfe4rZ5pTn47o90vYSKI8JQ9JlxtkzEdoVMFA1T2Ix9PGCWlULikgQV3C8FJwibDMT3ZMmn+2ozs7lt/uJs8U0ekz0noPfkIqnvDnLFQNYzCp1yKNevA1rXwkly3mSDoZSsxQ/PicesaD8gPZ1+T+CSg/7G3lHdDUYNE5Dm1z5nOR2lbfBXfT8+/tkaKPRKeJYaJ77FpdC0dgQPBC5cesfMTv61CkiNDJijwjb/xkQf4vrExYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778193259; c=relaxed/relaxed;
	bh=WZzxH25ekfhKMKa5K7BfzWY/cp6ynNe+fF+Fd2EPhZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VhTwLvEqy4SveLduDyO5XQQZ3Ka9E1gCb9HwdFyVyMJurDZnKZfPLKHH1V7Ii7DMYyhxgL62GUj5oLbjBFpTrnsmZrMYEdXGvXe70avkdoqJJXqgHE+9gHJlUScq2v6ZFAcvl+9wjgyUaARoYz9pPEeygv/BLYzzDr3uYrZ+QgU1vG1F1RfL4AoNACqw8SAXQ2+5hKV9PYdIC8Qk0REKQpIrP+tMVZDs2Jsbfa7PL8HEwKSg4nnfs9eAHrb6QrolB7qMo6t7d4adc++YOsDjz5hIL5mVm5L92d3vgosvkMDpiPOzme7ZV8IDaxf2qYeg/MQqMBryLCLpSnTpJB0xBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VaFSv8FP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VaFSv8FP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBRrB1Cgkz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 08:34:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647HX7x01117863;
	Thu, 7 May 2026 22:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WZzxH25ekfhKMKa5K7BfzWY/cp6ynN
	e+fF+Fd2EPhZw=; b=VaFSv8FPGofIlABP+v/hbgB0xGlNYRKU48D890qRTFjLh4
	QhEgxFiknzpLa2qxDtVwYsX0G3tNrsEke5DItoeBqg3OEnWpqwA9MC9vN4J3GGiK
	pgmzAeZfcVBFFaX34qQjdOMDNiP1q+E7nFSVaKrBOQ92xjSih2MqPbifzEbV5UIH
	KScWTxf2VL+ErR8F1z5CvKCNUae8Ble1p0bTWWhIxnh6VMfDYCk5TsC7yC5X4hj2
	LBpZyp0dsngew19jbgZ6UBPAeFXVNMSI62+bP9VLKfvXkGJijV503YJ2Hlz/DOQ9
	ZOgIoDhJVkp0+d/hDPZZsHJjLgR6oFmS1naBgbuw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x51280-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 22:34:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647MOR6a002625;
	Thu, 7 May 2026 22:34:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywdw65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 22:34:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647MY5jo31195814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 22:34:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 754CA58070;
	Thu,  7 May 2026 22:34:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A2BB58067;
	Thu,  7 May 2026 22:34:05 +0000 (GMT)
Received: from d (unknown [9.61.133.117])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 22:34:05 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King
 <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch
 <kmahlkuc@linux.ibm.com>
Subject: Re: [PATCH 3/5] ibmvfc: make ibmvfc login to fabric
In-Reply-To: <e8dfa3f2-2b2b-43c0-97a1-6bccb748ca6e@linux.ibm.com> (Tyrel
	Datwyler's message of "Wed, 6 May 2026 22:03:22 -0700")
References: <20260408-ibmvfc-fpin-support-v1-0-52b06c464e03@linux.ibm.com>
	<20260408-ibmvfc-fpin-support-v1-3-52b06c464e03@linux.ibm.com>
	<e8dfa3f2-2b2b-43c0-97a1-6bccb748ca6e@linux.ibm.com>
Date: Thu, 07 May 2026 17:34:04 -0500
Message-ID: <87ik8yetnn.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIyNCBTYWx0ZWRfX/iEJpmiydD3z
 9USB1MeLtL8HdJrj662Sjjg8WHfEgfrrDIuoPcZPz1V1PJ4eWg6q1kowjPLSD+tZl4QysdNXkhW
 ytF1+A3/9YMC/qirGCEd2TopgKBKhSPHl9W3+38wpnC5XSHuYKsHL1l2AcfABrSOz22pRy4vd2I
 ibeSyHArVva6g1Yayux/i87EuF4yriGVtNGYIztC5IfOrF0FffFe45/KU8UCG9o+eZepnKp5lzG
 OXiBRtZampYNcwgQajyK/3BaEsyjiKiMBMFEtQ2ZXZ4pG8jyVzf0VHvR9rWOGdudJSML9BPVwjr
 ebof2cQStcYbd3CpKcC2LCMFJbku9jwgziF78PAk3Z8/rMWpgVnRLWYOfPnMO2ZAzGxrNKq+TMP
 9cfe5OqGQKeFtlfIYHtXZGg6LHyipXetsK7RAu40xTPgePLe5cU7w1upfxeWp+MBRT4n9/JyuDT
 JEGaM3mOHp7hYELSTWA==
X-Proofpoint-ORIG-GUID: ryb9euMtB8YuL4Iub4sOcEGQPPRjUSB-
X-Proofpoint-GUID: VKi16QoGfhSYs2O0RI4y3kZeQTdSSLnU
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fd1360 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OZBBFSiMX2Yuf86NJtQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070224

Tyrel Datwyler <tyreld@linux.ibm.com> writes:

> On 4/8/26 10:07 AM, Dave Marquardt via B4 Relay wrote:
>> From: Dave Marquardt <davemarq@linux.ibm.com>
>> 
>> Make ibmvfc login to fabric when NPIV login returns SUPPORT_SCSI or
>> SUPPORT_NVMEOF capabilities.
>
> Again better commit log message here and developer sign off tag.
>
>> ---
>>  drivers/scsi/ibmvscsi/ibmvfc.c | 100 ++++++++++++++++++++++++++++++++++++++---
>>  drivers/scsi/ibmvscsi/ibmvfc.h |  20 +++++++++
>>  2 files changed, 115 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
>> index 808301fa452d..803fc3caa14d 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
>> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
>> @@ -5205,6 +5205,89 @@ static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
>>  		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
>>  }
>>  
>> +static void ibmvfc_fabric_login_done(struct ibmvfc_event *evt)
>> +{
>> +	struct ibmvfc_fabric_login *rsp = &evt->xfer_iu->fabric_login;
>> +	u32 mad_status = be16_to_cpu(rsp->common.status);
>> +	struct ibmvfc_host *vhost = evt->vhost;
>> +	int level = IBMVFC_DEFAULT_LOG_LEVEL;
>> +
>> +	ENTER;
>> +
>> +	switch (mad_status) {
>> +	case IBMVFC_MAD_SUCCESS:
>> +		vhost->logged_in = 1;
>
> I'm not sure I see the point of setting logged_in here since we already set it
> in npiv_login_done.

Agreed.

>> +		vhost->fabric_capabilities = rsp->capabilities;
>
> The way this is currently spec'd out there are no linux relevant capabilities
> coming from fabric login. So, I'm not sure there is a reason to save them at
> this point.

Okay.

>> +		fc_host_port_id(vhost->host) = be64_to_cpu(rsp->nport_id);
>> +		ibmvfc_free_event(evt);
>> +		break;
>> +
>> +	case IBMVFC_MAD_FAILED:
>> +		if (ibmvfc_retry_cmd(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)))
>> +			level += ibmvfc_retry_host_init(vhost);
>> +		else
>> +			ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
>> +		ibmvfc_log(vhost, level, "Fabric Login failed: %s (%x:%x)\n",
>> +			   ibmvfc_get_cmd_error(be16_to_cpu(rsp->status), be16_to_cpu(rsp->error)),
>> +						be16_to_cpu(rsp->status), be16_to_cpu(rsp->error));
>> +		ibmvfc_free_event(evt);
>> +		LEAVE;
>> +		return;
>> +
>> +	case IBMVFC_MAD_CRQ_ERROR:
>> +		ibmvfc_retry_host_init(vhost);
>> +		fallthrough;
>> +
>> +	case IBMVFC_MAD_DRIVER_FAILED:
>> +		ibmvfc_free_event(evt);
>> +		LEAVE;
>> +		return;
>> +
>> +	default:
>> +		dev_err(vhost->dev, "Invalid fabric Login response: 0x%x\n", mad_status);
>> +		ibmvfc_link_down(vhost, IBMVFC_LINK_DEAD);
>> +		ibmvfc_free_event(evt);
>> +		LEAVE;
>> +		return;
>> +	}
>> +
>> +	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
>> +	wake_up(&vhost->work_wait_q);
>> +
>> +	LEAVE;
>> +}
>> +
>> +static void ibmvfc_fabric_login(struct ibmvfc_host *vhost)
>> +{
>> +	struct ibmvfc_fabric_login *mad;
>> +	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
>> +	int level = IBMVFC_DEFAULT_LOG_LEVEL;
>> +
>> +	if (!evt) {
>
> I think we need to hard reset here or we are dead in the water if there are no
> events.

I will add a hard reset here.

>> +		ibmvfc_log(vhost, level, "Fabric Login failed: no available events\n");
>> +		return;
>> +	}
>> +
>> +	ibmvfc_init_event(evt, ibmvfc_fabric_login_done, IBMVFC_MAD_FORMAT);
>> +	mad = &evt->iu.fabric_login;
>> +	memset(mad, 0, sizeof(*mad));
>> +	if (vhost->scsi_scrqs.protocol == IBMVFC_PROTO_SCSI)
>> +		mad->common.opcode = cpu_to_be32(IBMVFC_FABRIC_LOGIN);
>> +	else if (vhost->scsi_scrqs.protocol == IBMVFC_PROTO_NVME)
>> +		mad->common.opcode = cpu_to_be32(IBMVFC_NVMF_FABRIC_LOGIN);
>
> The VIOS won't return NVMF support unless we advertise it. So, I think its best
> to omit any NVMF releveant changes that are spec'd as they aren't being applied
> in a proper workflow here anyways. If the driver advertised both SCSI and NVMF
> support the current code would never do a NVMF fabric login as it would never
> fall through here.

Okay, I'll removed the NVMF changes.

>> +	else {
>> +		ibmvfc_log(vhost, level, "Fabric Login failed: unknown protocol\n");
>> +		return;
>> +	}
>> +	mad->common.version = cpu_to_be32(1);
>> +	mad->common.length = cpu_to_be16(sizeof(*mad));
>> +
>> +	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT_WAIT);
>> +
>> +	if (ibmvfc_send_event(evt, vhost, default_timeout))
>> +		ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
>> +}
>> +
>>  static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
>>  {
>>  	struct ibmvfc_host *vhost = evt->vhost;
>> @@ -5251,8 +5334,12 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
>>  		return;
>>  	}
>>  
>> -	ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
>> -	wake_up(&vhost->work_wait_q);
>> +	if (ibmvfc_check_caps(vhost, (IBMVFC_SUPPORT_SCSI | IBMVFC_SUPPORT_NVMEOF))) {
>> +		ibmvfc_fabric_login(vhost);
>
> Again drop the NVMEOF code.

Okay.

>> +	} else {
>> +		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
>> +		wake_up(&vhost->work_wait_q);
>> +	}
>>  }
>>  
>>  static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
>> @@ -5443,9 +5530,12 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
>>  	vhost->host->can_queue = be32_to_cpu(rsp->max_cmds) - IBMVFC_NUM_INTERNAL_REQ;
>>  	vhost->host->max_sectors = npiv_max_sectors;
>>  
>> -	if (ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPORT_CHANNELS) && vhost->do_enquiry) {
>> -		ibmvfc_channel_enquiry(vhost);
>> -	} else {
>> +	if (ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPORT_CHANNELS)) {
>> +		if (vhost->do_enquiry)
>> +			ibmvfc_channel_enquiry(vhost);
>
> I'm not sure I understand expanding this code to a second if block as there is
> no functional change.

Agreed.

>> +	} else if (ibmvfc_check_caps(vhost, (IBMVFC_SUPPORT_SCSI | IBMVFC_SUPPORT_NVMEOF)))
>
> Again drop NVMEOF and NVMF related changes.

Yes.

>> +		ibmvfc_fabric_login(vhost);
>> +	else {
>>  		vhost->do_enquiry = 0;
>>  		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_QUERY);
>>  		wake_up(&vhost->work_wait_q);
>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
>> index cd0917f70c6d..4f680c5d9558 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
>> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h
>> @@ -138,6 +138,8 @@ enum ibmvfc_mad_types {
>>  	IBMVFC_CHANNEL_ENQUIRY	= 0x1000,
>>  	IBMVFC_CHANNEL_SETUP	= 0x2000,
>>  	IBMVFC_CONNECTION_INFO	= 0x4000,
>> +	IBMVFC_FABRIC_LOGIN	= 0x8000,
>> +	IBMVFC_NVMF_FABRIC_LOGIN	= 0x8001,
>>  };
>>  
>>  struct ibmvfc_mad_common {
>> @@ -227,6 +229,8 @@ struct ibmvfc_npiv_login_resp {
>>  #define IBMVFC_MAD_VERSION_CAP		0x20
>>  #define IBMVFC_HANDLE_VF_WWPN		0x40
>>  #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
>> +#define IBMVFC_SUPPORT_NVMEOF		0x100
>> +#define IBMVFC_SUPPORT_SCSI		0x200
>>  #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
>>  	__be32 max_cmds;
>>  	__be32 scsi_id_sz;
>> @@ -590,6 +594,19 @@ struct ibmvfc_connection_info {
>>  	__be64 reserved[16];
>>  } __packed __aligned(8);
>>  
>> +struct ibmvfc_fabric_login {
>> +	struct ibmvfc_mad_common common;
>> +	__be64 flags;
>> +#define IBMVFC_STRIP_MERGE	0x1
>> +#define IBMVFC_LINK_COMMANDS	0x2
>> +	__be64 capabilities;
>> +	__be64 nport_id;
>> +	__be16 status;
>> +	__be16 error;
>> +	__be32 pad;
>> +	__be64 reserved[16];
>> +} __packed __aligned(8);
>> +
>>  struct ibmvfc_trace_start_entry {
>>  	u32 xfer_len;
>>  } __packed;
>> @@ -709,6 +726,7 @@ union ibmvfc_iu {
>>  	struct ibmvfc_channel_enquiry channel_enquiry;
>>  	struct ibmvfc_channel_setup_mad channel_setup;
>>  	struct ibmvfc_connection_info connection_info;
>> +	struct ibmvfc_fabric_login fabric_login;
>>  } __packed __aligned(8);
>>  
>>  enum ibmvfc_target_action {
>> @@ -921,6 +939,8 @@ struct ibmvfc_host {
>>  	struct work_struct rport_add_work_q;
>>  	wait_queue_head_t init_wait_q;
>>  	wait_queue_head_t work_wait_q;
>> +	__be64 fabric_capabilities;
>> +	unsigned int login_cap_index;
>
> Lets drop these as they serve no purpose for Linux. If the spec changes to
> introduce capabilites releveant to Linux we can add it then.

Okay. You discussed fabric_capabilities. I think login_cap_index isn't
useful until patch 4 or 5, so I'll drop it from patch 4.

-Dave


