Return-Path: <linuxppc-dev+bounces-23592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A5EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:29:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtyG7346kz3bpx;
	Mon, 06 Jul 2026 18:29:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783326591;
	cv=none; b=lfVenOCW8cqDrif4OW+ImwnEwkuxORZPLqY7LpDlQ65QGKVPA4YIC9fpGnumoyVsVFrM3UbEEh/06MCRrDAPXaahJaU5RBz+L2ZXX16O+soapqG8+baczK/RA2CS5niGfh/+Dy68bfBpNdg5CUaIs7ca4UXFBoywPYa8ejr1/h2bfMJBGg6QcIc+akd7pcShKt0FMX8rQZ793kmt+4Qp8KgCzvPEJUsJanAuV5byRMicr20FizkgvqwY506Ffbrw2wx3/woskkK901wUPaJ+fhcrgIIr45Sx5/G/1fI1L3v4eeTN4Nra+V00f5TEiKmS3HiprptC7SclvBIUj+46NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783326591; c=relaxed/relaxed;
	bh=ZmDot0cKwa4uXNqmgKe29o/ZI4dn5aWBu5lkDCK+JWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK5zDO/+cLUC8TWS3VAHzgpB4vgpNei3mLSRs1Fa/fJ9/p9qqE7r8BJ042OmsVnpFANAZOOCsXlyy3raNN8WugOl0IB3FjRc5NwAMj0llFaEErpYAf0PaXguekHpjTjdQI8tdI3KoqbvFbsA5Qw3Dk08YDo/GIWfkMsqz+4dG/CA6NOupwp2RoebsU8gUz5lc9gbDHJBGMuhyzvBFCBuHRlX2a0bPfDuyrBwf5iZRLjI6VdOQRmFaiYyp0gzx3r0nAh4vE/LRZukHxayquByofJVGBxeDoJpTtRAST4ENeR+cIylIlf7DH8qT9eE0eu7xh4PP9N4XMZRuknGAgG+Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cmQmgvwJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cmQmgvwJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtyG54K1dz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 18:29:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJ9SX2252059;
	Mon, 6 Jul 2026 08:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZmDot0
	cKwa4uXNqmgKe29o/ZI4dn5aWBu5lkDCK+JWs=; b=cmQmgvwJQL4sV02y8lRlbt
	jN5dQycU7aNNteVL+tUIgwgQdXbArasb2yy//UMvDg43qTqYT5gt+3NAY/KU5uHb
	usgv86vCt3YXqHmXRH2ua0QHWDiXGeY5MxbAbNgC0eXcjCaIILsMpu6fPLwksBc9
	8nz7erjfqXrXGarXcam8wzAeXPkHcOvsteB+wOsB5WicOh1yT42XipfGwxDOr1CW
	Tg8KI7bxDBmLDNbYRU4Hs1jAHgFyjmnIOh+MnWX4gRnWJcUBEP5PxmhBrZ4yWiNT
	hktut6pxognSZd2kT1UW9lL3sQrL0ogZ2kpO3+ZWWWWYGy7YjRRavllKf/N1BKhw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8k96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:29:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JdQg016678;
	Mon, 6 Jul 2026 08:29:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvdnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:29:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668SqON42205682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:28:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014AA58055;
	Mon,  6 Jul 2026 08:29:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 500E15804B;
	Mon,  6 Jul 2026 08:29:21 +0000 (GMT)
Received: from [9.61.244.93] (unknown [9.61.244.93])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:29:20 +0000 (GMT)
Message-ID: <8a568842-0a62-41d1-8e7b-cf2bcce6a71e@linux.ibm.com>
Date: Mon, 6 Jul 2026 13:59:19 +0530
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
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
Content-Language: en-GB
To: Ricardo Robaina <rrobaina@redhat.com>, Paul Moore <paul@paul-moore.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
 <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
 <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
 <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
 <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org>
 <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
 <CAHC9VhQvoK4uYP0NBnd4FGbXCQkDka4nHqdz9kAn2bGnm4qVHQ@mail.gmail.com>
 <CAABTaaCQCBuR9Ny6zBHNK=gy3Cd0WGj-f9qgzwuyjWD_i=v_dQ@mail.gmail.com>
 <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <CAABTaaC_vQTM8B0wLqfHuv-S9JDzXeuDeLd0Sh3M21pO+=Zg2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b6769 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=eNcD7ojaAAAA:8
 a=wyjpycHzAAAA:8 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8
 a=PlrRbfSCXYS7fjFACv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rRYMMicksRHQPzyJ67jW:22 a=ROKTiUA5NBresHysc1Cf:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: 0H5iLqL_28n9RdSSg5OChJFY7Mb9h3-j
X-Proofpoint-ORIG-GUID: vNFlc0bO4n0CClGQq5cHj5xQSK-ekaYM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX9VBi9dAymKth
 zaCa/nxklqL65hvt2qYqBYqK2UutXOUyD2PzeUccLM0W74Y7e2NlHxY+h3PVf7GM0mVHLJGHoxu
 o1nzID5bEyNekeexZ3+J8TkkiHsykY8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX9anzZgysbZNB
 Wua/YK+RTpZBma8eB9bxE8IjOkQ/AW2Q6SMyZxMmrPFGum2nPOHR9Sawq1VVCjRCgpdmdSY0Wy3
 jmCYVhxtPRLF9lADSyaTRzg58T4MvZF8R1iRBj+unkFC97tSh+LYbaGDcbC+Kz4JXzoPi5js+Bj
 rgK06Ua0jQ3UaHJJcmx57rBHXensvpJ8wLLLZTmEtHGfEfzjRVAQuWzTkI8ChU6EFXfuapDzjXL
 QiQV0svaajQ6Cp+HCOuyprmn35LkaCKyxiot4TSoam7MvBW0fOrUtFhN+XSGS4nDtgYZsMU0VFK
 riBtZDHomgrn/F3ki/QwdYE5MLl0ry2RfhdhfDENwbiu43RFCWHpGRon1t+tMNXfJrf03rZI5dx
 LNy1zKhoD4CTAmkAaT946uc9/yRmGeKVJS11eS72OZm4QW7EeoXnT31qcIs/eOBal7AkCNnVwrZ
 NPi6x+aQV3k/RtW+Fvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083


On 03/07/26 4:19 am, Ricardo Robaina wrote:
> On Thu, Jul 2, 2026 at 3:19 PM Ricardo Robaina <rrobaina@redhat.com> wrote:
>> On Thu, Jul 2, 2026 at 10:28 AM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Jul 2, 2026 at 8:50 AM Venkat Rao Bagalkote
>>> <venkat88@linux.ibm.com> wrote:
>>>> Current remaining issue:
>>>>
>>>> 1. amcast_joinpart
>>>> ------------------
>>>> Still fails due to a missing Perl dependency:
>>>>
>>>>       Can't locate Socket/Netlink.pm in @INC
>>>>
>>>> I searched the configured repositories and could not find a package
>>>> providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le system.
>>>>
>>>> Latest run summary:
>>>>
>>>> amcast_joinpart/test ................. Can't locate Socket/Netlink.pm in
>>>> @INC (you may need to install the Socket::Netlink module) (@INC entries
>>>> checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40
>>>> /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
>>>> /usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
>>>> BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
>>>> amcast_joinpart/test ................. Dubious, test returned 2 (wstat
>>>> 512, 0x200)
>>>> Failed 7/7 subtests
>>>> backlog_wait_time_actual_reset/test .. ok
>>>> bpf/test ............................. ok
>>>> exec_execve/test ..................... ok
>>>> exec_name/test ....................... ok
>>>> fanotify/test ........................ ok
>>>> field_compare/test ................... ok
>>>> file_create/test ..................... ok
>>>> file_delete/test ..................... ok
>>>> file_permission/test ................. ok
>>>> file_rename/test ..................... ok
>>>> filter_exclude/test .................. ok
>>>> filter_exit/test ..................... ok
>>>> filter_saddr_fam/test ................ ok
>>>> filter_sessionid/test ................ ok
>>>> io_uring/test ........................ ok
>>>> login_tty/test ....................... ok
>>>> lost_reset/test ...................... ok
>>>> netfilter_pkt/test ................... ok
>>>> signal/test .......................... ok
>>>> syscalls_file/test ................... ok
>>>> syscall_module/test .................. ok
>>>> time_change/test ..................... ok
>>>> user_msg/test ........................ ok
>>>>
>>>> All tests now pass except amcast_joinpart, which is blocked by the
>>>> missing Socket::Netlink Perl module.
>>>>
>>>> Please let me know if there is a recommended package source for
>>>> Socket::Netlink on EL10 ppc64le.
>>> Thanks for following up on this Venkat.
>>>
>>> I'm adding your colleague Ricardo from the RH side of the house.
>>> Ricardo is very familiar with audit and should be able to help you
>>> with missing RHEL packages.
>> Thanks for looping me in,  Paul!
>>
>> Venkat, unfortunately, perl-Socket-Netlink is not packaged for RHEL-10
>> ppc64le. An alternative is to use CPAN[1] to install the
>> Socket::Netlink Perl module.
>>
>>   # dnf install cpan
>>   # cpan App::cpanminus
>>   # cpanm Socket::Netlink
>>
>> I'll reserve a ppc64le machine and run the tests locally as well. I'll
>> share the results shortly.
>>
>> [1] https://www.cpan.org/modules/INSTALL.html
>>
Thanks for the RPM's Ricardo.

I installed the missing dependencies (netcat, iptables, ip6tables) and 
rebuilt the kernel with arp_tables available as a module. I also 
installed Socket::Netlink using:

     cpanm --mirror https://cpan.metacpan.org --mirror-only Socket::Netlink

After these changes, I reran audit-testsuite and all tests are now passing:

     Files=24, Tests=279

     Result: PASS


amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
time_change/test ..................... ok
user_msg/test ........................ ok


Paul/Christophe/Maddy,

Hope we are good now. Please let me know, if anything else needs to be done.


Regards,

Venkat.

>>> --
>>> paul-moore.com
>>>
> Hello everyone,
>
> I built an RHEL-10 kernel with the patch applied and verified that
> audit-testsuite passes successfully on a ppc64le machine. Please find
> the logs below:
>
> Tested-by: Ricardo Robaina <rrobaina@redhat.com>
>
> ---
> # uname -m
> ppc64le
>
> # uname -r
> 6.12.0-245.test.el10.ppc64le
>
> # make test
> ...
> chmod +x */test
> Running as   user    root
>          with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>          on   system  RHEL10
>
> amcast_joinpart/test ................. ok
> backlog_wait_time_actual_reset/test .. ok
> bpf/test ............................. ok
> coredump/test ........................ ok
> exec_execve/test ..................... ok
> exec_name/test ....................... ok
> fanotify/test ........................ ok
> field_compare/test ................... ok
> file_create/test ..................... ok
> file_delete/test ..................... ok
> file_permission/test ................. ok
> file_rename/test ..................... ok
> filter_device/test ................... ok
> filter_exclude/test .................. ok
> filter_exit/test ..................... ok
> filter_inode/test .................... ok
> filter_saddr_fam/test ................ ok
> filter_sessionid/test ................ ok
> io_uring/test ........................ ok
> login_tty/test ....................... ok
> lost_reset/test ...................... ok
> netfilter_pkt/test ................... ok
> signal/test .......................... ok
> syscalls_file/test ................... ok
> syscall_module/test .................. ok
> time_change/test ..................... ok
> user_msg/test ........................ ok
> All tests successful.
> Files=27, Tests=300, 252 wallclock secs ( 0.12 usr  0.01 sys + 54.34
> cusr  1.38 csys = 55.85 CPU)
> Result: PASS
> make[1]: Leaving directory '/root/rrobaina/audit-testsuite/tests'
> ---
>
> I hope it helps!
> -Ricardo
>
>

