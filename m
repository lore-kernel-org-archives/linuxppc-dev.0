Return-Path: <bruce.ashfield@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id D8958DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 00:10:26 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so285925ele
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 07:10:24 -0700 (PDT)
Message-ID: <3bd6b93c0709030710o21cab1b5y9c8438c40c53560e@mail.gmail.com>
Date: Mon, 3 Sep 2007 11:10:23 -0300
From: "Bruce Ashfield" <bruce.ashfield@windriver.com>
Sender: bruce.ashfield@gmail.com
To: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Subject: Re: rc4-rt1: powerpc compile errors
In-Reply-To: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com>
Cc: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/3/07, Pradyumna Sampath <pradyumna.sampath@gmail.com> wrote:
> Hi everyone,
>
> Here are some compile errors from the latest -rt patchset for powerpc
> (mpc5200).
>
> arch/powerpc/kernel/entry_32.S: Assembler messages:
> arch/powerpc/kernel/entry_32.S:231: Error: operand out of range
> (0x00023d87 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:644: Error: operand out of range
> (0x00022006 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:866: Error: operand out of range
> (0x00020004 is not between 0x00000000 and 0x0000ffff)
> arch/powerpc/kernel/entry_32.S:880: Error: operand out of range
> (0x00020004 is not between 0x00000000 and 0x0000ffff)
>
> Im not sure whether this is the right thing to do but we got around
> this by replacing the linux/include/asm-powerpc/thread_info.h with an
> older version of the same file from 2.6.21-rt3.

I don't have the code in front of me, but you can also shuffle
the flags to make sure that macro being used in entry_32.S
has all the flags within 16 bits (so the immediate operations
will successfully assemble). That's the route I took. The flags
have expanded past that threshold just recently.

Bruce


>
> regards
> /prady
>
> --
> htp://prady.livejournal.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
