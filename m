To: Dan Malek <dan@netx4.com>,
        LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3936A547.7C34A0BF@lucent.com>
Date: Thu, 01 Jun 2000 12:02:47 -0600
From: Steve Tarr <tarr@lucent.com>
MIME-Version: 1.0
Subject: Re: Motorola MPC8260-ADS Boot hassel
References: <3936790D.9BD7680E@lucent.com> <3936F0F2.DDA90328@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry for the confusion. I am not familiar with the
Linux PANIC messages.

1. NIP 0xC0010D90 is in wake_up_process()

>From System.map:
c0010930 t show_task
c0010b70 T render_sigset_t
c0010c78 T show_state
c0010cec T daemonize
c0010d50 T wake_up_process
c0010ebc T get_dma_list
c0010f30 T request_dma
c0010f9c T free_dma
c0011010 T free_uid
c0011084 T alloc_uid

2. The wake_up_process() is in sched.c

3. Disasembling sched.o gave me a file offset of 0x1dc0 for
wake_up_process(). The failing
   instruction is 0x40 down from the start of wake_up_process().

    1dc0:   94 21 ff d0     stwu    r1,-48(r1)
    1dc4:   7c 08 02 a6     mflr    r0
    1dc8:   bf 81 00 20     stmw    r28,32(r1)
    1dcc:   90 01 00 34     stw r0,52(r1)
    1dd0:   7c 3f 0b 78     mr  r31,r1
    1dd4:   7c 7e 1b 78     mr  r30,r3
    1dd8:   3f a0 00 00     lis r29,0
    1ddc:   3b 9d 00 00     addi    r28,r29,0
    1de0:   81 3c 00 0c     lwz r9,12(r28)
    1de4:   38 7f 00 08     addi    r3,r31,8
    1de8:   7d 28 03 a6     mtlr    r9
    1dec:   4e 80 00 21     blrl
    1df0:   80 1d 00 00     lwz r0,0(r29)
    1df4:   7c 08 03 a6     mtlr    r0
    1df8:   4e 80 00 21     blrl
    1dfc:   38 00 00 00     li  r0,0
 >> 1e00:   81 3e 00 3c     lwz r9,60(r30)
    1e04:   90 1e 00 00     stw r0,0(r30)
    1e08:   2c 09 00 00     cmpwi   r9,0
    1e0c:   40 82 00 f8     bne 1f04 <wake_up_process+0x144>

    Note: r30 is loaded from the paramenter passed in, r3.

4. I made a seemingly foolish assumption that the TRAP: 0300
   was the exception vector. Hence that it was a DSI exception.
   Looking at the register dump shows r30 = 0xc0100000. Hence
   my question.

5. The SUNI-lite is an SDH/ATM framer for the Fiber that uses FCC2. I
mention the
   addresses only in so far as I have done anything about them. Again,
   I am certain the code is fine, I just have a configuration/setup
problem.

cheers --
tarr

Dan Malek wrote:
>
> Steve Tarr wrote:
>
> I haven't tried ramdisks recently......
>
> > RAMDISK: Compressed image found at block 0
> > NIP: C0010D90 XER: 20000000 LR: C0010D8C REGS: c085f260 TRAP: 0300
>
> What function is this (0xc0010d90)?  It is hard to help without some
> basic information like this.
>
> > GPR08: C085E000 C0008540 00000000 C085F358 00000000 FFFFFFFF 00000000
> > 00000400
>
> > Kernel panic: kernel access of bad area pc c0010d90 lr c0010d8c address
> > 3C tsk 1Rebooting in 180 seconds..
> >
> > Based on my simple attempts it appears that I am taking a DSI exception
> > on an access to
> > 0xC010000......
>
> How did you determine this?  The panic message prints the faulting
> address, which happens to be 0x3c.  GPR8, 9, 10, 11, and 12 are typical
> sources for intermediate pointers, two of those are zero.  I would
> guess a NULL pointer to a data structure trying to access the contents
> at offset 0x3c.
>
> > I noticed in System.map that data does not the first data entry.....
>
> Next time notice and tell us the function at NIP....much more useful.
>
> > Note: they put the SUNI-Lite and board registers at
> > 0x04500000-0x04700000.
>
> Who is they, what's a SUNI-Lite, and does it matter?  Best of all,
> if you don't like the address you can change it.
>
> We need more info.
>
>         -- Dan

--
Steven Tarr
Lucent Technologies - Bell Labs
303-538-4056
tarr@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
