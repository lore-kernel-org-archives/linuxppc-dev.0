Date: Sun, 25 Jun 2000 22:29:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_delay_50ms() freezing on PPC?
In-Reply-To: <200006251813.UAA00680@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10006252228210.22378-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay,

Then we need braoder stubs.
Got a suggestion?

On Sun, 25 Jun 2000, Michel Lanners wrote:

> Hi all,
>
> The latest 2.4.0 kernels don't boot on my machine anymore. They just
> freeze in detecting the Promise Ultra66 IDE controller, specifically in
> ide_delay_50ms(). Here is the code:
>
> void ide_delay_50ms (void)
> {
> #ifndef CONFIG_BLK_DEV_IDECS
>         unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
>         while (0 < (signed long)(timeout - jiffies));
> #else
>         __set_current_state(TASK_UNINTERRUPTIBLE);
>         schedule_timeout(HZ/20);
> #endif /* CONFIG_BLK_DEV_IDECS */
> }
>
> CONFIG_BLK_DEV_IDECS is support for PCMCIA IDE devices, which is not
> configured in my kernel. So that function hangs if using the 'manual'
> delay. Everything is OK if I force it to use schedule_timeout(), which
> by the way was always the case until a few kernels ago.
>
> So, why does the 'manual' way hang? (I suppose interrupts are not
> disabled at this point, are they?)
>
> And why can we only use schedule_timeout() if compiling with
> CONFIG_BLK_DEV_IDECS?
>
> Thanks
>
> Michel
>
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
>

Andre Hedrick
The Linux ATA/IDE guy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
