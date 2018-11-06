Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12BC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:50:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054B420862
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054B420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8XP3D6RzF3C1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:50:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8KH3zMKzF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:40:35 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6CYR9b105848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Nov 2018 07:40:31 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nk9xcubk0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 07:40:31 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 6 Nov 2018 12:40:30 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Nov 2018 12:40:27 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA6CeQai27656430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 12:40:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C818AC060;
 Tue,  6 Nov 2018 12:40:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B98DAC05B;
 Tue,  6 Nov 2018 12:40:25 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  6 Nov 2018 12:40:25 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 00/14] New TM Model
Date: Tue,  6 Nov 2018 10:40:14 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18110612-0068-0000-0000-0000035B497F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009996; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113483; UDB=6.00577209; IPR=6.00893582; 
 MB=3.00024045; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 12:40:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110612-0069-0000-0000-000046555941
Message-Id: <1541508028-31865-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060112
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This  patchset for the hardware transactional memory (TM) subsystem
aims to avoid spending a lot of time on TM suspended mode in kernel
space.  It basically changes where the reclaim/recheckpoint will be
executed.

The hardware is designed so once a CPU enters in transactional state it
uses a footprint area to track down the loads/stores performed in
transaction so it can be verified later to decide if a conflict happened
due to some change done in that state by another thread.  If a transaction
is active in userspace and there is an exception that takes the CPU to the
kernel space, the CPU moves the transaction state to suspended state but
does not discard the registers (GPR,VEC,VSX,FP) from footprint area,
although the memory footprint might be discarded.

POWER9 has a known problem [1, 2] and does not have enough room in
footprint area for several transactions to be suspended at the same time
on various CPUs leading to CPU stalls.

This new model, together with a future 'fake userspace suspended'
implementation may workaround POWER9 hardware issue.

This patchset aims to reclaim the checkpointed registers as soon as the
kernel is invoked, in the beginning of the exception handlers, thus freeing
room to other CPUs enter in suspended mode for a short period of time as
soon as possible, avoiding too many CPUs in suspended state that can cause
the CPUs to stall. The same mechanism is done on kernel exit, doing a
recheckpoint as late as possible (which will reload the checkpointed
registers into CPU's checkpoint area) at the exception return path.

The way to achieve this goal is creating a macro (TM_KERNEL_ENTRY) which
will check if userspace was in an active transaction just after getting
into kernel space and reclaim the transaction if that's the case. Thus all
exception handlers will call this macro as soon as possible.

All exceptions should reclaim (if necessary) at this stage and only
recheckpoint if the task is tagged as TIF_RESTORE_TM (i.e. was in
transactional state before being interrupted), which will be done at
restore_tm_state().

Hence, by allowing the CPU to be in suspended state for only a brief period
it's possible to create the initial infrastructure that copes with the TM
hardware limitations.

This patchset was tested in different scenarios using different test
suites, as the kernel selftests, OpenJDK TM tests, and htm-torture [3], in the
following configuration:

 * POWER8/pseries LE and BE
 * POWER8/powernv LE
 * POWER9/pseries LE 
 * POWER8/powernv LE hosting KVM guests running TM tests

This patchset is based on initial work done by Cyril Bur:
    https://patchwork.ozlabs.org/cover/875341/

V1 patchset URL: https://patchwork.ozlabs.org/cover/969173/

Major Change from v1:
 
 * restore_tm_state() being called later at the kernel exit path, so, there is
   no way to replay any IRQ, which will be done with TM in suspended state.
   This is mostly described in the 'Recheckpoint at exit path' patch.

 * No neeed to force TEXASR[FS] bit explicitly. This was required because
   in a very specific case, TEXASR SPR was not being restored properly but
   MSR[TM] was set. Fixed in patch 'Do not restore TM without SPRs'.

 * All treclaim/trechkpoint have a WARN_ON() if not called on kernel
   entrance or exit path. tm_reclaim() is only called by TM_KERNEL_ENTRY
   and tm_recheckpoint is only called by restore_tm_state(). All the rest
   causes a warning.
 
Regards,
Breno

[1] Documentation/powerpc/transactional_memory.txt
[2] commit 4bb3c7a0208fc13ca70598efd109901a7cd45ae7
[3] https://github.com/leitao/htm_torture/

Breno Leitao (14):
  powerpc/tm: Reclaim transaction on kernel entry
  powerpc/tm: Reclaim on unavailable exception
  powerpc/tm: Recheckpoint when exiting from kernel
  powerpc/tm: Always set TIF_RESTORE_TM on reclaim
  powerpc/tm: Refactor the __switch_to_tm code
  powerpc/tm: Do not recheckpoint at sigreturn
  powerpc/tm: Do not reclaim on ptrace
  powerpc/tm: Recheckpoint at exit path
  powerpc/tm: Warn if state is transactional
  powerpc/tm: Improve TM debug information
  powerpc/tm: Save MSR to PACA before RFID
  powerpc/tm: Restore transactional SPRs
  powerpc/tm: Do not restore TM without SPRs
  selftests/powerpc: Adapt tm-syscall test to no suspend

 arch/powerpc/include/asm/exception-64s.h      |  50 ++++
 arch/powerpc/include/asm/thread_info.h        |   2 +-
 arch/powerpc/kernel/asm-offsets.c             |   4 +
 arch/powerpc/kernel/entry_64.S                |  37 ++-
 arch/powerpc/kernel/exceptions-64s.S          |  15 +-
 arch/powerpc/kernel/process.c                 | 242 ++++++++++--------
 arch/powerpc/kernel/ptrace.c                  |  16 +-
 arch/powerpc/kernel/signal.c                  |   2 +-
 arch/powerpc/kernel/signal_32.c               |  38 +--
 arch/powerpc/kernel/signal_64.c               |  42 ++-
 arch/powerpc/kernel/tm.S                      |  19 +-
 arch/powerpc/kernel/traps.c                   |  22 +-
 .../testing/selftests/powerpc/tm/tm-syscall.c |   6 -
 13 files changed, 293 insertions(+), 202 deletions(-)

-- 
2.19.0

