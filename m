Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id B9D0A68604
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 19:21:42 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 31 Oct 2005 10:21:34 +0200
References: <200510280857.44625.david.jander@protonic.nl>
	<20051028153059.GC18915@logos.cnet>
In-Reply-To: <20051028153059.GC18915@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510310921.34696.david.jander@protonic.nl>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 28 October 2005 17:30, Marcelo Tosatti wrote:
>[...]
> David,
>
> Do you have CONFIG_PIN_TLB enabled?
>
> If you do, please patch this in:
>
> http://www.kernel.org/git/?p=linux/kernel/git/marcelo/8xx-fixes;a=commitdif
>f;h=a41ba028534c45280170c05c23609ea84f34b38a
>
> And select DEBUG_PIN_TLBIE.

Ok, done that... no change.
I don't get any of those debug messages, so I guess that was not the problem.

I have made another test in the meantime, trying to check if cache is working.
The test is pretty simple: see how fast I can fill a block of memory whose 
size is increasing by a power of two. You should expect to see a step-like 
decrease in speed when surpassing the size of the data cache (4kbyte).

The results are very suspicious:

kernel-2.4:

Memsize    512 : 39.342773 Mbyte/s
Memsize   1024 : 41.871094 Mbyte/s
Memsize   2048 : 43.212891 Mbyte/s
Memsize   4096 : 40.117188 Mbyte/s
Memsize   8192 : 28.148438 Mbyte/s
Memsize  16384 : 28.484375 Mbyte/s
Memsize  32768 : 28.656250 Mbyte/s
Memsize  65536 : 28.687500 Mbyte/s

This looks quite healthy: above 4kbyte we see a clear drop in performance, so 
we just learned that our data-cache is most probably 4kbyte in size, wow!

Kernel-2.6:

Memsize    512 : 21.033691 Mbyte/s
Memsize   1024 : 22.047852 Mbyte/s
Memsize   2048 : 22.601562 Mbyte/s
Memsize   4096 : 22.882812 Mbyte/s
Memsize   8192 : 23.007812 Mbyte/s
Memsize  16384 : 23.093750 Mbyte/s
Memsize  32768 : 23.125000 Mbyte/s
Memsize  65536 : 23.125000 Mbyte/s

No, sir, no cache detected !

Where do I have to look now?

Greetings,

-- 
David Jander
Protonic Holland.
