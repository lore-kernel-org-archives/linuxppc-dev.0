Return-Path: <linuxppc-dev+bounces-23050-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F48DC43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:11:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpbWg4RtNz2yhY;
	Mon, 29 Jun 2026 16:11:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782713487;
	cv=none; b=C97QmM03vFPwYhZfrRjgf97ZGKeEItm/VGZw1kWW0ZuIOpwmWAxiwOEKSR7dQT6oRCGoS2Rwj1ME3K616uy20aJW9f6pNmqG87bVMmfo0c401oSEupLp99f/jyt4sLL5ROdfFmfm6+kugLube/yOd/zjWNG7GXcvm3Pkyk7sarkl62dBO8ixhdUMtaOB/Bqoi6cxgKV+Pb1WvGFu1LmYHjU8gRBSYOq/syalHs+4qKXAJOXrSxhWUsCEdvCldP0RZmVosxCB2XcHPKQj/K2+50sI8s0JTKVO/W61fEEGOUUqq6OCGesQdTDo2eRJtuxyAlY/V2986JYZAKHAVGOqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782713487; c=relaxed/relaxed;
	bh=vQvEaIj31yNjKG9HzwNPIskclcZFRJX1wjKwQ2wffX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS3jEd37KdK6vqE/QgD8GIZ4Ni3/J+nHXL7HXe6ap/ZPPqcWv+0Wgg2LeaneNZj6pILSw7V/u5YSENimhQcKuUhvHrbNgvkJqwnWPv9otV2xWLVM3s6nhqIQBE3K8crWQjRgeXKKn7hRDNRgBwaQnBXFgziNxqdiMxRaQn3RjIL89E1AZc+qvcADBDQaRbq/N2144uFBT4FKGwv+YYSqbDtnbJoGce3jKdoEpmc1jpnnWGCkEnrgQ+SimX/rDlyLP0pfcy5SOyfwFXbrYrmcb7ajuE8etmKBH5oEDzO1RF756i6HQmDmrfQ6UZJSxbk06qfJ5Cyc+kExYWRIGow+Dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nZ0GPfxt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nZ0GPfxt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpbWb5xwjz2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 16:11:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3JoDI1954481;
	Mon, 29 Jun 2026 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vQvEaIj31yNjKG9HzwNPIskclcZFRJX1wjKwQ2wff
	X4=; b=nZ0GPfxtovN7VSr0GVss8ESGPD1Yrwi2UTNuup2I6rRXVsTNPxXd8xpc9
	Vm/M3H4zSPqej5pfFxKf1OOxqxjXwb0V9v2pNecfYIe8BF2pOFK/0kOdgjnOTlAt
	RHy3YDkvWTm6B7vigLT+/AuiZvOm9RvslwHi2KCre8xBAf1na7bbZvkqk/4hYLlp
	HoZtkiLxBmX1J09EELKt2pbeVoABpTjzjFH9ZPYkkykE1Sc/1n2TMr0EywIkOnbt
	wffW65S7NBHRnddK4MNYyUZ7zW2450J6MpzInjYvyvR21+nUKnjZY6VJj4T925OM
	+yTN2jxYei/5vIzSEVjavRj2Q22Yg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjfmda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T64d18006260;
	Mon, 29 Jun 2026 06:11:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g3wy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:11:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T6BBOn61735272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 06:11:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00FE420049;
	Mon, 29 Jun 2026 06:11:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98CCF20040;
	Mon, 29 Jun 2026 06:11:09 +0000 (GMT)
Received: from dhcp-9-123-15-26.bl1-in.ibm.com (unknown [9.123.15.26])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 06:11:09 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        shivani@linux.ibm.com, tshah@linux.ibm.com
Subject: [RFC 0/3] powerpc/perf: Add Device Tree based PMU description framework
Date: Mon, 29 Jun 2026 11:40:19 +0530
Message-ID: <20260629061101.43119-1-shivani@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX6YjzTx7J6MjQ
 EYPePJfWxVJkAAvAOrCLufR/BYGZ1asudoguCK+Mv0BxdhogLxgPTnOhsAsMElAArdZXE/aguj5
 08yXi0rv5NgqzuirwYi4FvIBYGGimRpP55d7DaTrkkszl8kqIyK/CQHFR4+kaSF9o5O8goYsCzX
 xm6EZnkpEYxLp3BDaOhUCZfKqcdl3DWF6wW+WcGBEkXgMC0ssk0h8s91y1Twh3F2qfwV6mGijg2
 pigKw/Y5K2mB33VK4r8qEGIVb80xCKiOJIKqJOOFJybrP0n0Mc5Eg42xRJIRRvjMYtvxd96vAL0
 S10tAhMKktf4TOJYCGqZ/J5LoXJ3aAt8eJZHqd9PCdAUood7TXgaB5G9DpNcQHprAxE5/wkfkS6
 Jc1XK2D/Qs1RYGRfcTn99E+cwLb0GKbGq9GcoF8PPtN5Y75I1p7QKrSqLpcrn2VvTgZAGDQ6CWQ
 zXWd42oSzXCnxykkgOA==
X-Proofpoint-GUID: xgXGSXzuClBSH5PHRM1aQwMXWobNlB3Y
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a420c83 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=WvX7VD2CBKCRy93ivgcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX+3eVxK5x9n95
 rvX5ig6/tV2EDHYUQ5YbGE7khmtRAWFoPu3R2AlZuLgoZ7mt7CqE7zi6bTZU2lXpCY7ch5wpmId
 v/Liy5jugUS08PT4PzUzNsJnjOA++Kg=
X-Proofpoint-ORIG-GUID: xgXGSXzuClBSH5PHRM1aQwMXWobNlB3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290047

PowerPC has a Performance Monitoring Unit (PMU) infrastructure which provides
comprehensive performance monitoring capabilities at the processor level. The
PMU includes programmable counters (PMCs) and control registers (MMCRs) that
enable detailed performance analysis and profiling.

The PowerPC PMU consists of 6 Performance Monitor Counters (PMCs), where PMC1-4
are fully programmable and can monitor any supported event, while PMC5 and PMC6
are dedicated to counting instructions and cycles respectively. The PMU is
controlled through 5 Monitor Mode Control Registers (MMCRs) that configure
event selection, sampling modes, thresholds, and other monitoring parameters.

This patchset enables the PowerPC PMU by providing a device tree specification
that describes the PMU hardware capabilities, event encoding format, register
mappings, and event constraints. The device tree approach allows firmware
(OPAL/skiboot) to communicate PMU capabilities to the kernel dynamically,
enabling better hardware abstraction and forward compatibility.

PMU Hardware Components:
The PowerPC PMU provides the following hardware components:
- 6 Performance Monitor Counters (PMC1-PMC6)
 * PMC1-4: Programmable counters (32-bit, any event)
 * PMC5: Fixed counter for instructions (32-bit)
 * PMC6: Fixed counter for cycles (32-bit)
- 5 Monitor Mode Control Registers
 * MMCR0 (SPR 795): Primary control register
 * MMCR1 (SPR 798): Event selection and configuration
 * MMCR2 (SPR 785): Extended event configuration
 * MMCR3 (SPR 754): Additional event source selection
 * MMCRA (SPR 0x312): Sampling and marking control

Event Encoding Format:
The device tree describes how 64-bit event codes are decomposed into fields
that map to specific bits in the MMCR registers. Key encoding fields include:
- PMCxSEL: 8-bit event selector (256 events per PMC)
- PMCxUNIT: 4-bit unit selector for event source
- PMCxCOMB: 2-bit combine mode for multi-counter operations
- THRESH_SEL/START/STOP: Threshold-based event filtering
- SDAR_MODE: Data address sampling configuration
- MARK: Instruction marking for sampling
- L2L3_SELECT: Cache event selection
- IFM: Instruction fetch marking mode

Event Constraints:
The PMU enforces several hardware constraints that are described in the DTS:
- Counter restrictions: PMC5 limited to instructions (0x500fa), PMC6 limited
 to cycles (0x600f4)
- Sampling constraints: Events with sampling require specific bit patterns
- Threshold constraints: Threshold events require coordinated MMCR field values
- Cache constraints: Cache events restricted to specific units (6,7,8,9) and
 require PMC4 for certain operations
- EBB (Event-Based Branching) constraints: EBB events require PMC assignment
- BHRB (Branch History Rolling Buffer) constraints: BHRB requires EBB enabled
- L1 qualifier constraints: L1 cache qualifiers for load/store filtering
- Radix scope constraints: Radix page table scope qualification

PMU Events Information:
The device tree includes definitions for common performance events such as:
- Core events: cycles, instructions, dispatch/execution stalls
- Branch events: branches, branch-misses, branch predictions
- Cache events: L1/L2/L3 hits and misses for data and instructions
- TLB events: DTLB and ITLB misses
- Memory events: load/store operations and cache reloads

The kernel discovers the PMU configuration in the device tree at the "pmus"
device node which contains a "pmu_dts@0" child node with compatible field
"ibm,power-pmu".

Parsing of the PMU Information:
To parse the PMU configuration, the kernel discovers the "pmus" node and
walks through the PMU definition, extracting:
- Hardware capabilities (number of PMCs, MMCRs)
- SPR (Special Purpose Register) definitions
- Event code format and field mappings
- MMCR bit field configurations
- Event constraints and restrictions
- Pre-defined event list with codes and descriptions

Here is an excerpt of the DTS showing the PMU node structure:
pmus {
	#address-cells = <1>;
	#size-cells = <0>;

	pmu_dts@0 {
		compatible = "ibm,power-pmu";
		reg = <0>;
		pmu-name = "POWER10 PMU";
		pmu-version = "PowerISA 3.1";
		platform = "power10";
		status = "okay";
		nr_pmc = <6>;
		nr_mmcr = <5>;

		sprs {
			pmcs {
				pmc1 {
					sprn = <787>;
					register-width = <32>;
					privilege = "hv";
					programmable = <1>;
					event = "any";
					status = "okay";
				};
				[...]
			};
			mmcr {
				mmcr0 {
					sprn = <795>;
					register-width = <64>;
					privilege = "hv";
					status = "okay";
				};
				[...]
			};
		};

		evt_code_format {
			compatible = "ibm,power-pmu";

			PMCxSEL {
				description = "PMC event selector (256 possible events per PMC)";
				bits = <0 7>;
				length = <8>;
				mmcr = <1>;
				target_field_base = <32>;
				target_field_shift = <8>;
			};
			[...]
		};

		constraints {
			pmc-constraints {
				max-counter = <6>;

				restricted-counters-5 {
					pmc = <5>;
					valid-events = <0x00000000 0x000500fa>;
				};

				restricted-counters-6 {
					pmc = <6>;
					valid-events = <0x00000000 0x000600f4>;
				};
			};
			[...]
		};

		events {
			cycles {
				event_code = <0x600f4>;
				event-category = "core";
				event-class = "primary";
				description = "Number of processor cycles";
				status = "okay";
			};
			instructions {
				event_code = <0x500fa>;
				event-category = "core";
				event-class = "primary";
				description = "Number of instructions completed";
				status = "okay";
			};
			[...]
		};
	};
};

From the device tree, the kernel parses the PMU hardware description, event
encoding format, constraints, and pre-defined events.

After parsing the PMU configuration, the PMU and its events are registered
with the kernel's perf subsystem, making them available for performance
monitoring and profiling.

This series depends on the corresponding skiboot patches:
https://github.com/maddy-kerneldev/skiboot/commit/783e33f17f13412b89b774124cef0988c0578829

Comments/feedback/suggestions are welcome.

Next Steps:
1) Add DTS support for peripheral and unit-specific PMU events.
2) Extend the DTS schema for additional MMCR registers and controls.
3) Support advanced PMU features such as BHRB.
4) Feedback from Community

Shivani Nittor (3):
  powerpc/perf: Register PMU from device tree and expose events
  powerpc/perf: Add DTS-based MMCR computation
  powerpc/perf: Add DTS-based event constraints

 arch/powerpc/include/asm/dts_pmu.h    |  82 ++++
 arch/powerpc/perf/Makefile            |   4 +-
 arch/powerpc/perf/core-book3s.c       |  12 +-
 arch/powerpc/perf/dts_pmu.c           | 536 ++++++++++++++++++++++++++
 arch/powerpc/perf/internal.h          |   1 +
 arch/powerpc/perf/isa207-common.c     | 262 +++++++++++++
 arch/powerpc/perf/isa207-common.h     |   4 +
 arch/powerpc/platforms/powernv/opal.c |  15 +
 8 files changed, 914 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/dts_pmu.h
 create mode 100644 arch/powerpc/perf/dts_pmu.c

-- 
2.54.0


