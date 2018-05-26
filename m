Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t9Ry1BYyzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:41:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH stable 4.14 00/23] powerpc backports for 4.14
In-Reply-To: <20180525112601.GA348@kroah.com>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
 <87bmd4q9ow.fsf@concordia.ellerman.id.au> <20180525112601.GA348@kroah.com>
Date: Sat, 26 May 2018 14:41:16 +1000
Message-ID: <87a7snt4er.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <greg@kroah.com> writes:
> On Fri, May 25, 2018 at 09:03:11PM +1000, Michael Ellerman wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Hi Greg,
>> >
>> > Please queue up this series of patches for 4.14 if you have no objections.
>> 
>> I just realised I didn't fix up the cherry-pick markings on these, so
>> they still say eg:
>> 
>>   (cherry picked from commit bdcb1aefc5b3f7d0f1dc8b02673602bca2ff7a4b)
>> 
>> Not the proper "commit bdcb1... upstream" style.
>> 
>> I'll hold off resending in case you have some sed magic to fix that, but
>> let me know if you'd like me to do it and resend the series.
>
> I don't have any sed magic for that, sorry.  Can you fix up and resend?

No worries.

I just resent them.

Below is a script that does it automatically, if you stick it in
.git/hooks/prepare-commit-msg.

cheers

#!/usr/bin/env python2
#
# prepare-commit-msg hook to rewrite git-cherry-pick style commit markers into
# the preferred form for Linux stable.
#
# ie. (cherry pick from commit abc..) -> commit abc.. upstream

import sys, re

patt = re.compile('(?:cherry picked from commit ([a-fA-F0-9]+))')

lines = open(sys.argv[1], 'r').readlines()
for line in lines:
    match = patt.search(line)
    if match:
        lines.remove(line)
        lines.insert(1, '\ncommit %s upstream.\n' % match.group(1))
        open(sys.argv[1], 'w').writelines(lines)
        break

sys.exit(0)
