Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9610BC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 07:29:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23FF20882
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 07:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23FF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B3yM1hMZzDrgD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B3vz5tSTzDrX4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 18:27:43 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB77OM5i124141
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Dec 2018 02:27:40 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p7jmucmw0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 02:27:40 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Fri, 7 Dec 2018 07:27:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 7 Dec 2018 07:27:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB77RVPC61145330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 07:27:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACFF9A4060;
 Fri,  7 Dec 2018 07:27:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F345FA4054;
 Fri,  7 Dec 2018 07:27:26 +0000 (GMT)
Received: from sathnaga86 (unknown [9.102.2.169])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri,  7 Dec 2018 07:27:26 +0000 (GMT)
Date: Fri, 7 Dec 2018 12:57:24 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18120707-0028-0000-0000-0000032752D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120707-0029-0000-0000-000023E36B2A
Message-Id: <20181207072724.GA3750@sathnaga86>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812070065
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org,
 arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 y2038@lists.linaro.org, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 Breno Leitao <leitao@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 deepa.kernel@gmail.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 07, 2018 at 11:41:35AM +0530, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
> 
> The system call tables are in different format in 
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a 
> script and which'll generate uapi header file and 
> syscall table file.
> 
> syscall.tbl contains the list of available system 
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in 
> the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
> 	- Compat entry name, if required.
> 	- spu entry name, if required.
> 
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to 
> come up with a generic solution.
> 
> I have done the same support for work for alpha, 
> ia64, m68k, microblaze, mips, parisc, sh, sparc, 
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
> 
> https://github.com/frzkhn/system_call_table_generator/
> 
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to 
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in the
> syscall.tbl.
> 
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.
Hi Firoz,

This version(v4) booted fine in IBM Power8 box.
Compiled with 'ppc64le_defconfig' aginst https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=a26b21082959cee3075b3edb7ef23071c7e0b09a

Reference failure v3 version: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/182110.html

Regards,
-Satheesh.
> 
> Changes since v2:
>  - modified/optimized the syscall.tbl to avoid duplicate
>    for the spu entries.
>  - updated the syscalltbl.sh to meet the above point.
> 
> Changes since v1:
>  - optimized/updated the syscall table generation 
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall_*.tbl.
>  - changed from generic-y to generated-y in Kbuild.
> 
> Firoz Khan (5):
>   powerpc: add __NR_syscalls along with NR_syscalls
>   powerpc: move macro definition from asm/systbl.h
>   powerpc: add system call table generation support
>   powerpc: split compat syscall table out from native table
>   powerpc: generate uapi header and system call table files
> 
>  arch/powerpc/Makefile                       |   3 +
>  arch/powerpc/include/asm/Kbuild             |   4 +
>  arch/powerpc/include/asm/syscall.h          |   3 +-
>  arch/powerpc/include/asm/systbl.h           | 396 --------------------------
>  arch/powerpc/include/asm/unistd.h           |   3 +-
>  arch/powerpc/include/uapi/asm/Kbuild        |   2 +
>  arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
>  arch/powerpc/kernel/Makefile                |  10 -
>  arch/powerpc/kernel/entry_64.S              |   7 +-
>  arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  arch/powerpc/kernel/systbl.S                |  40 ++-
>  arch/powerpc/kernel/systbl_chk.c            |  60 ----
>  arch/powerpc/kernel/vdso.c                  |   7 +-
>  arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
>  17 files changed, 606 insertions(+), 898 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/systbl.h
>  create mode 100644 arch/powerpc/kernel/syscalls/Makefile
>  create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
>  delete mode 100644 arch/powerpc/kernel/systbl_chk.c
> 
> -- 
> 1.9.1
> 

