Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116191A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 10:37:54 +1100 (AEDT)
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D33AD140DA8
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2015 10:37:51 +1100 (AEDT)
Received: by pfdd184 with SMTP id d184so37485562pfd.3
 for <linuxppc-dev@ozlabs.org>; Wed, 09 Dec 2015 15:37:50 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/powerpc: Add script to test HMI functionality
In-Reply-To: <CAOJe8K3xJ_Difk5aLJT=Jpz-f8tJfQx=9GE6=78FjRiqw4qHvA@mail.gmail.com>
References: <1447821827-17876-1-git-send-email-dja@axtens.net>
 <CAOJe8K3xJ_Difk5aLJT=Jpz-f8tJfQx=9GE6=78FjRiqw4qHvA@mail.gmail.com>
Date: Thu, 10 Dec 2015 10:37:35 +1100
Message-ID: <87h9jrxkg0.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

I just realised I sent my reply to Denis not the list - apologies. This
info goes for v2 as well.

  > Could you explain why it's useful, and what it's useful for. Moreover,
  > it's POWER8 feature, right?

  I'm not sure whether you're asking about the script or HMIs. Explaining
  HMIs helps make sense of the script, so I'll start there.

  HMIs are a class of interrupt or exception that, broadly speaking,
  require the hypervisor to intervene to 'do something'. They are (very
  lightly) documented in the POWER ISA, which is available on the
  OpenPOWER website. That file doesn't do a particuarly good job of
  explaining what can trigger an HMI, because that's a Book IV question.

  So, while I can't point you to documentation about what might cause an
  HMI, I can point you to some source code. Here goes:

  An HMI will (per the ISA) cause execution to jump to
  0x0000 0000 0000 0E60. Through some asm and C you end up calling
  ppc_md.hmi_exception_early() and then possibly
  ppc_md.handle_hmi_expection(). This is only defined on PowerNV, where
  they point to opal_hmi_exception_early() and
  opal_handle_hmi_exception() respectively.

  The early exception calls into opal through opal_handle_hmi, which is an
  OPAL call (OPAL_HANDLE_HMI). skiboot/core/hmi.c lists the contents of
  the HMER (Hypervisor Maintenance Exception Register), which identifies
  the actual cause of the HMI. You can find the list in the skiboot repo
  on github, including the action that will be taken:
  https://github.com/open-power/skiboot/blob/master/core/hmi.c
  The rest of the file fleshes out the mechanics of HMIs: for example,
  where they are caused by the failure of a POWER8 co-processor such as
  CAPI or NX.

  Some HMIs are relayed by Skiboot to Linux by sending an OPAL_MSG_HMI_EVT
  to Linux. This triggers off some further processing which causes a
  message to be printed in dmesg. The relevant file here is
  platforms/powernv/opal-hmi.c

  The script, therefore, is useful because:
   - HMIs are an exceptional/error condition that is not hit in normal
     operation. Indeed, without the xscom commands in this script
     (or a CAPI card), it's almost impossible to hit them.
   - HMIs involve communications between Skiboot and Linux, involve
     touching the PACA, and generally work in an area that is prone to
     bugs, so testing them is especially valuable.
   - The script is carefully calibrated to send HMIs that trigger a
     message in dmesg but which don't checkstop the machine.

  To answer your final question, I'm not entirely sure if HMIs are POWER8
  specific. I suspect they've been around for a lot longer, but maybe
  someone who's been around IBM chips for longer than me could clarify this.

  Regards,
  Daniel


Denis Kirjanov <kda@linux-powerpc.org> writes:

> On 11/18/15, Daniel Axtens <dja@axtens.net> wrote:
>> HMIs (Hypervisor Management|Maintenance Interrupts) are a class of interrupt
>> on POWER systems.
>>
>> HMI support has traditionally been exceptionally difficult to test. However
>> Skiboot ships a tool that, with the correct magic numbers, will inject them.
>>
>> This, therefore, is a first pass at a script to inject HMIs and monitor
>> Linux's response. It injects an HMI on each core on every chip in turn.
>> It then watches dmesg to see if it's acknowledged by Linux.
>>
>> On a Tuletta, I observed that we see 8 (or sometimes 9 or more) events per
>> injection, regardless of SMT setting, so we wait for 8 before progressing.
>>
>> It sits in a new scripts/ directory in selftests/powerpc, because it's not
>> designed to be run as part of the regular make selftests process. In
>> particular, it is quite possibly going to end up garding lots of your CPUs,
>> so it should only be run if you know how to undo that.
>
> Hi Daniel,
>
> Could you explain why it's useful, and what it's useful for. Moreover,
> it's POWER8 feature, right?
>>
>> CC: Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  tools/testing/selftests/powerpc/scripts/hmi.sh | 77
>> ++++++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100755 tools/testing/selftests/powerpc/scripts/hmi.sh
>>
>> diff --git a/tools/testing/selftests/powerpc/scripts/hmi.sh
>> b/tools/testing/selftests/powerpc/scripts/hmi.sh
>> new file mode 100755
>> index 000000000000..ebce03933784
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/scripts/hmi.sh
>> @@ -0,0 +1,77 @@
>> +#!/bin/sh
>> +
>> +# do we have ./getscom, ./putscom?
>> +if [ -x ./getscom ] && [ -x ./putscom ]; then
>> +	GETSCOM=./getscom
>> +	PUTSCOM=./putscom
>> +elif which getscom > /dev/null; then
>> +	GETSCOM=$(which getscom)
>> +	PUTSCOM=$(which putscom)
>> +else
>> +	cat <<EOF
>> +Can't find getscom/putscom in . or \$PATH.
>> +See https://github.com/open-power/skiboot.
>> +The tool is in external/xscom-utils
>> +EOF
>> +	exit 1
>> +fi
>> +
>> +# We will get 8 HMI events per injection
>> +# todo: deal with things being offline
>> +expected_hmis=8
>> +COUNT_HMIS() {
>> +    dmesg | grep -c 'Harmless Hypervisor Maintenance interrupt'
>> +}
>> +
>> +# massively expand snooze delay, allowing injection on all cores
>> +ppc64_cpu --smt-snooze-delay=1000000000
>> +
>> +# when we exit, restore it
>> +trap "ppc64_cpu --smt-snooze-delay=100" 0 1
>> +
>> +# for each chip+core combination
>> +# todo - less fragile parsing
>> +egrep -o 'OCC: Chip [0-9a-f]+ Core [0-9a-f]' < /sys/firmware/opal/msglog |
>> +while read chipcore; do
>> +	chip=$(echo "$chipcore"|awk '{print $3}')
>> +	core=$(echo "$chipcore"|awk '{print $5}')
>> +	fir="0x1${core}013100"
>> +
>> +	# verify that Core FIR is zero as expected
>> +	if [ "$($GETSCOM -c 0x${chip} $fir)" != 0 ]; then
>> +		echo "FIR was not zero before injection for chip $chip, core $core.
>> Aborting!"
>> +		echo "Result of $GETSCOM -c 0x${chip} $fir:"
>> +		$GETSCOM -c 0x${chip} $fir
>> +		echo "If you get a -5 error, the core may be in idle state. Try
>> stress-ng."
>> +		echo "Otherwise, try $PUTSCOM -c 0x${chip} $fir 0"
>> +		exit 1
>> +	fi
>> +
>> +	# keep track of the number of HMIs handled
>> +	old_hmis=$(COUNT_HMIS)
>> +
>> +	# do injection, adding a marker to dmesg for clarity
>> +	echo "Injecting HMI on core $core, chip $chip" | tee /dev/kmsg
>> +	# inject a RegFile recoverable error
>> +	if ! $PUTSCOM -c 0x${chip} $fir 2000000000000000 > /dev/null; then
>> +		echo "Error injecting. Aborting!"
>> +		exit 1
>> +	fi
>> +
>> +	# now we want to wait for all the HMIs to be processed
>> +	# we expect one per thread on the core
>> +	i=0;
>> +	new_hmis=$(COUNT_HMIS)
>> +	while [ $new_hmis -lt $((old_hmis + expected_hmis)) ] && [ $i -lt 12 ]; do
>> +	    echo "Seen $((new_hmis - old_hmis)) HMI(s) out of $expected_hmis
>> expected, sleeping"
>> +	    sleep 5;
>> +	    i=$((i + 1))
>> +	    new_hmis=$(COUNT_HMIS)
>> +	done
>> +	if [ $i = 12 ]; then
>> +	    echo "Haven't seen expected $expected_hmis recoveries after 1 min.
>> Aborting."
>> +	    exit 1
>> +	fi
>> +	echo "Processed $expected_hmis events; presumed success. Check dmesg."
>> +	echo ""
>> +done
>> --
>> 2.6.2
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWaLs/AAoJEPC3R3P2I92FlgcQAIWL0YFRYSZXoentIIA7Yu1v
kGAZIDKHlEgeSk5yMbcEd2Wy76Q1Xs2uILzycF86zyzqAshCv2aK/moEAxIjXMWJ
M7aZ3N/adWNObzQ7C7aVhhxIu7ZdsTuHCAfLp0zpYPKH8JYXgmLbxaX/J+yo/V1e
Mrs3/dzWjyFEZJujt/n6q8JfxmM/Ddi7oFQly/bOZeDfNzljW6ccT8AwIDSSTpmq
T8urPFGYJ3rEDGb9Bd40TNz/JlPy+ULr1EXksPLhvCXim6LnoD/v1JOaV46+oso2
No3K8Qi2nN5cSvzDCGekFg7ZPD0vt+ytr6DSwAx4ZBRDPnL6Xuw9Fa9vNg3kSJgS
eqWm8Pz+xKCe4fVv89iLdsM7f3gHELPKTRPlQ0GoB14lmfLJi/zGgh/m11q69plM
PD7KNR+SiVTPh4+HjaOm0rpaZkZVRO07GeAm3lZAVntMOc7pUCiozo0GRLTmdsO0
RTZqZ533zuW4KegZjT3ME9C9R/r2nc+UdHOU06Hec7zYDQubdqa502kphywZwASl
Ne2swfvmZld1fhvX/u+1ut87aQuRSHht90ETMZvPzSQpkdWuQYzgnBGlpwvxHVeB
vdIzQ/9ktdFYWqNh6s3byTTgCFVBY033mv9eKeeZ0X435D5uD5V2Auq9oRR+zv/s
HAdqyR9LnrTDyTdDmpaD
=9/Te
-----END PGP SIGNATURE-----
--=-=-=--
