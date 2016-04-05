Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfkMp5jXYzDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 08:40:38 +1000 (AEST)
In-Reply-To: <1459850183.20087.67.camel@kernel.crashing.org>
References: <3qfNxw4KcCz9sD5@ozlabs.org>
 <1459850183.20087.67.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: powerpc: Clear user CPU feature bits if TM is disabled at runtime
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 06 Apr 2016 08:40:27 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
CC: qemu-ppc@nongnu.org,qemu-devel@nongnu.org
Message-ID: <B7A5B48E-B50A-4C51-BBDE-B6AB52B24D3A@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 5 April 2016 7:56:23 pm AEST, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>On Tue, 2016-04-05 at 19:35 +1000, Michael Ellerman wrote:
>> Shouldn't we be clearing the user feature there too?
>> 
>> The ibm_pa_features array and the logic in scan_features() knows to
>> flip the
>> cpu_user_features bits, it was just never updated to handle
>> cpu_user_features2.
>> 
>> So it seems to me that's where the bug is.
>
>I was about to make the same comment but then realized we are trying to
>clear *2* bits. And since that logic will also, I think, set the bits
>when the corresponding pa-feature is present, it means we will also set
>those 2 bits if we put both in the mask...

That's what we want in this case. The 2nd bit describes Linux's behaviour of aborting active transactions in syscalls, so kernels that have that bit defined should be setting/clearing it in lock step with the main TM bit. 

cheers
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
