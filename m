Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9D606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sRZ4rUJB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZVPN1thxz2xwP;
	Thu, 26 Nov 2026 06:39:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795635576;
	cv=none; b=NBqeq8iJBtVCutwz/6xNd/5TbcYtSO5KrD03FYsmneZ3qakJT73MY3xrrogU85SYf9cUq/NTHEMTbfIi7+D2kGhy7A+rMXf4zn+QJFfQdOd63syV1oljKV/om+cD1EGER1tFx0KAnKY6bUF6YBa+NSh6iyrStDBLlb3JAujLuxazGEOV61QRwCl+6jzB9Z9ltqrEnnEPy9DvaPEW++i0iCdsmfT8JUcepxVZiA9atytpA4nuq4nK6ui10WLi0sdwC1TygXQhtcmbnil6ICv8LIUy+R5umdHne+uM9zWBFacTEjIcLrBBTMoQXLHJqak0BQk9Y1XOjnK5twM+39uYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795635576; c=relaxed/relaxed;
	bh=3p6asDUa5lPHlXaVDZueUpMoU5hpnKaj2Ds/wZ3B/fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR+JvzCjFlRnBTGowBTMAqSeh9faCXIjMWCbUpFGVgY0VEG9HiIuvqsyagktYlYjJ6KR/c5VFZB6XCMcdVDNCKzxP4HyZ+vdi4VXyTHzL8w4afg+mUmmvpx0T03e5fHWcmNhwqIpAw9cx4DB9cmCHFqbvUl5fbT87ztMe4eMJR2M85akLKZ7GA/BUyyI/TRSUlJOrKK+O3i6jPNWfWOggAkuzdV0HAPyKCeOOXRFFVVIAbMAIgBaoBKs779k/ECfXqRB+4Hix+VLfpqy7DyhDWZi+jLSRa7hjQoO0TRuxyAgZbPox85qK3dnzW8SUDwwdHXTmfOjM0NGc8lLeAntaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sRZ4rUJB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sRZ4rUJB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZVPM0Swtz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 06:39:34 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJYjC32378103;
	Wed, 25 Nov 2026 19:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3p6asD
	Ua5lPHlXaVDZueUpMoU5hpnKaj2Ds/wZ3B/fI=; b=sRZ4rUJBJveucf6syXZOyj
	n7SGZzi8zarUClGETNGt9/Fy101Rzpz8PtcqSm5xf3sSIft9An5olyA9LEsJg3R3
	W2tYjvEzeTxPWgntFDwYt7QZ42DukYpvOCa7+NgpycdXnCz6Jp1SADEUa/6ifUaj
	SFz3pQVe5NnFaRESE5AA0FhqstjPEyNLnR8vxr/16OC2P8OMJqmHciTRm7FX1bmN
	V2VOdrd5s4pODTxLefOw+tOtON2ck6NYExg3g06FoPe+Pb8C8ZfeSb4v0SOcfwmE
	QpltuKuwcTZYrKmHkOryMrtuTze0Nch+YNBbqNgs/OiSGeBsc1N3SStIClWjfOAg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34faeb3d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 19:39:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJJKTt505588;
	Wed, 25 Nov 2026 19:39:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx24fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 19:39:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APJdOV640174044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 19:39:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D072004E;
	Wed, 25 Nov 2026 19:39:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17F62005A;
	Wed, 25 Nov 2026 19:39:20 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.67.112.155])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 19:39:20 +0000 (GMT)
Date: Thu, 26 Nov 2026 01:09:16 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, nandinih@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [BUG] selftests/powerpc/eeh: eeh-basic breaks the device hosting
 rootfs, ext4 goes read-only and the test harness crashes
Message-ID: <awc5ZMnS97T51Rpg@shivang.upadyay>
References: <9113e399-ddd0-405e-9abb-69a9785c726c@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9113e399-ddd0-405e-9abb-69a9785c726c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX+9714bEld4+1
 DppQ1XwqdwOT54t3z+zaQzmOKcda8LToadqDMeZERFSBH2h5oMJFijJrMT9tJEI4CLfU87gAYCb
 lkbkCbnvm/OSXIEjsqUXlbn9gf0juQosSOThPmIA2oyca1nvBzhdnTivBVf0660ZJwyDrY/wLLs
 pobBE13T7uzl6+3YkaHGQX2okB4iOU6JDfKhIa5FwRMllEbx4psfSU3XfBL4im1sTtdWO6lpgQF
 TqnCSwRGRe4vMqv8VJX/F/SXQJNL6NYu01/Jtp0eqxBHLhkl6oQYWCGABrmaixDfyMGWLgcHdlc
 mLiEF27QqOlho9VrnVgQvPsP1GFiiYvdnZcE30dkH7wXKhqSKeAGKxP+Ooymcuubqrar5wMMcP2
 GbSjGVn+Hj/In8Y3Rb86mTWW4t1Lqulr5jeFlKZW3ugNHEm9e5nYack5LBT7AAdD9AtZeTV38+l
 rSavVEkVyAZvOh+4nbQ==
X-Proofpoint-ORIG-GUID: Al7m6LqMcJUW5GR01b2KMsWjQYgX0GyG
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b073971 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6EctlgBVgvUV7dFz:21 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=YAcHw8vTPqq7ut5H_1wA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: Al7m6LqMcJUW5GR01b2KMsWjQYgX0GyG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX6c/FG7tr40j6
 Sxs2kFpJXHSTRALOJDgmXPLcwK2/hO/4S4Qsp1x9t8zZ9edSgw7FozQSskDvtD7CdWSjXwENNbM
 YrRKffGW95j7zZxXTTh+eO9WJ4wdwag=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250078
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:36:36AM +0530, Venkat Rao Bagalkote wrote:
> Hello!!!
> 
> IBM CI has hit a failure that takes down the test harness, While running the
> powerpc EEH selftest on a bare-metal POWER system.
> 
> The selftest injects an error into the PCI device that hosts the root
> filesystem. The filesystem goes read-only and the run dies.
> 
> [ 1112.079091] EEH: Frozen PHB#3-PE#1fd detected
> [ 1112.079905] aacraid 0003:01:00.0: aacraid: PCI error detected 2
> [ 1112.140830] I/O error, dev sdb, sector 3906906472 op 0x1:(WRITE) ...
> [ 1112.140957] Aborting journal on device sdb2-8.
> [ 1112.140977] EXT4-fs error (device sdb2) in ext4_dirty_inode:7656: IO
> failure
> [ 1112.176664] EXT4-fs error (device sdb2): ext4_journal_check_start:98: ...
> Detected aborted journal
> [ 1187.736385] aacraid 0003:01:00.0: aacraid: PCI error - slot reset
> [ 1217.244306] EXT4-fs (sdb2): Remounting filesystem read-only
> [ 1220.583495] aacraid 0003:01:00.0: aacraid: PCI error - resume
> 
> We need to make appropriate changes to selftest, so that it skips the
> adapter, if rootfs is hosted on it.
> 
> 
> SetUp:
> 
> System: IBM 9006-22C (POWER9), PowerNV, bare metal
> Firmware: skiboot-v6.8-45-g8246de863
> Kernel: 7.4.0-rc2+, upstream master at 067c5c24cef2 ("Merge tag
> 'page_alloc-for-7.4-rc2'", 2026-11-10)
> 
> 
> Issue1: Selftest should skip the adapter that host the rootfs
> 
> eeh_can_break() already skips ahci, for similar reason, but has no check for
> a device that backs /. A friendly LLM has suggested
> 
> below change, which I tested and it works.
> 
> 0003:01:00.0, Skipped: hosts the root filesystem
> 
> Other adapters are tested as before and the run completes
> 
> diff --git a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> index 70daa3925dcb..f9db1f9be05a 100644
> --- a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> +++ b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> @@ -62,6 +62,42 @@ eeh_test_prep() {
>      echo 5000 > /sys/kernel/debug/powerpc/eeh_max_freezes
>  }
> 
> +# Print the resolved sysfs path of a block device followed by the paths of
> +# every device stacked underneath it (dm, md, etc).
> +eeh_blk_sysfs_paths() {
> +    local sys="$1"
> +    local s
> +
> +    realpath "$sys"
> +    for s in "$sys"/slaves/* ; do
> +        if [ -e "$s" ] ; then
> +            eeh_blk_sysfs_paths "$s"
> +        fi
> +    done
> +}
> +
> +# Succeeds if the root filesystem lives on a disk behind any function of
> the
> +# slot containing the given PCI device.
> +eeh_hosts_rootfs() {
> +    local slot="${1%.*}"
> +    local majmin src sys
> +
> +    # Use the last "/" entry so an initramfs rootfs entry is ignored.
> +    majmin="$(awk '$5 == "/" { mm = $3 } END { print mm }'
> /proc/self/mountinfo)"
> +    src="$(awk '$5 == "/" { for (i = 6; i < NF; i++) if ($i == "-") s = $(i
> + 2) } END { print s }' /proc/self/mountinfo)"
> +
> +    if [ -e "/sys/dev/block/$majmin" ] ; then
> +        sys="/sys/dev/block/$majmin"
> +    elif [ -b "$src" ] ; then
> +        # e.g. btrfs reports an anonymous major:minor
> +        sys="/sys/class/block/$(basename "$(realpath "$src")")"
> +    else
> +        return 1
> +    fi
> +
> +    eeh_blk_sysfs_paths "$sys" 2>/dev/null | grep -q "/${slot}\.[0-7]/"
> +}
> +
>  eeh_can_break() {
>      # skip bridges since we can't recover them (yet...)
>      if [ -e "/sys/bus/pci/devices/$dev/pci_bus" ] ; then
> @@ -78,6 +114,14 @@ eeh_can_break() {
>          return 1;
>      fi
> 
> +    # Breaking the device that hosts the root filesystem makes I/O fail
> +    # during recovery, which can abort the journal and leave / read-only
> +    # (and kill the test harness). Leave it alone.
> +    if eeh_hosts_rootfs "$1" ; then
> +        log "$1, Skipped: hosts the root filesystem"
Well as per my understanding, Testing the device where rootfs is hosted on
seems like a valid usecase for selftest. Maybe we should keep that ability.
Atleast keep it as opt-in.

The above freeze happened because write failed. Can we perhaps create our
own freeze window so that none of
filesystem write fail.

I am suggesting to test the following (suggested by Friendly LLM :),

sync
fsfreeze -f /      # flush dirty data and the journal, then block new writes
# ... inject the error, wait for EEH recovery ...
fsfreeze -u /      # thaw

Thanks
~Shivang


