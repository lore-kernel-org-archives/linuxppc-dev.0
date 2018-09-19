Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Fj604n75zF0RK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:33:44 +1000 (AEST)
Date: Wed, 19 Sep 2018 09:32:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/32: add stack protector support
Message-ID: <20180919143243.GY23155@gate.crashing.org>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
 <20180919132618.GX23155@gate.crashing.org>
 <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 04:22:52PM +0200, Christophe LEROY wrote:
> >It looks like it will be easy to enable on 64 bit as well.
> 
> Will it ? It seems that PPC64 doesn't have r2 pointing to current task 
> struct, but instead it has r13 pointing to the paca struct. Which means 
> we should add a canary in the paca struct, and populate it at task 
> switch from current->stack_canary. Or am I missing something ?

No, I am just forgetting things :-)

> >>+	/* Try to get a semi random initial value. */
> >>+	get_random_bytes(&canary, sizeof(canary));
> >>+	canary ^= mftb();
> >>+	canary ^= LINUX_VERSION_CODE;
> >
> >These last two lines are useless (or worse, they may give people the idea
> >that they are not!)
> 
> Well, the last line is in all arches except x86
> The mftb() was suggested by Michael to add some entropy.
> x86 does the same sort of thing with their rdtsc()
> 
> >
> >You should use wait_for_random_bytes I think.
> 
> On the 8xx, it takes several minutes before crnd_is_ready(), while 
> boot_init_stack_canary() is called quite early in start_kernel()

If you do not provide real entropy to the canary, the canary doesn't help
providing protection as much as you may hope.


Segher
