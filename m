Date: Wed, 9 May 2001 21:16:34 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: machael thailer <dony.he@huawei.com>
Cc: Freddy Lugo <wilflugo@yahoo.com>, Dan Malek <dan@mvista.com>,
	Michael Habermann <MHabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel...
In-Reply-To: <004501c0d902$f9f7c320$8021690a@huawei.com>
Message-ID: <Pine.LNX.4.21.0105092113130.19507-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael,

Please see comments below..

On Thu, 10 May 2001, machael thailer wrote:

>
> > turn_on_mmu:
> >     .....
> >     SYNC
> >     RFI
>
>
> >I am dealing with same problem.  After the rfi (on
> >turn_on_mmu) instruction an signal is generated and
> >the progam counter is lost.  When performing an rfi
> >most of the bits of the SRR1 registers become the MSR
> >bits and the SRR0 register become the next instruction
> >pointer (NIA).  I read the manual and if the new MSR
> >value enables some pending exceptions then this
> >exceptions are processed by exception priority.  The
> >bits modified after the rfi are MSR_IR & MSR_DR so I
> >think (I am not sure yet) this bits enables a waiting
> >exception of some kind and when the rfi is processed
> >the exception is executed.  gdb only said it recevies
> >a SIGSTOP signal.  I will be working with that today.
> >If I found anything I will let you know.
>
> Now I can "turn_on_mmu" and run "start_here" . I make a mistake when I try
> to debug by outputing a character vi SERIAL Port after "turn_on_mmu".
> The serial port IO is 0xfe0003f8, and the "initial_bats" only do the
> physical address 0~256M to virtual address 0xc0000000~0xc0000000+256M
> memory-mapping. To make the serial port output work, we have to do
> additional memory-mapping from physical address 0xf000000-0xffffffff to
> virtual address 0xf0000000~0xffffffff as following:
>
> initial_bats:
>         ......
>         ......
>        mtspr DBAT0L,r8
>         mtspr DBAT0U,r11
>         mtspr IBAT0L,r8
>         mtspr IBAT0U,r11
>
> /*the start added  lines  */
>         lis r9,0xf000
>         ori    r9,r9,0x1ffe
>         lis r8,0xf000
>         ori r8,r8,0x2a
>         mtspr DBAT1L,r8
>         mtspr DBAT1U,r9
> /*the end added lines*/
>
>         isync
>         blr
>
> Now I meet a new problem. I can run through here:
> start_here:
> ...
> bl identify_machine
> bl MMU_init
> lis r4,2f@h
>  ori r4,r4,2f@l
>  tophys(r4,r4)
>  li r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
>  FIX_SRR1(r3,r5)
>  mtspr SRR0,r4
>  mtspr SRR1,r3
>  SYNC
>  RFI
>
>   /*Here I add my serial output codes, but it outputs nothing. System seems
> to halt here?*/
>
> 2:
>   sync
>   tlbia
>   sync
>
> Do you have any ideas?
> thank you very much.

Note that it is loading the "physical" address of the "2:" label into r4.  What its doing, is its
telling the CPU to turn off MMU (BAT mapping) and then jumping to the "2:" label.  If you add your
serial output after the "2:" label, it should work again.

The next stage would be to make sure MMU_init() in arch/ppc/mm/init.c will set up the right BATs
you need as well (f0000000-0xffffffff), As after all hash tables are modified and such, it will
then write out the new BATs saved in the "BATS" variable from MMU_init(), and then will jump
to start_kernel() after turning MMU on for the last time.

Hope this helps...

Paul W.


>
>
> machael thailer
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
