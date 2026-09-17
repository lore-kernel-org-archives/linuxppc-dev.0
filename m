Return-Path: <linuxppc-dev+bounces-27538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF2DC982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 03:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlhQj3YyRz2xyk;
	Thu, 17 Sep 2026 13:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789616541;
	cv=none; b=GReTFMC8kV/ykXslNZny5k5Rbyj3fWfley5DlEbJiZtzZ6cgtTIz/6G4BjWPh0sV7rNglLmGNW321IqUIjIo5Hjqh4lDNQcOARp938ypuMFSRiivnn+gFAYCe+uVbtch/q7w5BHDEKA7O+PjcSUU092zqwa6+J1POn6fp3wjT11tn0bGQ8pIJWv7yNocbpPwWiJG96mxwGmiX50SfCXx/lGxSIKKBzDCKxVQI6YXcYFqqWEDeaERM23KhLWxxctthfGLZvti4IUytNwA2vZph4vHkdSda1mroXxrL56lJ7nIrmUvjDhiDQsltDfyKLOL8sPW56PDXewg2/UwSLxVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789616541; c=relaxed/relaxed;
	bh=XHJn5Hj44pX2LVH/PfCoMqBuf+6rA3DHvF+Bk+by6jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQqkxrdce3L9tf1zEkuJs9+CVkYaVfqu8TkO2w/l1vxOKNCpBY1LuelLVx1sDBjI1P5uV8uFS5ZkOP6OkeWqg8pDvtaOb/O8DNQ0UuHUiUjEa3vxNGvCJGym2UW/+jmlhU0yl0a38vX8go/gh9iYEa6cGKMfE5mpEFjMm+GCzcTTMC2UdhQRlkX9SmmbLFDTp039xcDMwrwoXeDc0yLQ+cTekET9JSX7l+rUnB3HVrn85/CZEmIKjHoAjPQPrUepzDCKGfXs+PztZOUAfZ4qcDJjJuD9EXNTvA6gSa37JoQWLaA+XiMQa41vTt7GscAP/dgjmlCD6jeek2VrrHbGVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UOzNTwog; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UOzNTwog;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlhQh2cj3z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 13:42:19 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1k4Q2330475;
	Thu, 17 Sep 2026 03:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XHJn5H
	j44pX2LVH/PfCoMqBuf+6rA3DHvF+Bk+by6jg=; b=UOzNTwogHJbAa9nLOnoyet
	xI/PNCqRayh1k7bmYx6ZuXskFLuLEQqVDtrDWPd7kjHc5vca9vmWCm03yyckCiAw
	LRTKPxdO3/96iQlyp6GbLu9gXDRDleDWRKiDtK9EKYuSoZPBSOD7oEQenNyiK5j/
	XW71vuZOJJvgvZe0xQzF8vQaY1wFAfxl3qCk4I/psRVtaKB8URlYzIUEAnfAtgHn
	6Av8OZbKUSbSIG6yOtxORA1askf4T0cOiEM0sjMAbJfdhT4G8wfD9JncX50+5ls2
	7Na41l/W4iBlXeOXyDuZKbZQEwUIUwax/GDvVXJBW4guvVNRWeYgy7OT6YJ8o/OQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqg5w4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 03:42:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN0B281625401;
	Thu, 17 Sep 2026 03:42:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxshp3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 03:42:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H3g7pu983990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 03:42:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B2DB58055;
	Thu, 17 Sep 2026 03:42:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68D135804B;
	Thu, 17 Sep 2026 03:42:06 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com (unknown [9.61.186.148])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 03:42:06 +0000 (GMT)
Message-ID: <b849b1fd2bb392262a078272acd587fa29a028e9.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/pseries/dlpar: Remove DT entries if failure
 from CPU ADD notifier
From: Haren Myneni <haren@linux.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        saravanak@kernel.org, ritesh.list@gmail.com, tyreld@linux.ibm.com
Date: Wed, 16 Sep 2026 20:42:05 -0700
In-Reply-To: <20260916213308.GF1926857-robh@kernel.org>
References: <20260916043249.2062676-1-haren@linux.ibm.com>
	 <20260916043249.2062676-2-haren@linux.ibm.com>
	 <20260916213308.GF1926857-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA0MiBTYWx0ZWRfX+dFKtNthDms/
 6tKibdwQuqA35EsALyjfgRA+clsaGzTmeJiZX32t+GGrLU3N4lOR+NmlLvYlEWl16LCtI6SHCl8
 5ckMNWbAmc/COIqRA+46uxJuQA5Hb7BpL8C+3rmu5u+pQknKp23Pve7S7XCrf/br7UA82v8PgEi
 T8WLCv7/SMhB2tuxfzNJT6PGdrflBbBLkRuLT8NrGzGwRNaPNyNfre+qTpAeO3QmrrpwqclmwZw
 0OcqfDhGewUJNr/ZcrCyIb/8vgOgYIgVTEhIKQn8TeV/M9d5/C3irgDD9jr9Kc3IDwz9J79l784
 a016H6LzC1Arg1KsTROHeQl8EWzI65p1idwjvaF1f74QaEmamdV5t8Dtp6Xr/Ypbf3qATbSPaFh
 k82OtplP7lXgi5xUH9ph4OZEVNC8DT9cbVv396HZ7Abbnek/leR6dh0j/x5LgY3prShj9qsjZ1T
 P95uA7UFcCqhpJd97UQ==
X-Proofpoint-GUID: VOoJpfpNUv_EDeynobyz7hyzBc4kx7Pk
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab6192 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=kYwNRr7Y1IwBvulbC20A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vRDfy9qZRHOIPXkTtgRMF8oPi5sD6Fel
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA0MiBTYWx0ZWRfX/1id7Q+fKlu1
 Lra6R9EfWnR/YpcggSH+bQvw+rfT4xufhx/QclWVcQ/Uwl3kc+qBaaty0bzeuajfel6ed1Ttmlq
 tbK35GRmcmZuznpIC3d3zlfLP4L46BY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170042

On Wed, 2026-09-16 at 16:33 -0500, Rob Herring wrote:
> On Tue, Sep 15, 2026 at 09:32:49PM -0700, Haren Myneni wrote:
> > For CPU ADD, the device tree entries are retrieved with
> > configure-connector RTAS call and attached to the device tree.
> > Then the CPU is added as part of DT node notification. If the CPU
> > ADD notifier returns failure, the corresponding CPU node entries
> > should be deleted from the device-tree. See pseries_add_processor()
> > for the possible failure cases.
> >=20
> > The current code does not remove CPU node entries during CPU ADD
> > notifier failure and causing the following issues:
> > - Can not add this CPU later since already present in the
> > =C2=A0 device-tree.
> > - Trying to free memory allocated to CPU node without detaching
> > =C2=A0 the node and it causes freeing its sibling node (existing CPU
> > =C2=A0 nodes).
> >=20
> > This patch fixes this issue by calling of_detach_node_no_notify()
> > for the failure from CPU ADD notifier which removes CPU node
> > entries without calling CPU REMOVE notifier.
>=20
> Would using the of_changeset_ API directly solve your issue? It's
> better=20
> designed for handling reverting a changeset. The of_attach_node/=20
> of_detach_node() APIs have limited users and I'd really like to
> remove=20
> them. Or make them PPC specific perhaps. Looks like there is 1 non-
> PPC=20
> user that snuck in.

Thanks for your comments.

of_changeset_apply(): After adding all entries, calls notifiers for
each node and continue even after one notifier  failure and returns
failure. The caller does not know whether the failure is from attach
node or notifier and from which node. So
__of_changeset_revert_entries() can be used to revert entries if
stopped on the first failure.

of_changeset_revert(): always calls notifier for each node. I can use
__of_changeset_revert_entries() since CPU add has just one notifier but
not a standard interface.

pseries_cpuhp_attach_nodes():

if (!of_node_check_flag(np, OF_DETACHED))
	__of_changeset_revert_entries(&cs, *ret);

The current code calls dlpar_detach_node() if online CPU failed after
success from of_changeset_apply(). Hence added
of_detach_node_no_notify(). PPC code calls of_changeset_apply() for
multiple nodes and of_attach_node/of_detach_node for single node.=20

 Or defining some other node flag OF_NOTIFIED to call the notifier for
revert / detach in of_changeset_*.=20
=20
Please let me know if you prefer to change of_changeset_*() instead of
of_detach_node_no_notify(0.

- Haren

>=20
>=20
> Rob

