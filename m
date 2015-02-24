Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA4241A0D1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 17:35:21 +1100 (AEDT)
Received: by mail-wi0-f180.google.com with SMTP id h11so22688884wiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 22:35:18 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 24 Feb 2015 07:35:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
Message-ID: <20150224063513.GA15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
Cc: Don Zickus <dzickus@redhat.com>, x86@kernel.org,
 Russell King <linux@arm.linux.org.uk>, peterz@infradead.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, sam.bobroff@au1.ibm.com,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> Every now and then I end up with an undebuggable issue 
> because multiple CPUs hit something at the same time and 
> everything is interleaved:
> 
>         CR: 48000082  XER: 00000000
>         ,RI
>         c0000003dc72fd10
>         ,LE
>         d0000000065b84e8
>         Instruction dump:
>         MSR: 8000000100029033
> 
> Very annoying.
> 
> Some architectures already have their own recursive 
> locking for oopses and we have another version for 
> serialising dump_stack.
> 
> Create a common version and use it everywhere (oopses, 
> BUGs, WARNs, dump_stack, soft lockups and hard lockups). 

Dunno. I've had cases where the simultaneity of the oopses 
(i.e. their garbled nature) gave me the clue about the type 
of race to expect.

To still get that information: instead of taking a 
serializing spinlock (or in addition to it), it would be 
nice to at least preserve the true time order of the 
incidents, at minimum by generating a global count for 
oopses/warnings (a bit like the oops count # currently), 
and to gather it first - before taking any spinlocks.

Thanks,

	Ingo
