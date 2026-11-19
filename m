Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BD606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NoJaHiyb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVY9V2sBTz2y0B;
	Thu, 19 Nov 2026 20:30:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795080638;
	cv=none; b=ao1hPBe96WmRs2ojvhkU0tzyw6BJubs6EZhVQye/y+Zjzc9l/N7dmAthhSY62EnQm4KXlDfrAKsahlni9YGDPwHxWcLyMjdcONt44Wu/9qeayktADUN+GUewbJL45G4qQ+O+58PWcxzpjPo2t3c0k3PSb8AHN/SvgODX7dJI9gqnU1JZ0RRzqYNggv61bwB2A02dparN3PDAY8D75ZjGUPAw0z1Mk1btHMg5YJfSk5morPJLYfRRYw1CMDXLEfZW3iKluVrjaZdi9iEauf3YvoLUJ/+d+/gJNXnbNr9HD0ZBnRnzBXRTo+zGzjzQVyWIip65EDO0P5sMHyUN8tnC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795080638; c=relaxed/relaxed;
	bh=oXSxWpF6KMQEcM2O7Evo65h0Ne4A9GyvN44olTG3Jnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfLhRpT8bm8Oan86NTJ32Ugcnb3zV6/kcyqarTK04CVCkZyAIV/wMSsqUuDhuTPa/rRlcgG38h767Xb7ZpsrX7xy/2OXx1rS5Yk+HmLlbb3JxynhnrEILE+pIhXlV9fECu1IBU/dFP+CCz/VP18Lx/4Axrgq3Tvijm+BbIBeMPZBv30DLB1F7BupQkghyjud+48NqkJJa8Db+iww2ykFsMrsMDZZ+p1tLmk9qyi4FHk2tx0l2A7ulijY5tIs2CNhsxToeOj0LUfiaQFnD+s7M7jywZYY9Qlj4+mPaPCDyi5ABsrj8tXClX1qj/dCQ6DdQbbQL77vovwMgeM1XnBGhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NoJaHiyb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NoJaHiyb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVY9S5rvyz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:30:36 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uWYj3422488;
	Thu, 19 Nov 2026 09:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oXSxWp
	F6KMQEcM2O7Evo65h0Ne4A9GyvN44olTG3Jnk=; b=NoJaHiybk14TYzc2H0fzjS
	RwdowrROJ9Vs+zRgQAXZ/9r/B4oBsUN2HedpGMzCupPMQGnPDxOvL7vFFpszw4Fl
	8THIyogOLzIkZjPKUzDlyetaXb/yEIlXhEFCgJet2y2G2lb1k8kfAeCqTBxRgRZn
	KuvbG+/6NU03l0T4hfp/uUzXycz8kLYDP0tIdyo3ZDYDNyTM4hztug4Rj/EXpOXQ
	zNbRuUoztDrgKMOmGoS5feEzDP81ngAv+DxopDj8IfJdmfYeT1/+nb1vlIUQtJJc
	hOraqbtwSWirw913fZ5zr0sPs7SPKLSsc8QWkoPqDkJ4SJlJQn+lKA6wzX19slMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wyr6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:30:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ751Iw472310;
	Thu, 19 Nov 2026 09:30:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6uenj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:30:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ9UJJn17826172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 09:30:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5858820043;
	Thu, 19 Nov 2026 09:30:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853482004B;
	Thu, 19 Nov 2026 09:30:14 +0000 (GMT)
Received: from [9.124.217.219] (unknown [9.124.217.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 09:30:14 +0000 (GMT)
Message-ID: <d76a72b5-e489-47fe-81bd-a3bf5935c209@linux.ibm.com>
Date: Thu, 19 Nov 2026 15:00:13 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cacheinfo, powerpc: Move powerpc to generic cacheinfo
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, Samir M <samir@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261118163639.890546-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Y_LZc8CESEW_sUlisyuSBcYsXuRwST2b
X-Proofpoint-GUID: Qd0b7JzILWRuIw6cngOC7LjKoST-ljCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNyBTYWx0ZWRfX1af4UOBKFWGk
 j+nwJr2I46baeKAXxrlORUn5EQIt7/N9tg/rp/dDWi6bHXC0Sba6u3PSFbK/or9Htd7OX8k1kow
 vzHaFKW4OCv1bxai7RZDw8DcajG4F+ND2SmjACsYrybH3sbs3kGueSr4Gx4NcYnhUj9aNfGd9WR
 Q7yvNAeg499YrrnG8O1PNCLwhKezmHwBi9k6QHeRAV6Swyb1Oz7H26zhh3xFJcwhUEBKgg86DFi
 8oGdTDbk88ssaqV4h6WNu6t0vG6kla7+o2hZpU1w0tQa9FkA9w8oNwgyh1a3Dz6bYECeyRQ7jBK
 llfeuzkOL9w12hejJKqvAhrHg4Vg8vWGuWfejSHHm+fLZCZ+1aSS6NXGhEsTqpYcADSSfze/9+U
 z3XHIOJN/Nv+URHZDhyNr1/p/sAxuJbhmT8Y9VCIrQNgagstyCOp2LdgZB9TxUO3nrtGuc8xAAb
 zn+QRnlWgCbBC11tBEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNyBTYWx0ZWRfX7UFXuDDXjzav
 +OhWsbEDc+SOJ+B+Fxp+eGhCUvKCZ8hKx6w5i8ge5djv4e2E6x2HU5+J7oc3N/DvcFLHbJO2Itn
 Y1ttKkMeQYRYYfOR3M8cxCWd4CKKASA=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afec1b0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Vh4Lmjysm8k9_e_hK4cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190037
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+samir, Venkat


> Tested the values compatibilty on Power11 Dedicated and Shared LPAR's.
> All the values are same, except id and uevent which was not there
> before. That should help rather than hurt any tool.
> 
> This may need more broader checks on different boards/configuration
> to ensure it is same. Also DLPAR CPU add/remove is not tested yet.
> Please test and report if your board/platform shows up any different
> values in those cache entries.
> 

Could you please help to run DLPAR and ensure the cache sysfs entries remain
same. Also if you have a P7/P8 it would be great if you validate there as well.

Please find the below script that i used to do the verification.
(Again, thanks to LLM)

---

#!/usr/bin/env bash
#
# Validate PowerPC cacheinfo before and after migration to generic cacheinfo.
#
# Usage:
#   sudo ./validate-cacheinfo.sh capture before
#
#   # Reboot into the patched kernel
#
#   sudo ./validate-cacheinfo.sh capture after
#   sudo ./validate-cacheinfo.sh compare before after
#
# Expected additions from generic cacheinfo:
#   index*/id
#   index*/uevent
#
# These attributes are excluded from the compatibility comparison.
#

set -euo pipefail

SYS_CPU=/sys/devices/system/cpu

die()
{
	echo "ERROR: $*" >&2
	exit 1
}

command_exists()
{
	command -v "$1" >/dev/null 2>&1
}

capture_file()
{
	local source=$1
	local destination=$2

	if [[ -r "$source" ]]; then
		cat "$source" > "$destination"
	else
		printf '<unavailable>\n' > "$destination"
	fi
}

capture_cache_sysfs()
{
	local output=$1
	local cpu_dir cache_dir index attr
	local cpu index_name value

	: > "$output"

	for cpu_dir in "$SYS_CPU"/cpu[0-9]*; do
		[[ -d "$cpu_dir" ]] || continue

		cpu=${cpu_dir##*/cpu}
		cache_dir="$cpu_dir/cache"

		echo "Capturing CPU $cpu" >&2

		if [[ ! -d "$cache_dir" ]]; then
			printf '%s\t%s\t%s\t%s\n' \
				"$cpu" \
				"<none>" \
				"<cache-directory>" \
				"<absent>" \
				>> "$output"
			continue
		fi

		for index in "$cache_dir"/index*; do
			[[ -d "$index" ]] || continue

			index_name=${index##*/}

			#
			# Do not use find -type f. Sysfs attributes are virtual
			# files and may not be classified consistently by all
			# find implementations.
			#
			for attr in "$index"/*; do
				[[ -e "$attr" || -L "$attr" ]] || continue
				[[ ! -d "$attr" ]] || continue
				[[ -r "$attr" ]] || continue

				value=$(
					tr '\n' ' ' < "$attr" |
						sed 's/[[:space:]]*$//'
				)

				printf '%s\t%s\t%s\t%s\n' \
					"$cpu" \
					"$index_name" \
					"${attr##*/}" \
					"$value" \
					>> "$output"
			done
		done
	done

	sort -t $'\t' \
		-k1,1n \
		-k2,2V \
		-k3,3 \
		"$output" -o "$output"
}

generate_compatibility_view()
{
	local snapshot=$1

	#
	# The old PowerPC implementation did not expose id or uevent.
	# Exclude both when checking whether existing ABI values changed.
	#
	awk -F $'\t' '
		$3 != "id" && $3 != "uevent" {
			print
		}
	' "$snapshot/cacheinfo.tsv" \
		> "$snapshot/cacheinfo-compatible.tsv"
}

generate_id_view()
{
	local snapshot=$1
	local cpu index attribute value

	: > "$snapshot/cache-ids.tsv"

	while IFS=$'\t' read -r cpu index attribute value; do
		if [[ "$attribute" == "id" ]]; then
			printf '%s\t%s\t%s\n' \
				"$cpu" "$index" "$value" \
				>> "$snapshot/cache-ids.tsv"
		fi
	done < "$snapshot/cacheinfo.tsv"
}

generate_uevent_view()
{
	local snapshot=$1
	local cpu index attribute value

	: > "$snapshot/cache-uevents.tsv"

	while IFS=$'\t' read -r cpu index attribute value; do
		if [[ "$attribute" == "uevent" ]]; then
			printf '%s\t%s\t%s\n' \
				"$cpu" "$index" "$value" \
				>> "$snapshot/cache-uevents.tsv"
		fi
	done < "$snapshot/cacheinfo.tsv"
}

capture_snapshot()
{
	local output=$1
	local leaves ids uevents

	[[ -n "$output" ]] || die "capture directory is required"
	[[ ! -e "$output" ]] || die "$output already exists"

	mkdir -p "$output"

	uname -a > "$output/uname.txt"
	capture_file /proc/version "$output/version.txt"
	capture_file /proc/cmdline "$output/cmdline.txt"

	capture_file "$SYS_CPU/online" "$output/cpus-online.txt"
	capture_file "$SYS_CPU/offline" "$output/cpus-offline.txt"
	capture_file "$SYS_CPU/possible" "$output/cpus-possible.txt"
	capture_file "$SYS_CPU/present" "$output/cpus-present.txt"

	capture_cache_sysfs "$output/cacheinfo.tsv"

	generate_compatibility_view "$output"
	generate_id_view "$output"
	generate_uevent_view "$output"

	if command_exists lscpu; then
		timeout 60 lscpu \
			> "$output/lscpu.txt" 2>&1 || true

		timeout 60 lscpu -C \
			> "$output/lscpu-cache.txt" 2>&1 || true

		timeout 60 lscpu -e=CPU,CORE,SOCKET,NODE,CACHE \
			> "$output/lscpu-extended.txt" 2>&1 || true

		#
		# Exclude CACHE from the automatically compared view because
		# lscpu may switch from userspace-generated contiguous numbers
		# to sparse kernel-provided cache IDs.
		#
		timeout 60 lscpu -e=CPU,CORE,SOCKET,NODE \
			> "$output/lscpu-topology.txt" 2>&1 || true
	fi

	dmesg > "$output/dmesg.txt" 2>/dev/null || true

	leaves=$(
		awk -F $'\t' '
			$3 == "level" {
				count++
			}
			END {
				print count + 0
			}
		' "$output/cacheinfo.tsv"
	)

	ids=$(wc -l < "$output/cache-ids.tsv")
	uevents=$(wc -l < "$output/cache-uevents.tsv")

	echo
	echo "Captured snapshot: $output"
	echo "Cache leaves:      $leaves"
	echo "Cache IDs:         $ids"
	echo "Cache uevents:     $uevents"

	if [[ "$ids" -eq 0 ]]; then
		echo "No cache IDs found."
		echo "This is expected for the old PowerPC cacheinfo implementation."
	fi

	if [[ "$uevents" -eq 0 ]]; then
		echo "No cache uevent files found."
		echo "This is expected for the old PowerPC cacheinfo implementation."
	fi
}

expand_cpu_list()
{
	local list=$1
	local item first last cpu
	local -a elements

	IFS=',' read -r -a elements <<< "$list"

	for item in "${elements[@]}"; do
		if [[ "$item" == *-* ]]; then
			first=${item%-*}
			last=${item#*-}

			for ((cpu = first; cpu <= last; cpu++)); do
				echo "$cpu"
			done
		else
			echo "$item"
		fi
	done
}

build_leaf_records()
{
	local snapshot=$1
	local output=$2

	awk -F $'\t' '
	{
		key = $1 SUBSEP $2
		value[key, $3] = $4
		seen[key] = 1
	}
	END {
		for (key in seen) {
			split(key, part, SUBSEP)

			if (part[2] == "<none>")
				continue

			printf "%s\t%s\t%s\t%s\t%s\t%s\n",
			       part[1],
			       part[2],
			       value[key, "level"],
			       value[key, "type"],
			       value[key, "id"],
			       value[key, "shared_cpu_list"]
		}
	}' "$snapshot/cacheinfo.tsv" |
		sort -t $'\t' -k1,1n -k2,2V > "$output"
}

lookup_leaf_field()
{
	local records=$1
	local cpu=$2
	local level=$3
	local type=$4
	local field=$5

	awk -F $'\t' \
		-v cpu="$cpu" \
		-v level="$level" \
		-v type="$type" \
		-v field="$field" '
		$1 == cpu && $3 == level && $4 == type {
			if (field == "id")
				print $5
			else if (field == "shared")
				print $6
			exit
		}
	' "$records"
}

validate_new_ids()
{
	local snapshot=$1
	local records
	local cpu index level type id shared
	local sibling sibling_id sibling_shared
	local failed=0

	records=$(mktemp)
	build_leaf_records "$snapshot" "$records"

	echo
	echo "Validating generic cache IDs..."

	while IFS=$'\t' read -r cpu index level type id shared; do
		if [[ -z "$id" ]]; then
			echo "ERROR: cpu${cpu}/${index} has no id"
			failed=1
			continue
		fi

		if [[ -z "$shared" ]]; then
			echo "ERROR: cpu${cpu}/${index} has no shared_cpu_list"
			failed=1
			continue
		fi

		#
		# Every CPU in shared_cpu_list must report the same ID and
		# shared CPU list for a leaf of the same level and type.
		#
		while IFS= read -r sibling; do
			sibling_id=$(
				lookup_leaf_field \
					"$records" \
					"$sibling" \
					"$level" \
					"$type" \
					"id"
			)

			sibling_shared=$(
				lookup_leaf_field \
					"$records" \
					"$sibling" \
					"$level" \
					"$type" \
					"shared"
			)

			if [[ -z "$sibling_id" ]]; then
				echo "ERROR: cpu${cpu}/${index}: CPU ${sibling}" \
				     "has no L${level} ${type} cache ID"
				failed=1
			elif [[ "$sibling_id" != "$id" ]]; then
				echo "ERROR: cpu${cpu}/${index}: ID is ${id}," \
				     "but CPU ${sibling} has ID ${sibling_id}"
				failed=1
			fi

			if [[ -z "$sibling_shared" ]]; then
				echo "ERROR: cpu${cpu}/${index}: CPU ${sibling}" \
				     "has no L${level} ${type} shared_cpu_list"
				failed=1
			elif [[ "$sibling_shared" != "$shared" ]]; then
				echo "ERROR: cpu${cpu}/${index}: shared list is" \
				     "${shared}, but CPU ${sibling} reports" \
				     "${sibling_shared}"
				failed=1
			fi
		done < <(expand_cpu_list "$shared")
	done < "$records"

	rm -f "$records"

	if (( failed )); then
		echo "Cache ID validation: FAILED"
		return 1
	fi

	echo "Cache ID validation: PASS"
}

compare_file()
{
	local description=$1
	local before=$2
	local after=$3

	echo
	echo "Comparing $description..."

	if diff -u "$before" "$after"; then
		echo "$description: PASS"
		return 0
	fi

	echo "$description: FAILED"
	return 1
}

compare_snapshots()
{
	local before=$1
	local after=$2
	local failed=0
	local before_ids after_ids
	local before_uevents after_uevents

	[[ -f "$before/cacheinfo-compatible.tsv" ]] ||
		die "$before is not a valid snapshot"

	[[ -f "$after/cacheinfo-compatible.tsv" ]] ||
		die "$after is not a valid snapshot"

	if ! compare_file \
		"cache sysfs values excluding id and uevent" \
		"$before/cacheinfo-compatible.tsv" \
		"$after/cacheinfo-compatible.tsv"; then
		failed=1
	fi

	for mask in online offline possible present; do
		if ! compare_file \
			"CPU ${mask} mask" \
			"$before/cpus-${mask}.txt" \
			"$after/cpus-${mask}.txt"; then
			failed=1
		fi
	done

	if [[ -f "$before/lscpu-topology.txt" &&
	      -f "$after/lscpu-topology.txt" ]]; then
		if ! compare_file \
			"lscpu topology without cache IDs" \
			"$before/lscpu-topology.txt" \
			"$after/lscpu-topology.txt"; then
			failed=1
		fi
	fi

	before_ids=$(wc -l < "$before/cache-ids.tsv")
	after_ids=$(wc -l < "$after/cache-ids.tsv")

	before_uevents=$(wc -l < "$before/cache-uevents.tsv")
	after_uevents=$(wc -l < "$after/cache-uevents.tsv")

	echo
	echo "Expected generic-cacheinfo additions:"
	echo "  Before IDs:     $before_ids"
	echo "  After IDs:      $after_ids"
	echo "  Before uevents: $before_uevents"
	echo "  After uevents:  $after_uevents"

	if [[ "$after_ids" -eq 0 ]]; then
		echo "ERROR: patched kernel exposes no index*/id attributes"
		failed=1
	fi

	if [[ "$after_uevents" -eq 0 ]]; then
		echo "ERROR: patched kernel exposes no index*/uevent attributes"
		failed=1
	fi

	echo
	echo "Cache IDs exposed by generic cacheinfo:"

	if [[ -s "$after/cache-ids.tsv" ]]; then
		if command_exists column; then
			{
				printf 'CPU\tINDEX\tID\n'
				cat "$after/cache-ids.tsv"
			} | column -t -s $'\t'
		else
			cat "$after/cache-ids.tsv"
		fi
	fi

	if ! validate_new_ids "$after"; then
		failed=1
	fi

	echo
	echo "Informational files for manual inspection:"
	echo "  $before/lscpu-cache.txt"
	echo "  $after/lscpu-cache.txt"
	echo "  $before/lscpu-extended.txt"
	echo "  $after/lscpu-extended.txt"
	echo
	echo "The lscpu CACHE column may legitimately change from contiguous"
	echo "userspace-generated values to sparse kernel-provided cache IDs."
	echo
	echo "The new id and uevent files are treated as expected ABI additions"
	echo "and are excluded from the compatibility diff."

	if (( failed )); then
		echo
		echo "Overall result: FAILED"
		return 1
	fi

	echo
	echo "Overall result: PASS"
}

usage()
{
	cat <<EOF
Usage:
   $0 capture <directory>
   $0 compare <before-directory> <after-directory>

Example:
   sudo $0 capture before
   # Reboot into the patched kernel
   sudo $0 capture after
   sudo $0 compare before after
EOF
}

[[ $# -ge 1 ]] || {
	usage
	exit 1
}

case "$1" in
capture)
	[[ $# -eq 2 ]] ||
		die "capture requires one output directory"

	capture_snapshot "$2"
	;;

compare)
	[[ $# -eq 3 ]] ||
		die "compare requires before and after directories"

	compare_snapshots "$2" "$3"
	;;

*)
	usage
	exit 1
	;;
esac


