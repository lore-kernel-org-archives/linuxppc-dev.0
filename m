Return-Path: <linus.ml.walleij@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09A3DB7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 08:16:16 +1100 (EST)
Received: by pzk34 with SMTP id 34so943583pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Feb 2011 13:16:13 -0800 (PST)
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
References: <4D55A7F7.5090700@mentor.com>
	<AANLkTikP0P9S1VgiU_yT53f-kZq0JMLBJoVWigAy8YWB@mail.gmail.com>
Date: Sun, 13 Feb 2011 22:16:12 +0100
Message-ID: <AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: Sundar <sunder.svit@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Meador Inge <meador_inge@mentor.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
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

2011/2/12 Sundar <sunder.svit@gmail.com>:

> At least I would like this; I wanted to generalize such mailbox IPCs
> right from the day when I was working on one, but coudnt really
> work on that.
>
>> =A0 =A02. Does something like this already exist?
>
> Not generic as you say; but apart from the OMAP platforms,
> you could refer to arch/arm/mach-ux500/prcmu for a mailbox based
> IPC on the U8500 platform.

We also have this thing:
arch/arm/mach-ux500/mbox-db5500.c

It's another mailbox driver, this one talks to the modem in the
U5500 (basically a physical transport for the CAIF protocol).
(For the U8500 I think modem IPC is instead handled with
a high-speed hardware FIFO, a bit different.)

>> =A0 =A03. Is someone else already working on this?
>
> Not sure of that too :), but I am CCing Linus W, the maintainer
> of U8500 if he thinks it is a good idea to come up with a mailbox IPC
> framework

I don't know too much about the subject actually, I've not been
deeply into any such code. I don't think anyone is working
on something general from ST-Ericsson or Linaro.

Recently I saw that Texas Instruments are posting a "hardware
spinlock" framework though, this would be on a related tone,
but I think it's for shared data structures (control path) rather
than buffer passing (data path). I'm guessing this works like
that one CPU gets to spin waiting for another one to release
the lock.

Given that we may have a framework for hardware spinlock
and that we don't want to stockpile drivers into arch/*
or drivers/misc/* I would say it's intuitively a good idea,
but the question is what data types you would pass in?
In arch/arm/mach-ux500/include/mach/mbox-db5500.h
we have a struct like this:

/**
  * struct mbox - Mailbox instance struct
  * @list:              Linked list head.
  * @pdev:              Pointer to device struct.
  * @cb:                Callback function. Will be called
  *                     when new data is received.
  * @client_data:       Clients private data. Will be sent back
  *                     in the callback function.
  * @virtbase_peer:     Virtual address for outgoing mailbox.
  * @virtbase_local:    Virtual address for incoming mailbox.
  * @buffer:            Then internal queue for outgoing messages.
  * @name:              Name of this mailbox.
  * @buffer_available:  Completion variable to achieve "blocking send".
  *                     This variable will be signaled when there is
  *                     internal buffer space available.
  * @client_blocked:    To keep track if any client is currently
  *                     blocked.
  * @lock:              Spinlock to protect this mailbox instance.
  * @write_index:       Index in internal buffer to write to.
  * @read_index:        Index in internal buffer to read from.
  * @allocated:         Indicates whether this particular mailbox
  *                     id has been allocated by someone.
  */
struct mbox {
        struct list_head list;
        struct platform_device *pdev;
        mbox_recv_cb_t *cb;
        void *client_data;
        void __iomem *virtbase_peer;
        void __iomem *virtbase_local;
        u32 buffer[MBOX_BUF_SIZE];
        char name[MBOX_NAME_SIZE];
        struct completion buffer_available;
        u8 client_blocked;
        spinlock_t lock;
        u8 write_index;
        u8 read_index;
        bool allocated;
};

Compare OMAPs mailboxes in
arch/arm/plat-omap/include/plat/mailbox.h:

typedef u32 mbox_msg_t;

truct omap_mbox_ops {
        omap_mbox_type_t        type;
        int             (*startup)(struct omap_mbox *mbox);
        void            (*shutdown)(struct omap_mbox *mbox);
        /* fifo */
        mbox_msg_t      (*fifo_read)(struct omap_mbox *mbox);
        void            (*fifo_write)(struct omap_mbox *mbox, mbox_msg_t ms=
g);
        int             (*fifo_empty)(struct omap_mbox *mbox);
        int             (*fifo_full)(struct omap_mbox *mbox);
        /* irq */
        void            (*enable_irq)(struct omap_mbox *mbox,
                                                omap_mbox_irq_t irq);
        void            (*disable_irq)(struct omap_mbox *mbox,
                                                omap_mbox_irq_t irq);
        void            (*ack_irq)(struct omap_mbox *mbox, omap_mbox_irq_t =
irq);
        int             (*is_irq)(struct omap_mbox *mbox, omap_mbox_irq_t i=
rq);
        /* ctx */
        void            (*save_ctx)(struct omap_mbox *mbox);
        void            (*restore_ctx)(struct omap_mbox *mbox);
};

struct omap_mbox_queue {
        spinlock_t              lock;
        struct kfifo            fifo;
        struct work_struct      work;
        struct tasklet_struct   tasklet;
        struct omap_mbox        *mbox;
        bool full;
};

struct omap_mbox {
        char                    *name;
        unsigned int            irq;
        struct omap_mbox_queue  *txq, *rxq;
        struct omap_mbox_ops    *ops;
        struct device           *dev;
        void                    *priv;
        int                     use_count;
        struct blocking_notifier_head   notifier;
};

Some of this may be generalized? I dunno, they look quite
different but maybe queueing etc can actually be made general
enough to form a framework.

Yours,
Linus Walleij
