Message-ID: <3D091C9F.134A8A0C@mvista.com>
Date: Thu, 13 Jun 2002 15:28:47 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing the user stack inside system call service routine
References: <3D084D1F.95AFFCBB@icn.siemens.de>
		<3D087D95.5070206@lvl7.com>
		<3D08AA25.9AF41113@icn.siemens.de> <15625.4799.671581.186354@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Steffen Rumler writes:
>
> > The copy_from_user() works fine. The printk() message does not
> > appear.
>
> The copy_from_user call looks correct to me.
>
> > Later, when I inspect 'current->user_stack_xxx' (temporary
> > added to struct_task) for all processes with 'current->in_suspend'
> > set, all seems to be zero. I do this check within a kernel
> > module, I can load when the threads are hanging.
>
> That is indeed very strange.  The first word should be non-zero at the
> very least.  Is it possible that your program has in fact trashed its
> stack?  Another thing to try would be to check the contents of
> current->user_stack_xxx immediately after you copy it to see whether
> it is all zero at that point.

Here is how the Linux Trace Toolkit (LTT) kernel patch searches back
through the stack, in the case of a syscall, to find the caller of
the library function that resulted in a syscall (for example, the
place that printf() was called from, not the place that the resulting
syscall was called from in the library).  It sounds like you don't
need to dig that far back in the calling sequence.  Hopefully this example
can point you in the right direction.



#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
asmlinkage void trace_real_syscall_entry(struct pt_regs * regs)
{
        int                 use_depth;
        int                 use_bounds;
        int                 depth = 0;
        int                 seek_depth;
        unsigned long       lower_bound;
        unsigned long       upper_bound;
        unsigned long       addr;
        unsigned long*      stack;
        trace_syscall_entry trace_syscall_event;

        /* Set the syscall ID */
        trace_syscall_event.syscall_id = (uint8_t) regs->gpr[0];

        /* Set the address in any case */
        trace_syscall_event.address  = instruction_pointer(regs);

        /* Are we in the kernel (This is a kernel thread)? */
        if(!user_mode(regs))
          /* Don't go digining anywhere */
          goto trace_syscall_end;

        /* Get the trace configuration */
        if(trace_get_config(&use_depth,
                            &use_bounds,
                            &seek_depth,
                            (void*)&lower_bound,
                            (void*)&upper_bound) < 0)
          goto trace_syscall_end;

        /* Do we have to search for an eip address range */
        if((use_depth == 1) || (use_bounds == 1))
          {
          /* Start at the top of the stack (bottom address since stacks grow downward) */
          stack = (unsigned long*) regs->gpr[1];

          /* Skip over first stack frame as the return address isn't valid */
          if(get_user(addr, stack))
            goto trace_syscall_end;
          stack = (unsigned long*) addr;

          /* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
          while(!get_user(addr, stack + 1)) /* "stack + 1", since this is where the IP is */
            {
            /* Does this LOOK LIKE an address in the program */
            if((addr > current->mm->start_code)
             &&(addr < current->mm->end_code))
              {
              /* Does this address fit the description */
              if(((use_depth == 1) && (depth == seek_depth))
               ||((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound)))
                {
                /* Set the address */
                trace_syscall_event.address = addr;

                /* We're done */
                goto trace_syscall_end;
                }
              else
                /* We're one depth more */
                depth++;
              }
            /* Go on to the next address */
            if(get_user(addr, stack))
              goto trace_syscall_end;
            stack = (unsigned long*) addr;
            }
          }

trace_syscall_end:
        /* Trace the event */
        trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
}





-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
