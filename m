Return-Path: <linuxppc-dev+bounces-19426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E38BEDB7CC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 09:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqgFh3vN2z2yhD;
	Tue, 07 Apr 2026 19:02:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775552568;
	cv=none; b=OBT3AbIIYLTaf7chm9eQ85Tx1vUDR03xIhaEpzwIRdw7dch0d1KvaYg02lFKJ1AIxYQkl6d6teyp9Xf4XTGB+7VTK7q7soDI+ELUzLO3Q2akak2DphKEJMFlrDtLQUZsJTaShxqmPQOuUWkgB01S5hi58anrI9YYgHJK+Jbgscn+3VcI1x+MZID7BiplC35ls7omL+2XqoG8ojR3ZO2MoGD+dj4UwXl4GFQWZRYigyPMZ/vHbXoViIy+nG9kpksu76c3ton2Sj8tdTlJfGxiv5olahi2jWcHxzzdz8NIrmr0aeeeLtmoBXJqtKbqN6MHVnyJhFh2MWqn4UutjCwbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775552568; c=relaxed/relaxed;
	bh=jsFU1jxbFZU+fd2M8Cj7vaFvJ59JgzowXJbwIGML3B0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mw1QTzD639tXY+Oi+vTNek94+jgEXaHZ1JKrY5UcyGl0GuQFizRc6VRT/Ztd3DlJniUBpoP2SCJSJrFrBCKYnDKiXa9/XFbjMd1NNysJkVAWMhy9w8SfuU5tTpmi1dCsigbSLmEzFvKmtjgm8Y/7eEd6kGgw53JheuQ/4srtZHCndT/aBl4bC3INPIFMVDmNzEZIlZE55vGe329/GPefTET0D3TQ15bR01cGIhZsUcFXzaOLR6gIzMfSVC7dhGvoLUJ+6bcvHln60I/YJyk5JCcI1fsxsmi9LHw6xFnaHwpGun30WwpuMWRUXlcCalEUVd8FbSC4zeyah3ab/Nw18A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W4elOEDK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W4elOEDK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqgFf6yJWz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 19:02:46 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmgC92212446;
	Tue, 7 Apr 2026 09:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jsFU1j
	xbFZU+fd2M8Cj7vaFvJ59JgzowXJbwIGML3B0=; b=W4elOEDKHhY59M0j+ZmLH5
	+q9nHz+MePPBuA83dI8BPxM2IA9tqLGykcydxd2KXnmIa9Bg8VRKPvHZTixUxwwY
	dqjJZsm2dNjkwMOzSHFVsxPqOP7up0BXQTIedQMTEWEn/p/UumkmlnjlBx8zDyL0
	9Hn9EjM2I+uA15INOOZvcyJI9HfRmDL81LPz9cQklNXqjka71JGnLB77bXjSemVC
	KL397XOS5amMR9BY9CbER/OOgk6I1gIjxLShQFxjW9SlIusM36T5Gtc8b1BHyDsF
	e9QxVgbTltuChk+MtJXVXZinomVlwtfsNOo8z8EA6/yo3elPl4vH3JUQTaAIIPgw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2h9v6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 09:02:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373ThGV026707;
	Tue, 7 Apr 2026 09:02:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7srjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 09:02:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63792ZHQ4785058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 09:02:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDC058052;
	Tue,  7 Apr 2026 09:02:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B5958065;
	Tue,  7 Apr 2026 09:02:33 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.3.173])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 09:02:33 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4] char/nvram: Remove redundant nvram_mutex
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <6c00b695-9e84-4dd8-abbb-306fd67d6f97@linux.ibm.com>
Date: Tue, 7 Apr 2026 14:32:20 +0530
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ritesh.list@gmail.com, arnd@arndb.de,
        Christophe Leroy <chleroy@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E92E66BE-165B-4289-99B1-3F4E6B84CAAD@linux.ibm.com>
References: <20260330103530.6873-1-venkat88@linux.ibm.com>
 <68e9ca6a-c53b-4f15-85b3-7ae9639f9528@linux.ibm.com>
 <6c00b695-9e84-4dd8-abbb-306fd67d6f97@linux.ibm.com>
To: arnd@arndb.de, Madhavan Srinivasan <maddy@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4MCBTYWx0ZWRfX9JDAu754Hi15
 Jkyc9bycHOk+8Gm25FOVXfSP06prHArOivC2M84O9TnSjSm0AXEuTJ8RT3OJGytyiU1YsYlKZU6
 1xXu+U+XNCBCDxPCwVdO6sXMJaQ0jXVJwPpzUA0WLXtSBkTYTVc2LpttWQ+KQDjHYSlUQE7Q1nw
 h8YEHblS1W/GRGifcKig1D0anBFCaDRD0hAniQZMbcQy3F3HiHyIJKu+gJYpl01ICl/Q1iVpDK4
 3HolRev8EUDCPOwpq0+eMaA7soLNgUv/X+YLRkrcCKqeDpW/+a+JD78ox++NoLCsY10zxK9OoYl
 83fgLwUZQDDSmaAT7sXAgjvuD5TD+Q5Is6kmetOoI4r9tMQfo6+mYOTDxrE4zmFYoz3PRW8HGMV
 BpXGU9n9X+2OoK6o3s1R0ZXWdJ4fq8zhIirC1rO7q9FnGMg3QZVMEqdLcqjuDniNxYpBdEQM3go
 2qGGI+xPqokNv8wLVKg==
X-Proofpoint-GUID: H7tlVhrNy3pAcqMpooGDy65jTmwiQRXO
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4c82e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zM85nl73RZM319hoLRgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VLQhvai_jLeenBtZNNi8kTSSS5uUnVQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070080



> On 7 Apr 2026, at 12:11=E2=80=AFPM, Tellakula Yeswanth Krishna =
<yeswanth@linux.ibm.com> wrote:
>=20
> Please add this tag
>=20
>=20
> Tested-by: yeswanth <yeswanth@linux.ibm.com>
>=20
> On 02/04/26 9:33 pm, Tellakula Yeswanth Krishna wrote:
>>=20
>> On 30/03/26 4:05 pm, Venkat Rao Bagalkote wrote:
>>> The global nvram_mutex in drivers/char/nvram.c is redundant and =
unused,
>>> and this triggers compiler warnings on some configurations.
>>>=20
>>> All platform-specific nvram operations already provide their own =
internal
>>> synchronization, meaning the wrapper-level mutex does not provide =
any
>>> additional safety.
>>>=20
>>> Remove the nvram_mutex definition along with all remaining =
lock/unlock
>>> users across PPC32, x86, and m68k code paths, and rely entirely on =
the
>>> per-architecture nvram implementations for locking.
>>>=20
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> ---

Hi Arnd,

Thanks for the earlier review and suggestion on this change.

I=E2=80=99m not entirely sure which tree would be the best home for this =
patch,=20
given that the change touches common NVRAM code used across multiple =
architectures (PPC32, x86, and m68k).=20

If there are no further comments or objections from others, would you be =
able to pick this up through your tree?

Please let me know if this should instead go via some other tree or =
maintainer.

Regards,
Venkat.
>> Without Fix
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> make -j 33 -s && make modules_install && make install
>> In file included from ./include/linux/seqlock.h:20,
>>                 from ./include/linux/mmzone.h:17,
>>                 from ./include/linux/gfp.h:7,
>>                 from ./include/linux/umh.h:4,
>>                 from ./include/linux/kmod.h:9,
>>                 from ./include/linux/module.h:18,
>>                 from drivers/char/nvram.c:34:
>> drivers/char/nvram.c:56:21: warning: 'nvram_mutex' defined but not =
used [-Wunused-variable]
>>   56 | static DEFINE_MUTEX(nvram_mutex);
>>      |                     ^~~~~~~~~~~
>> ./include/linux/mutex.h:87:22: note: in definition of macro =
'DEFINE_MUTEX'
>>   87 |         struct mutex mutexname =3D =
__MUTEX_INITIALIZER(mutexname)
>>      |                      ^~~~~~~~~
>>=20
>>=20
>>=20
>>=20
>> With this patch issue is fixed
>>=20
>>=20
>> Please add below tag
>>=20
>> yeswanth <yeswanth@linux.ibm.com>
>>=20
>>=20
>> Thanks,
>>=20
>> Yeswanth Krishna
>>=20
>>> v4:
>>>   - Remove all remaining nvram_mutex call sites, completing the =
mutex removal
>>>=20
>>> v3:
>>>   - Removed global nvram_mutex definition
>>>=20
>>>  drivers/char/nvram.c | 16 +++-------------
>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
>>> index 9eff426a9286..e89cc1f1c89e 100644
>>> --- a/drivers/char/nvram.c
>>> +++ b/drivers/char/nvram.c
>>> @@ -53,7 +53,6 @@
>>>  #include <asm/nvram.h>
>>>  #endif
>>>  -static DEFINE_MUTEX(nvram_mutex);
>>>  static DEFINE_SPINLOCK(nvram_state_lock);
>>>  static int nvram_open_cnt;    /* #times opened */
>>>  static int nvram_open_mode;    /* special open modes */
>>> @@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
>>>          break;
>>>  #ifdef CONFIG_PPC32
>>>      case IOC_NVRAM_SYNC:
>>> -        if (ppc_md.nvram_sync !=3D NULL) {
>>> -            mutex_lock(&nvram_mutex);
>>> +        if (ppc_md.nvram_sync)
>>>              ppc_md.nvram_sync();
>>> -            mutex_unlock(&nvram_mutex);
>>> -        }
>>>          ret =3D 0;
>>>          break;
>>>  #endif
>>> @@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
>>>          if (!capable(CAP_SYS_ADMIN))
>>>              return -EACCES;
>>>  -        if (arch_nvram_ops.initialize !=3D NULL) {
>>> -            mutex_lock(&nvram_mutex);
>>> +        if (arch_nvram_ops.initialize)
>>>              ret =3D arch_nvram_ops.initialize();
>>> -            mutex_unlock(&nvram_mutex);
>>> -        }
>>>          break;
>>>      case NVRAM_SETCKS:
>>>          /* just set checksum, contents unchanged (maybe useful =
after
>>> @@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
>>>          if (!capable(CAP_SYS_ADMIN))
>>>              return -EACCES;
>>>  -        if (arch_nvram_ops.set_checksum !=3D NULL) {
>>> -            mutex_lock(&nvram_mutex);
>>> +        if (arch_nvram_ops.set_checksum)
>>>              ret =3D arch_nvram_ops.set_checksum();
>>> -            mutex_unlock(&nvram_mutex);
>>> -        }
>>>          break;
>>>  #endif /* CONFIG_X86 || CONFIG_M68K */
>>>      }


