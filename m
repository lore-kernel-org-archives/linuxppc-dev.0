Return-Path: <Hiroshi.DOYU@nokia.com>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D30CB716C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 19:07:13 +1100 (EST)
Date: Mon, 14 Feb 2011 09:32:57 +0200 (EET)
Message-Id: <20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
To: linus.walleij@linaro.org
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
In-Reply-To: <AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
	<AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: meador_inge@mentor.com, Hollis_Blanchard@mentor.com, sunder.svit@gmail.com,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: ext Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
Date: Sun, 13 Feb 2011 22:16:12 +0100

> 2011/2/12 Sundar <sunder.svit@gmail.com>:
> =

>> At least I would like this; I wanted to generalize such mailbox IPCs=

>> right from the day when I was working on one, but coudnt really
>> work on that.
>>
>>> =A0 =A02. Does something like this already exist?
>>
>> Not generic as you say; but apart from the OMAP platforms,
>> you could refer to arch/arm/mach-ux500/prcmu for a mailbox based
>> IPC on the U8500 platform.
> =

> We also have this thing:
> arch/arm/mach-ux500/mbox-db5500.c
> =

> It's another mailbox driver, this one talks to the modem in the
> U5500 (basically a physical transport for the CAIF protocol).
> (For the U8500 I think modem IPC is instead handled with
> a high-speed hardware FIFO, a bit different.)
> =

>>> =A0 =A03. Is someone else already working on this?
>>
>> Not sure of that too :), but I am CCing Linus W, the maintainer
>> of U8500 if he thinks it is a good idea to come up with a mailbox IP=
C
>> framework
> =

> I don't know too much about the subject actually, I've not been
> deeply into any such code. I don't think anyone is working
> on something general from ST-Ericsson or Linaro.
> =

> Recently I saw that Texas Instruments are posting a "hardware
> spinlock" framework though, this would be on a related tone,
> but I think it's for shared data structures (control path) rather
> than buffer passing (data path). I'm guessing this works like
> that one CPU gets to spin waiting for another one to release
> the lock.
> =

> Given that we may have a framework for hardware spinlock
> and that we don't want to stockpile drivers into arch/*
> or drivers/misc/* I would say it's intuitively a good idea,
> but the question is what data types you would pass in?
> In arch/arm/mach-ux500/include/mach/mbox-db5500.h
> we have a struct like this:
> =

> /**
>   * struct mbox - Mailbox instance struct
>   * @list:              Linked list head.
>   * @pdev:              Pointer to device struct.
>   * @cb:                Callback function. Will be called
>   *                     when new data is received.
>   * @client_data:       Clients private data. Will be sent back
>   *                     in the callback function.
>   * @virtbase_peer:     Virtual address for outgoing mailbox.
>   * @virtbase_local:    Virtual address for incoming mailbox.
>   * @buffer:            Then internal queue for outgoing messages.
>   * @name:              Name of this mailbox.
>   * @buffer_available:  Completion variable to achieve "blocking send=
".
>   *                     This variable will be signaled when there is
>   *                     internal buffer space available.
>   * @client_blocked:    To keep track if any client is currently
>   *                     blocked.
>   * @lock:              Spinlock to protect this mailbox instance.
>   * @write_index:       Index in internal buffer to write to.
>   * @read_index:        Index in internal buffer to read from.
>   * @allocated:         Indicates whether this particular mailbox
>   *                     id has been allocated by someone.
>   */
> struct mbox {
>         struct list_head list;
>         struct platform_device *pdev;
>         mbox_recv_cb_t *cb;
>         void *client_data;
>         void __iomem *virtbase_peer;
>         void __iomem *virtbase_local;
>         u32 buffer[MBOX_BUF_SIZE];
>         char name[MBOX_NAME_SIZE];
>         struct completion buffer_available;
>         u8 client_blocked;
>         spinlock_t lock;
>         u8 write_index;
>         u8 read_index;
>         bool allocated;
> };
> =

> Compare OMAPs mailboxes in
> arch/arm/plat-omap/include/plat/mailbox.h:
> =

> typedef u32 mbox_msg_t;
> =

> truct omap_mbox_ops {
>         omap_mbox_type_t        type;
>         int             (*startup)(struct omap_mbox *mbox);
>         void            (*shutdown)(struct omap_mbox *mbox);
>         /* fifo */
>         mbox_msg_t      (*fifo_read)(struct omap_mbox *mbox);
>         void            (*fifo_write)(struct omap_mbox *mbox, mbox_ms=
g_t msg);
>         int             (*fifo_empty)(struct omap_mbox *mbox);
>         int             (*fifo_full)(struct omap_mbox *mbox);
>         /* irq */
>         void            (*enable_irq)(struct omap_mbox *mbox,
>                                                 omap_mbox_irq_t irq);=

>         void            (*disable_irq)(struct omap_mbox *mbox,
>                                                 omap_mbox_irq_t irq);=

>         void            (*ack_irq)(struct omap_mbox *mbox, omap_mbox_=
irq_t irq);
>         int             (*is_irq)(struct omap_mbox *mbox, omap_mbox_i=
rq_t irq);
>         /* ctx */
>         void            (*save_ctx)(struct omap_mbox *mbox);
>         void            (*restore_ctx)(struct omap_mbox *mbox);
> };
> =

> struct omap_mbox_queue {
>         spinlock_t              lock;
>         struct kfifo            fifo;
>         struct work_struct      work;
>         struct tasklet_struct   tasklet;
>         struct omap_mbox        *mbox;
>         bool full;
> };
> =

> struct omap_mbox {
>         char                    *name;
>         unsigned int            irq;
>         struct omap_mbox_queue  *txq, *rxq;
>         struct omap_mbox_ops    *ops;
>         struct device           *dev;
>         void                    *priv;
>         int                     use_count;
>         struct blocking_notifier_head   notifier;
> };
> =

> Some of this may be generalized? I dunno, they look quite
> different but maybe queueing etc can actually be made general
> enough to form a framework.

OMAP mailbox is the interrupt driven 32bit unit H/W FIFO to other
cores.

"struct omap_mbox_ops" was provided mainly to absorb the difference
between OMAP1 and OMAP2+ from H/W POV. So generally the layer could
be:

	-----------------------
	character device driver
	-----------------------
	generic mailbox driver
	-----------------------
	   H/W registration
	-----------------------

In OMAP case, in addition to the above, it could be exceptionally:

	-----------------------
	character device driver
	-----------------------
	generic mailbox driver
	-----------------------
	   H/W registration
	-----------------------
	   OMAP 1  | OMAP2+
	-----------------------

So "character device driver"(interface) and "generic mailbox
driver"(queuing) may be able to abstructed/generalized.
