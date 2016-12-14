Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdhw01p6FzDt1l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 14:32:16 +1100 (AEDT)
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdhvz3ypMz9sDB
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 14:32:15 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id l126so1097121vkh.0
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 19:32:15 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <3t3mJS0hfYz9sxS@ozlabs.org>
References: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
 <3t3mJS0hfYz9sxS@ozlabs.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Dec 2016 14:01:50 +1030
Message-ID: <CACPK8Xf3X=bEj-EUXezYYEKNJwkqW4O0RiM2FcCtH4cNNxA-qw@mail.gmail.com>
Subject: Re: powerpc: cmp -> cmpd for 64-bit
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 gregkh@linuxfoundation.org
Cc: Segher Boessenkool <segher@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
 markus@trippelsdorf.de, amodra@gmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2016 at 8:51 PM, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Thu, 2016-06-10 at 13:42:19 UTC, Segher Boessenkool wrote:
>> PowerPC's "cmp" instruction has four operands.  Normally people write
>> "cmpw" or "cmpd" for the second cmp operand 0 or 1.  But, frequently
>> people forget, and write "cmp" with just three operands.
>>
>> With older binutils this is silently accepted as if this was "cmpw",
>> while often "cmpd" is wanted.  With newer binutils GAS will complain
>> about this for 64-bit code.  For 32-bit code it still silently assumes
>> "cmpw" is what is meant.
>>
>> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
>
> Applied to powerpc fixes, thanks.
>
> I added:
>   Fixes: 948cf67c4726 ("powerpc: Add NAP mode support on Power7 in HV mode")
>   Cc: stable@vger.kernel.org # v3.0
>
> https://git.kernel.org/powerpc/c/80f23935cadb1c654e81951f5a8b7c

This one made it into 4.9-rc3 as "powerpc: Convert cmp to cmpd in idle
enter sequence". We need it to build the 4.4 kernel with GCC 6.2, so
my OpenPower firmware builds are failing.

The patch won't backport directly as in 4.4 the macro is in
arch/powerpc/kernel/idle_power7.S.

Greg, is this one in your queue? Do we need to send a patch to stable
that backports cleanly?

Cheers,

Joel
