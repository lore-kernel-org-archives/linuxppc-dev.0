Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssxSt2xZ4zDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 21:39:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 ravi.bangoria@linux.vnet.ibm.com, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: perf TUI fails with "failed to process type: 64"
In-Reply-To: <20161010211812.13eb89d5@kryten>
References: <20161009121232.174915eb@kryten>
 <874m4k7q5s.fsf@concordia.ellerman.id.au> <20161010211812.13eb89d5@kryten>
Date: Mon, 10 Oct 2016 21:39:25 +1100
Message-ID: <87r37o5vz6.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:
>> >  14c00-14c00 g exc_virt_0x4c00_system_call  
>>    ^
>>    What's this? The address? If so it's wrong?
>
> Offset into the binary I think, there's one 64kB page of ELF gunk at
> the start.

Ah OK makes sense.

>> So more digging required.
>
> Thanks for checking, it's starting to sound like a perf bug.

Yeah possibly. I'll build an updated perf tomorrow and see if I can
reproduce.

As an aside, it looks like it would be easy to set the size with the new
macro. Does the patch below help at all?

The other thing Nick mentioned is we could set the type of those symbols
to function, though that's not entirely correct. But it might help perf
and probably wouldn't break anything else (that I can think of right now
anyway).

cheers


diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index ab90c2fa1ea6..0e250d4eff44 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -122,6 +122,7 @@ name:
 	.error "Fixed entry overflow";				\
 	.abort;							\
 	.endif;							\
+	.size name, (. - name);					\
 	. = ((end) - sname##_start);				\
 
 
