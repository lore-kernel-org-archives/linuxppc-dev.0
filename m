Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 6F260679A6
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 May 2006 05:38:34 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id l35so701024nfa
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 06 May 2006 12:38:32 -0700 (PDT)
Message-ID: <528646bc0605061238q37c253fdua58f826ac1a519d7@mail.gmail.com>
Date: Sat, 6 May 2006 13:38:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
Subject: Re: Calculating virtual address from physical address
In-Reply-To: <200605061843.k46Ih5Vd032048@www-webmail1.magma.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605061843.k46Ih5Vd032048@www-webmail1.magma.ca>
Cc: dhlii@comcast.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/6/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
> You said that the temporary TLB entries setup in head_4xx.S will eventual=
ly be replaced.
> Where is the code that creates these new TLB entries later on? Are the 'r=
eal' TLB entries
> only created once, and persist for as long as the system is running, or d=
o TLB entries
> change often while the system is running?

The kernel maintains a list of mappings between virtual and physical
space.  When the processor takes a TLB miss exception, then exception
handler loads the needed mapping into the TLB and returns from
exception.  (Look in head_4xx.S; specifically at finish_tlb_load).=20
TLB entries are loaded in a round-robin fashion as needed.  Since your
early TLB mappings aren't in the kernel page tables; they get
overwritten and can't be reloaded by the TLB miss exception handler.

> Can you point me to some information about Grant's platform bus changes t=
hat you were
> talking about? I am using a custom V2Pro board, and I'd be interested to =
see if this code
> is something I should be looking at.

The platform bus changes moves the devices to use the "Platform Bus"
infrastructure.  It's kind of a move away from multiple
processor-specific bus management schemes for "simple" busses.  ie.=20
If the processor can access it without special setup code; the device
can go on the platform bus.

Check out http://patchwork.ozlabs.org/linuxppc/ and search for my
name.  There's about 9 patches grouped together.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
