Date: Mon, 8 Apr 2002 21:52:00 -0400
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: dmasound audio patch
Message-Id: <20020408215200.66aedba3.billfink@mindspring.com>
In-Reply-To: <20020408184524.14156@smtp.wanadoo.fr>
References: <20020408152350.5fe654da.billfink@mindspring.com>
	<20020408184524.14156@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Benjamin Herrenschmidt wrote:

> >I halfway understand the reasoning but I don't really agree with it.
> >I don't see any significant problem with doing the byte swapping in
> >the kernel.  From an engineering standpoint, it seems to make more
> >sense to me to do this common function once in the kernel driver rather
> >than redoing it over and over in every audio app, and keep getting bit
> >by the same endianness problem over and over again.  Linus and the PC
> >world don't have to worry about it, but us PPC types keep getting a
> >delay in usable audio apps as a result.
> >
> >Oh well, I know I'm tilting at windmills here.  :-)
>
> No, here you are hitting the lack of proper audio architecture
> in linux ;)
>
> It's not the kernel work, definitely, to do any munging on samples
> even if it is as simple as byteswap. It's the role of a userland
> based process to do mixing & format conversion. I hope alsa will
> finally provide something around those lines.

I don't know that much about ALSA.  Are you basically saying that all
audio apps should use a common userland library interface that handles
all the gory details of audio reformatting, so that the apps themselves
can be blithely ignorant of what's going on under the covers.  If so,
I could agree with that.  I just want a common interface, so every audio
app doesn't have to reinvent the wheel, and all the users don't have to
be bit by the same kinds of bugs over and over again.

I understand that ALSA is now available for PPC.  I'll have to take a
closer look at it when I get a chance.  When do you think ALSA will be
an integral part of the stable kernel?

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
