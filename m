Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 208FC1A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 22:44:02 +1100 (AEDT)
In-Reply-To: <vnkwk2oum9b8.fsf@codeaurora.org>
References: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au>
 <vnkwk2oum9b8.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] of: Fix comparison of reserved memory regions
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sat, 05 Dec 2015 22:43:57 +1100
To: Mitchel Humpherys <mitchelh@codeaurora.org>
CC: robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, frowand.list@gmail.com,
 grant.likely@linaro.org
Message-ID: <5CD6EBAA-D0D6-434A-B9EA-B144C05711BC@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 5 December 2015 04:07:39 GMT+11:00, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
>On Wed, Nov 18 2015 at 09:46:38 PM, Michael Ellerman
><mpe@ellerman.id.au> wrote:
>> In order to check for overlapping reserved memory regions, we first
>need
>> to sort the array of memory regions. This is implemented using
>sort(),
>> and a custom comparison function __rmem_cmp().
>>
>> Unfortunatley __rmem_cmp() doesn't work in all cases. Because the two
>> base values are phys_addr_t, they may be u64 on some platforms, in
>which
>> case subtracting one from the other and then (implicitly) casting to
>int
>> does not give us the -ve/0/+ve value we need.
>>
>> This leads to incorrect reports about overlaps, eg:
>>
>>   ibm,slw-image@1ffe600000 (0x0000001ffe600000--0x0000001ffe700000)
>overlaps with
>>   ibm,firmware-allocs-memory@1000000000
>(0x0000001000000000--0x0000001000dc0200)
>>
>> Fix it by just doing the standard double if and return 0 logic.
>>
>> Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory
>regions")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/of/of_reserved_mem.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>
>Woops, thanks.
>
>Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>

Thanks for testing.

Rob, can we get this merged for 4.4 please?

cheers 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
