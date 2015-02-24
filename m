Return-Path: <arjanvandeven@gmail.com>
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com
 [IPv6:2a00:1450:400c:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C7371A1EBA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:39:50 +1100 (AEDT)
Received: by wesw62 with SMTP id w62so23896409wes.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 01:39:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150224063513.GA15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <20150224063513.GA15387@gmail.com>
Date: Tue, 24 Feb 2015 01:39:46 -0800
Message-ID: <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
From: Arjan van de Ven <arjanvandeven@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Don Zickus <dzickus@redhat.com>, X86 ML <x86@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 sam.bobroff@au1.ibm.com, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Some architectures already have their own recursive
>> locking for oopses and we have another version for
>> serialising dump_stack.
>>
>> Create a common version and use it everywhere (oopses,
>> BUGs, WARNs, dump_stack, soft lockups and hard lockups).
>
> Dunno. I've had cases where the simultaneity of the oopses
> (i.e. their garbled nature) gave me the clue about the type
> of race to expect.
>


one of the question is if you want to serialize, or if you just want to label.
If you take a cookie (could just be a monotonic increasing number) at
the start of the oops
and then prefix/postfix the stack printing with that number, you don't
serialize (risk of locking up),
but you can pretty trivially see which line  came from where..
if you do the monotonic increasing number approach, you even get an
ordering out of it.
it does mean changing the dump_stack() and co function fingerprint to
take an extra argument,
but that is not TOO insane.
