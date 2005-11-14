Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17272.5610.562107.359574@cargo.ozlabs.ibm.com>
Date: Mon, 14 Nov 2005 15:43:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1131883101.27347.233.camel@baythorne.infradead.org>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
	<1131874887.27347.221.camel@baythorne.infradead.org>
	<17271.4290.486710.929502@cargo.ozlabs.ibm.com>
	<1131883101.27347.233.camel@baythorne.infradead.org>
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

> But I think other things you mention are OK -- we'd still call
> do_signal() from *sigsuspend() just as we do at the moment, with the
> same loop. It's just that do_signal() would notice that the nvgprs
> aren't saved, and would set the TIF_SAVENVPGRS_TO_SIG_FRAME bit. ..

Ah ok, I see now, that sounds all right.

> (Actually in the case of swapcontext() we don't know that the nvgprs
> should be saved in a signal frame at the top of the userspace stack; the
> context will be elsewhere. We probably do need to store a pointer in the
> thread_info, but that's OK too)

True.

Paul.
