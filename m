From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Vojtech Pavlik <vojtech@suse.cz>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] ignore trackpad/mouse while typing
Date: Mon, 27 Jan 2003 20:16:24 +0100
Cc: Vojtech Pavlik <vojtech@suse.cz>,
	Till Straumann <Till.Straumann@TU-Berlin.de>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
References: <3DE6C428.5000403@TU-Berlin.de> <1043529955.3683.41.camel@zion.wanadoo.fr> <20030125222902.A18919@ucw.cz>
In-Reply-To: <20030125222902.A18919@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200301272016.25024@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday 25 January 2003 22:29, Vojtech Pavlik wrote:
> On Sat, Jan 25, 2003 at 10:25:56PM +0100, Benjamin Herrenschmidt wrote:
> > > > > Well... the problem happpens in console as well, and with other
> > > > > non-X apps like MacOnLinux. Some Apple PowerBooks have
> > > > > over-sensitive trackpad. Apple themselves implement a similar
> > > > > mecanism in the kernel driver of OS X.
> > > >
> > > >   Mine is one of those machines.  I have to turn off gpm for sure,
> > > > and X is quite oversensitive too (tuned it in KDE, but still this
> > > > functionality would be very nice).
> > >
> > > How about implementing it in mousedev.c?
> >
> > Right, though it would need hooks in kbddev or something to know
> > about keystrokes.
>
> It could accept keyboards as an event source for this purpose. I'd like
> to keep this out of the input core.

Hmm, this reminds me of one feature I would need in the input core to support
1-button mices in userspace (or at least in a totally self-contained module),
namely the ability to register "filters" that are called early in
input_event() and where a return value !=0 lets it return immediately from
input_event() without processing the event.

Eg. something along these lines:

	ret = 0;
        list_for_each_entry(filter, &dev->f_list, d_node)
                if (filter->open)
                        ret |= filter->handler->event(handle, type, code,
value);
	if (ret) return;

Comments?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
