Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C92BB2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 10:46:44 +1100 (EST)
Received: by mail-ea0-f178.google.com with SMTP id a15so4011857eae.37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 15:46:40 -0800 (PST)
Message-ID: <52FAB65C.4090201@gmail.com>
Date: Wed, 12 Feb 2014 00:46:36 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
 <20140211072606.GA26514@visitor2.iram.es>
 <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
 <63AEBD99-AA87-4FD7-BBDA-0CE419959F14@kernel.crashing.org>
 <52FAA97F.4060600@gmail.com> <1392162080.6733.404.camel@snotra.buserror.net>
In-Reply-To: <1392162080.6733.404.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2014 12:41 AM, Scott Wood wrote:
> On Tue, 2014-02-11 at 23:51 +0100, Sebastian Hesselbarth wrote:
>> On 02/11/2014 11:33 PM, Kumar Gala wrote:
>>> Hmm,
>>>
>>> Wondering if this caused the issue:
>>>
>>> commit 105353145eafb3ea919f5cdeb652a9d8f270228e
>>> Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Date:   Tue Dec 3 14:52:00 2013 +0100
>>>
>>>       OF: base: match each node compatible against all given matches first
>>
>> [adding Arnd on Cc]
>>
>> Could be. I checked tty/serial/of_serial.c and it does not provide a
>> compatible for "fsl,ns16550". Does reverting the patch fix the issue
>> observed?
>>
>> I don't think the missing compatible is causing it, but of_serial
>> provides a DT match for .type = "serial" just to fail later on
>> with the error seen above.
>>
>> The commit in question reorders of_match_device in a way that match
>> table order is not relevant anymore. This can cause it to match
>> .type = "serial" first here.
>>
>> Rather than touching the commit, I suggest to remove the problematic
>> .type = "serial" from the match table. It is of no use anyway.
>
> Regardless of whether .type = "serial" gets removed, it seems wrong for
> of_match_node() to accept a .type-only match (or .name, or anything else
> that doesn't involve .compatible) before it accepts a compatible match
> other than the first in the compatible property.

Right, I thought about it and came to the same conclusion. I sent a
patch a second ago to prefer .compatible != NULL matches over those
with .compatible == NULL.

Would be great if Stephen can re-test that. If it solves the issue, I
can send a patch tomorrow.

Sebastian
