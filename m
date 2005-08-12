Return-Path: <hollisb@us.ibm.com>
In-Reply-To: <20050812050609.GA7355@krispykreme>
References: <a22149f6d9cc6f65ae2f8f339d982dd2@us.ibm.com>
	<20050812050609.GA7355@krispykreme>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b9a91d3eebf79c9cc8a2b67cc5e3f84@us.ibm.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Fri, 12 Aug 2005 08:58:32 -0500
To: Anton Blanchard <anton@samba.org>
Cc: PPC64-dev List <linuxppc64-dev@ozlabs.org>,
	Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: GDB backtrace and signal trampolines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 12, 2005, at 12:06 AM, Anton Blanchard wrote:
>
>> Would it make sense to limit the test to within a few hundred bytes of
>> the stack pointer? Or some better way to detect that the PC is in a
>> signal trampoline?
>
> With recent kernels we should be able to use the dwarf2 unwind
> information in the vdso I think.

I guess compatibility with older kernels will still need to be 
maintained, though.

I see this note in arch/ppc64/mm/fault.c:
         /*
          * N.B. The POWER/Open ABI allows programs to access up to
          * 288 bytes below the stack pointer.
          * The kernel signal delivery code writes up to about 1.5kB
          * below the stack pointer (r1) before decrementing it.
          * The exec code can write slightly over 640kB to the stack
          * before setting the user r1.  Thus we allow the stack to
          * expand to 1MB without further checks.
          */

So would 2KB be a reasonable limit to the signal frame check, as I 
described before?

-- 
Hollis Blanchard
IBM Linux Technology Center
