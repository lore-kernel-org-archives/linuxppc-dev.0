Date: Wed, 5 Dec 2001 10:37:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
Message-ID: <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net>
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <3C0E48D2.6000409@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C0E48D2.6000409@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 05, 2001 at 10:18:26AM -0600, Corey Minyard wrote:
>
> Franz Sirl wrote:
>
> >
> >I've done
> >
> >-#define RELOC(x)       (*PTRRELOC(&(x)))
> >+#define RELOC(x)       (*({ typeof(x) * __ptr  = PTRRELOC(&(x));
> >__asm__ ("" : "=r" (__ptr) : "0" (__ptr)); __ptr;}))
> >
> >a while ago in
> ><http://source.mvista.com/pipermail/linuxppc-commit/2001-September/000729.html>,
> >seems nobody applied it so far.
>
> Ok.  It needs to be propped.

I think the reason this wasn't applied is that Paul said something about
thiws being horriyingly ugly.  Corey, can you post a patch that changes
RELOC(x) into a function and nothing else? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
