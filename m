Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
Subject: Re:[PATCH]: Bug in ppc32 ld.so
Date: Fri, 10 May 2002 14:38:33 -0400
Cc: <yellowdog-devel@lists.terrasoftsolutions.com>,
	<linuxppc-dev@lists.linuxppc.org>
References: <200205101305.43423.kevin.hendricks@sympatico.ca> <20020510180647.19812@smtp.wanadoo.fr>
In-Reply-To: <20020510180647.19812@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <200205101438.33701.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

Its seems Geoff Keating and Anton are debating whether this patch should
not be included in glibc and instead the new kernel behavior be reverted
to icache synchronizing zero'd pages handed out by the kernel.

It seems Geoff thinks there may be a security risk in allowing the stale
code in the instruction cache code to be run and some benefit result by a
malicious process (not just library loading obviously).

So people might want to wait on this patch until things get flushed out
(puin intended!).

Either way, I would rather have a ld.so doing the complete icbi cache flush
anyway since it makes me feel safer inside!  I have been bitten by too
many cache flush related errors and I favor great overkill!

The discussion is on the libc-alpha mailing list (just follow the link I
sent and go to followups at the bottom).

Do you know where in the kernel this change was made by Paul  (head.S with
the zero page code? idle.c - with its zero page code during idle, or
misc.S where the cache flush routines are now or ...).  I am trying to
figure out when (what specific 2.4 kernel revision)  this came into.

Thought you might like to know.

Thanks,

Kevin

On May 10, 2002 02:06, Benjamin Herrenschmidt wrote:
> >Hi Anton,
> >
> >I saw:
> >
> >http://sources.redhat.com/ml/libc-alpha/2002-05/msg00052.html
> >
> >Thanks for posting that patch.  Have you by any chance alerted or sent
> >similar mail to YDL dev lists, Debian dev lists, SuSE dev lists, and
> >dev@linuxppc.
> >
> >This would be a nasty bug to track down and those distributions may
> > want to know about this and get an udpated glibc-2.2.5 packages posted
> > on their sites for those brave users who are using later 2.4 kernels?
> >
> >BTW, any idea when this change by Paul was introduced into the 2.4
> > kernel series (specifically which 2.4.XX kernel?).
>
> I submited a debian bug report with Anton message, Olaf (suse) is on
> the linuxppc64 list and had the patch, YDL folks have or will have it
> rsn (thanks to IRC magic ;)
>
> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
