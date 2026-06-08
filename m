Return-Path: <linuxppc-dev+bounces-22185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B65ECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 10:13:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYntY0Ttmz2yR5;
	Mon, 08 Jun 2026 20:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780913604;
	cv=none; b=Uvtz9PE3ofonAOfjGgOmoAsp04yhbFoFKOmDoF3TQMNepK0D19kkawVr5Bo8nJkEATQp5xn2Q1m3KXpuji0jW/CYq3IvPQFolNwxEOZuCR7/MEagwRKZp4VoFnL6WaP4cV9O41gltmXRjkKYW1aqZJb6VzjH67vpVbCkXq5UeelOh9L+VFdhc7OWSI5m3jWYdzxtey0nUHQpPxVTlwiFZAP6FFlNeb9ku+cmH+YmJDrjZj4VlJ3QaF/UzYQdtNbqC3lpMr9TICIjQLboz8AIj/mauPZI164MgXLgTlkLKSFUJkK3BinMo6lkkzwk4W3z48w2uuID73oYD2CBC+5NSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780913604; c=relaxed/relaxed;
	bh=P3ow97rFE6f2Ih3ZMtzn1DulWuogxaDRu6iHa6vmpoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeMZzpM4Oc6iUXf5hVeVHKELD7n6M8ambaIrJuJqppW5leht3PRtRf3BesJn2JUXS7qK7cTQ+dxlttDmXiiZN+22g3I0Zxr6ilM6m3tRzMOENkkLGMUOqFi31GGZNZSL2oGz/ZsTZI00PCsfe6SylOlSi+jTw8humTSLsdXeOX4ShiOxz7oche0EOSiRFAaR4e0iX74vTqy/bJHaVkcNgmQ9GlKBAVj8aMmYpn+sH8QuQruX0HFRRZnJbM6CS3tdekbCcgP/dufl6LQJ/QlfLixc2ECXxG4VFmh/BbdeKwelGv8jg4lVtSU5LA7eRhNGOixuYIInM3Lrp4e7wX7x9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hu8uT8Qn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hu8uT8Qn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYntW6lMLz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 20:13:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6582srvE1207171;
	Mon, 8 Jun 2026 10:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P3ow97rFE6f2Ih3ZMtzn1DulWuogxa
	DRu6iHa6vmpoo=; b=Hu8uT8QnTY5znXFiSbKOnxrrO6rn/PYMbSxE2OER493NVs
	F0dULt8pcXi2PBcGflq/ulOz3c+fU8RRWQFboHnkk4P5hELHVinbpJTRhmwCZeMY
	LJpwzX2u/QC6wbJX8OUnFcUwPmm1MT03KcabYGvdPVkOr6at3gnSKAxdQUTCTWrt
	ha31fKfM7Uo8ZdEOPAagD/Kur17rMOTsD39tsS/3HTlZv7QxLz9wz6BzgDJ20W4p
	+X1mMqReprk4n+3ePW518ra7zIOAniiZzxZ6SwbLFedwbMfDcsLYVR9lUhyTJpVK
	nQt3WShon2QXLyoUIqD/LyrOI+riT/SUQFpbDUjA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6spkv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:13:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658A4iYT012551;
	Mon, 8 Jun 2026 10:13:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjmtjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 10:13:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658AD7SD30212720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 10:13:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988A320043;
	Mon,  8 Jun 2026 10:13:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EEEB20040;
	Mon,  8 Jun 2026 10:13:05 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 10:13:05 +0000 (GMT)
Date: Mon, 8 Jun 2026 15:42:44 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <20260608144125.9694b0b9-e8-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, kvm@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
 <87ldctmosh.fsf@vajain21.in.ibm.com>
 <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PyEKVYJNTp1i19MThskL6WXJWiwFQbA-
X-Proofpoint-GUID: IdWJ4CXLTMgaewP-ms9n0O9mjdozBMWh
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2695b8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pCLllbXSNW6fl1ZUPXkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5NCBTYWx0ZWRfX/402WAUii+nj
 FZTP63Nb/YjSb0LkrFgwnctt8t7HGshqcQI6mRIzG9Kg8iFBb6lUv4qx2ZY08HcaAHxadi9d/3v
 J+JVI9KMsTANtAG+dwVX1pTJj3acZ1tBvZ/jZSI4bMb2nHe1+5VhH08Oh0BrSn6xG+Ur7y6Jwjp
 K8WHIWJvSHHRmN7C7q3CsUVH3p8ebzjg5WtpoE3pabusHEh8bfo0KJsb+3z6O2Epmje2DzAt19d
 6QEIlL6lTUiq01nlNFtW6+NdZHHJNqDe3TAIpLjMhplhcmdoc2xuqh83vi5mTrHo8pz2PJNrnNW
 lTEXmPFZ8yEAqsancoCtOdnnJ67Tw+5DEmVHXY8mhXPvwAb2+LLwoEp45X905qbmqd5wlAx3hY/
 EU320tlvcDtC3BxcI+51JgkSkMu0xefupMrCKbvt6rL+703qls3xd1rt9ioAP2sYezyhMfPkJzH
 dvyaC5X1MwJZ9DPZF7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080094

Hi Gautam,

Thanks for testing this patch.

On 2026/06/08 02:11 PM, Gautam Menghani wrote:
> On Fri, Jun 05, 2026 at 12:55:50PM +0530, Vaibhav Jain wrote:
> > Hi Gautam,
> > 
> > Thanks for testing this patch. Few questions:
> > Gautam Menghani <gautam@linux.ibm.com> writes:
> > 
> > > On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
> > >> On IBM POWER systems, newer processor generations can operate in
> > >> compatibility modes corresponding to earlier generations. This becomes
> > >> relevant for nested virtualization, where nested KVM guests may need to
> > >> run with a specific processor compatibility level.
> > >> 
> > <snip>
> > >
> > > I booted a KVM guest on LPAR with this patch in the following scenarios:
> > <snip>
> > 
> > > 3. P11 guest on P11 host booted in P10 compat mode: No error observed
> > This should have resulted in an error since booting a P11 guest on P10
> > compat mode host is not allowed with/without this patch. Can you please
> > check your test env and share the boot results.

Yes, this should have errored out if the patch were tested in
combination with the QEMU patches posted here [1]. 

> 
> - lscpu output (host P11 LPAR booted in p10 compat mode)
> # lscpu
> Architecture:                ppc64le
>   Byte Order:                Little Endian
> CPU(s):                      960
>   On-line CPU(s) list:       0-959
> Model name:                  POWER10 (architected), altivec supported
>   Model:                     2.0 (pvr 0082 0200)
>   Thread(s) per core:        8
>   Core(s) per socket:        15
>   Socket(s):                 8
>   Physical sockets:          4
>   Physical chips:            2
>   Physical cores/chip:       16
> 
> 
> - lscpu output from guest
> # lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   4
>   On-line CPU(s) list:    0-3
> Model name:               Power11 (raw), altivec supported
>   Model:                  2.0 (pvr 0082 0200)
>   Thread(s) per core:     1
>   Core(s) per socket:     4
>   Socket(s):              1
> 
> 
> 
> - QEMU command line
> /usr/bin/qemu-system-ppc64 -device virtio-blk-pci,drive=drive0,id=virtblk0 \

So, this patch was indeed tested on a distro qemu binary.

But without the above mentioned QEMU patches, currently the '-EINVAL'
returned in this patch (or any other error returned for the compat
ioctl) is simply ignored by QEMU (which Patch#1 in the QEMU series is
trying to fix) and continues with arch_compat == 0, making the guest
continue with raw PVR support.

Now when we again land up in gs_msg_ops_vcpu_fill_info() in the guest
entry path, with the current logic and arch_compat being 0, we try to
set an appropriate value by looking at the cpu features, which in this
case, turns out to be the P10 LPVR. Subsequently, H_GUEST_SET_STATE is
called with this value of arch_compat and L0 never compalains about it
and guest continues to boot in P11 RAW mode while it shouldn't. The
guest booting in raw mode can be confirmed from the below information
from L2 guest:

  # lsprop /sys/firmware/devicetree/base/cpus/PowerPC\,POWER11@0/cpu-version 
  /sys/firmware/devicetree/base/cpus/PowerPC,POWER11@0/cpu-version
                   00820200 (8520192

Having said this, we should not only be relying on userspace/vmm to
handle this situation but detect this in KVM and error out as
appropriate. I'm currenlty working on the v2 of this patch for handling
this case and will post it after some more testing.


>     -drive file=/home/gautam/images/fc41.qcow2,format=qcow2,if=none,id=drive0 \
>     -m 100G -smp 4 -cpu host -nographic -machine pseries,ic-mode=xics -accel kvm

[1] https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/

Thanks,
Amit

> 
> 
> Thanks,
> Gautam

