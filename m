Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F09E71A0311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 22:33:30 +1100 (AEDT)
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 442EC14144B
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 22:33:29 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so57678983ykd.0
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 03:33:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447821827-17876-1-git-send-email-dja@axtens.net>
References: <1447821827-17876-1-git-send-email-dja@axtens.net>
Date: Wed, 18 Nov 2015 14:33:27 +0300
Message-ID: <CAOJe8K3xJ_Difk5aLJT=Jpz-f8tJfQx=9GE6=78FjRiqw4qHvA@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Add script to test HMI functionality
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org,
 Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/18/15, Daniel Axtens <dja@axtens.net> wrote:
> HMIs (Hypervisor Management|Maintenance Interrupts) are a class of interrupt
> on POWER systems.
>
> HMI support has traditionally been exceptionally difficult to test. However
> Skiboot ships a tool that, with the correct magic numbers, will inject them.
>
> This, therefore, is a first pass at a script to inject HMIs and monitor
> Linux's response. It injects an HMI on each core on every chip in turn.
> It then watches dmesg to see if it's acknowledged by Linux.
>
> On a Tuletta, I observed that we see 8 (or sometimes 9 or more) events per
> injection, regardless of SMT setting, so we wait for 8 before progressing.
>
> It sits in a new scripts/ directory in selftests/powerpc, because it's not
> designed to be run as part of the regular make selftests process. In
> particular, it is quite possibly going to end up garding lots of your CPUs,
> so it should only be run if you know how to undo that.

Hi Daniel,

Could you explain why it's useful, and what it's useful for. Moreover,
it's POWER8 feature, right?
>
> CC: Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  tools/testing/selftests/powerpc/scripts/hmi.sh | 77
> ++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100755 tools/testing/selftests/powerpc/scripts/hmi.sh
>
> diff --git a/tools/testing/selftests/powerpc/scripts/hmi.sh
> b/tools/testing/selftests/powerpc/scripts/hmi.sh
> new file mode 100755
> index 000000000000..ebce03933784
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/scripts/hmi.sh
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +# do we have ./getscom, ./putscom?
> +if [ -x ./getscom ] && [ -x ./putscom ]; then
> +	GETSCOM=./getscom
> +	PUTSCOM=./putscom
> +elif which getscom > /dev/null; then
> +	GETSCOM=$(which getscom)
> +	PUTSCOM=$(which putscom)
> +else
> +	cat <<EOF
> +Can't find getscom/putscom in . or \$PATH.
> +See https://github.com/open-power/skiboot.
> +The tool is in external/xscom-utils
> +EOF
> +	exit 1
> +fi
> +
> +# We will get 8 HMI events per injection
> +# todo: deal with things being offline
> +expected_hmis=8
> +COUNT_HMIS() {
> +    dmesg | grep -c 'Harmless Hypervisor Maintenance interrupt'
> +}
> +
> +# massively expand snooze delay, allowing injection on all cores
> +ppc64_cpu --smt-snooze-delay=1000000000
> +
> +# when we exit, restore it
> +trap "ppc64_cpu --smt-snooze-delay=100" 0 1
> +
> +# for each chip+core combination
> +# todo - less fragile parsing
> +egrep -o 'OCC: Chip [0-9a-f]+ Core [0-9a-f]' < /sys/firmware/opal/msglog |
> +while read chipcore; do
> +	chip=$(echo "$chipcore"|awk '{print $3}')
> +	core=$(echo "$chipcore"|awk '{print $5}')
> +	fir="0x1${core}013100"
> +
> +	# verify that Core FIR is zero as expected
> +	if [ "$($GETSCOM -c 0x${chip} $fir)" != 0 ]; then
> +		echo "FIR was not zero before injection for chip $chip, core $core.
> Aborting!"
> +		echo "Result of $GETSCOM -c 0x${chip} $fir:"
> +		$GETSCOM -c 0x${chip} $fir
> +		echo "If you get a -5 error, the core may be in idle state. Try
> stress-ng."
> +		echo "Otherwise, try $PUTSCOM -c 0x${chip} $fir 0"
> +		exit 1
> +	fi
> +
> +	# keep track of the number of HMIs handled
> +	old_hmis=$(COUNT_HMIS)
> +
> +	# do injection, adding a marker to dmesg for clarity
> +	echo "Injecting HMI on core $core, chip $chip" | tee /dev/kmsg
> +	# inject a RegFile recoverable error
> +	if ! $PUTSCOM -c 0x${chip} $fir 2000000000000000 > /dev/null; then
> +		echo "Error injecting. Aborting!"
> +		exit 1
> +	fi
> +
> +	# now we want to wait for all the HMIs to be processed
> +	# we expect one per thread on the core
> +	i=0;
> +	new_hmis=$(COUNT_HMIS)
> +	while [ $new_hmis -lt $((old_hmis + expected_hmis)) ] && [ $i -lt 12 ]; do
> +	    echo "Seen $((new_hmis - old_hmis)) HMI(s) out of $expected_hmis
> expected, sleeping"
> +	    sleep 5;
> +	    i=$((i + 1))
> +	    new_hmis=$(COUNT_HMIS)
> +	done
> +	if [ $i = 12 ]; then
> +	    echo "Haven't seen expected $expected_hmis recoveries after 1 min.
> Aborting."
> +	    exit 1
> +	fi
> +	echo "Processed $expected_hmis events; presumed success. Check dmesg."
> +	echo ""
> +done
> --
> 2.6.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
