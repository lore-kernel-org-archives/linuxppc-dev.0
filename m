Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17269.14127.936147.778781@cargo.ozlabs.ibm.com>
Date: Sat, 12 Nov 2005 11:28:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> This is an attempt to get rid of it all, motivated mostly because I want
> to add two _new_ functions which would need such treatment (pselect,
> ppoll).
> 
> We define a new thread flag TIF_RESTOREALL which is set by the syscall
> which needs this treatment, and make the syscall return path honour it.
> This seems to work as far as I've tested it (i.e. the system boots) for
> ppc64, but I haven't even attempted to compile the 32-bit version yet.

Ummm, I don't see where you save the non-volatile GPRs to the
exception frame _before_ do_signal (called from within *_sigsuspend)
copies them to the user stack...

Paul.
