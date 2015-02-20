Return-Path: <mohicks@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB4211A0F02
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 05:26:23 +1100 (AEDT)
Received: by mail-ig0-f178.google.com with SMTP id hl2so5132871igb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 10:26:21 -0800 (PST)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <CAJUS3XmnuUhgezxhBKeu2QLk-QqGVf3ZuwSycs_w=J3KC3BATg@mail.gmail.com>
References: <1424449276-5288-1-git-send-email-mort@bork.org>
 <CAJUS3XmnuUhgezxhBKeu2QLk-QqGVf3ZuwSycs_w=J3KC3BATg@mail.gmail.com>
Date: Fri, 20 Feb 2015 13:26:21 -0500
Message-ID: <CAJUS3XmPLvU2cWBJV0dVzQErVumaS+dVj+WzOfBKuKwT0wL-Mg@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: talitos: Add crypto async queue handling
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resending to linux-crypto in plain text.
Sorry to everyone else for the duplication.
mh

On Fri, Feb 20, 2015 at 1:23 PM, Martin Hicks <mort@bork.org> wrote:
>
> I've just noticed that performance is pretty terrible with maxcpus=1, so
> I'll investigate that.
> mh
>
> On Fri, Feb 20, 2015 at 11:21 AM, Martin Hicks <mort@bork.org> wrote:
>>
>> I was testing dm-crypt performance with a Freescale P1022 board with
>> a recent kernel and was getting IO errors while doing testing with LUKS.
>> Investigation showed that all hardware FIFO slots were filling and
>> the driver was returning EAGAIN to the block layer, which is not an
>> expected response for an async crypto implementation.
>>
>> The following patch series adds a few small fixes, and reworks the
>> submission path to use the crypto_queue mechanism to handle the
>> request backlog.
>>
>>
>> Martin Hicks (5):
>>   crypto: talitos: Simplify per-channel initialization
>>   crypto: talitos: Remove MD5_BLOCK_SIZE
>>   crypto: talitos: Fix off-by-one and use all hardware slots
>>   crypto: talitos: Reorganize request submission data structures
>>   crypto: talitos: Add software backlog queue handling
>>
>>  drivers/crypto/talitos.c |  189
>> ++++++++++++++++++++++++----------------------
>>  drivers/crypto/talitos.h |   44 +++++++++--
>>  2 files changed, 137 insertions(+), 96 deletions(-)
>>
>> --
>> 1.7.10.4
>>
>
>
>
> --
> Martin Hicks P.Eng.      |         mort@bork.org
> Bork Consulting Inc.     |   +1 (613) 266-2296



-- 
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
