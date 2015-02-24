Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37DDB1A12CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 21:44:47 +1100 (AEDT)
Date: Tue, 24 Feb 2015 10:43:40 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arjan van de Ven <arjanvandeven@gmail.com>
Subject: Re: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
Message-ID: <20150224104339.GT8656@n2100.arm.linux.org.uk>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <20150224063513.GA15387@gmail.com>
 <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Don Zickus <dzickus@redhat.com>, X86 ML <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>,
 sam.bobroff@au1.ibm.com, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 01:39:46AM -0800, Arjan van de Ven wrote:
> one of the question is if you want to serialize, or if you just want
> to label.  If you take a cookie (could just be a monotonic increasing
> number) at the start of the oops and then prefix/postfix the stack
> printing with that number, you don't serialize (risk of locking up),
> but you can pretty trivially see which line came from where..
> if you do the monotonic increasing number approach, you even get an
> ordering out of it. it does mean changing the dump_stack() and co
> function fingerprint to take an extra argument, but that is not TOO
> insane.

I like that idea, but it relies on ensuring that each line is printed
by one printk() statement - which in itself is a good idea.

I'd actually like a version of print_hex_dump() which we could use for
stack and code dumping - the existing print_hex_dump() assumes that it's
fine to dereference the pointer, whereas for stack and code dumping,
we can't always make that assumption.  That's a separate issue though.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
