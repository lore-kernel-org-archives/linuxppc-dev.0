Date: Fri, 18 Jun 2004 12:20:44 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
Message-ID: <20040618102044.GA32161@pegasos>
References: <40CDC05B.9020708@bplan-gmbh.de> <1087241757.5996.3.camel@localhost.localdomain> <20040617173454.GA5971@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040617173454.GA5971@pegasos>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 17, 2004 at 07:34:54PM +0200, Sven Luther wrote:
> On Mon, Jun 14, 2004 at 08:38:52PM +0100, Alan Cox wrote:
> > On Llu, 2004-06-14 at 16:12, Nicolas DET wrote:
> > > Also, we replace spin_lock_irqxxx/spin_unlock_irq by spin_lock/unlock
> > > (for SMP/PREEMPT kernel) + stop/start_interrupt.
> >
> > This requires a lot of care to do right. Remember that on PC systems
> > interrupts can be substantially posted. A "stop_interrupt" may prevent
> > IRQ issue but if an IRQ is already on the PC APIC bus it will kill you
> > later on because the IRQ delivery and PCI bus access on the PC class
> > machines are totally asynchronous
>
> And what about the other part of the patch ? The one about the
> alignement of the buffer descriptors ? Does it seem sound, should we
> ward it with ppc specific stuff ? Is it fit to be included in the main
> kernel ?

Mmm, it seems that inversing the remove_list and the list also makes the
problem go away, or at least be less important, in :

struct uhci_td {
        /* Hardware fields */
        __u32 link;
        __u32 status;
        __u32 token;
        __u32 buffer;

        /* Software fields */
        dma_addr_t dma_handle;

        struct usb_device *dev;
        struct urb *urb;

        struct list_head list;          /* P: urb->lock */
        struct list_head remove_list;   /* P: uhci->td_remove_list_lock */

        int frame;                      /* for iso: what frame? */
        struct list_head fl_list;       /* P: uhci->frame_list_lock */
} __attribute__((aligned(16)));

Could it be possible that the warning in :

/*
 * The documentation says "4 words for hardware, 4 words for software".
 *
 * That's silly, the hardware doesn't care. The hardware only cares that
 * the hardware words are 16-byte aligned, and we can have any amount of
 * sw space after the TD entry as far as I can tell.

be still important, at least on G4 powerpc ? remove_list is the 5th
software word here. Strange, because supposedly it works on x86 and
other uhci using arches, and it works on the G3, but not on the G4.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
