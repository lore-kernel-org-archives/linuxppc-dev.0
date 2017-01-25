Return-Path: <joel.stan@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7f0f1dRjzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 19:51:14 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id u143so15074972oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 00:51:14 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <874m0namx5.fsf@concordia.ellerman.id.au>
References: <20170113035349.15923-1-joel@jms.id.au>
 <87bmuyb2i3.fsf@concordia.ellerman.id.au>
 <874m0namx5.fsf@concordia.ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 25 Jan 2017 19:50:47 +1100
Message-ID: <CACPK8Xd6ruhe1Fq3ERTDu655wkf0iP4TFych36KSm=8qdZK_bA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: opal-msglog: Report size of memcons log
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 1:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Joel Stanley <joel@jms.id.au> writes:
>>
>>> The OPAL memory console is reported to be size zero, as we do not
>>> initialise the struct attr with any size information due to the size
>>> being variable. This leads users to think that the console is empty.
>>
>> Hmm OK. That is a general property of /proc and /sys files that are
>> dynamically generated, so users probably need to get used to it :)
>>
>>> Instead report the maximum size.
>>
>> But OK. That sounds sane enough. My only worry is that it might confuse
>> some tools, ie. the file claims to be x bytes but is actually smaller.
>> But I guess that can actually happen anyway with any file.
>>
>> So I'll merge this and stop blabbing :)
>
> Hmm, but then I get:
>
>   $ ls -la msglog
>   -r--r--r-- 1 root root 4503599627370496 Jan 25 13:09 msglog
>
> I know firmware likes to spit out lots of messages, but 4PB seems a bit
> large :P
>
> I fixed it with the patch below which I'll fold in, resulting in:
>
>   $ ls -la msglog
>   -r--r--r-- 1 root root 1048576 Jan 25 13:30 msglog
>
>
> Which seems more likely.

My bad. In my excitement I forgot to mention that this was just an
idea, and I had not boot tested it.

Thanks for testing it and finding the bug.

Cheers,

Joel
