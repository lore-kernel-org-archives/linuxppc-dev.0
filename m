Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020129142321.38639.qmail@web9706.mail.yahoo.com>
Date: Tue, 29 Jan 2002 06:23:21 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: [Linux-ATM-General] Re: ATM driver for 8260 (linux 2.4.x)
To: Der Herr Hofrat <der.herr@mail.hofr.at>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200201291247.g0TClwl07353@hofr.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Mr Hofrat is right!
For some reason the interrupt handler reads old
values, although the CPM puts new data. (I checked it
using JTAG). It seems
like the old data are kept on buffers and are not
refreshed. Unfortunetely i did what Hofrat saied,
but it doesn't work. Is there a function for forcing
refresh? flush_tlb or flush_dcache perhaps?

                     Thanks!
                       D. Meidanis

--- Der Herr Hofrat <der.herr@mail.hofr.at> wrote:
> >
> >   But until you do it, could you help me in one
> > problem
> > that i have? I have imported the mpc860sar driver
> > myself. But i have this problem. When i use the
> aread
> > program, i seem to take the data ok. But if from
> the
> > transmit computer i send quick the data, the CPM
> seems
> > to
> > jump positions in the Interrupt Queue. I mean that
> my
> > pointer (SW) increases correct, but the CPM
> increases
> > without putting an interrupt entry. Any ideas?
> > Also, in the original driver Alex used the
> > mm_alloc_uncached_pages function, but i have
> replased
> > it with kmalloc(size, GFP_KERNEL). Is it correct?
> >
> I don't know about the details of your setup - but
> we had similar phenomenon with
> a driver on the CPM that acknowledged the interrupt
> too late - the therapy
> was to move the interrupt ack to the top of the
> driver and all was well.
>
> so maby you are seeing the same problem due to the
> same driver coding error .
>
> hofrat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
