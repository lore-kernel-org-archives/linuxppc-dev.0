Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18012.61822.197988.279764@cargo.ozlabs.ibm.com>
Date: Wed, 30 May 2007 13:37:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
In-Reply-To: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steve Munroe writes:

> But unless you take the time to write it up like a full ABI change you are
> never sure that it IS compatible. And any change to the size/shape of
> ucontext_t is an ABI change.

There is no change to the size or shape of the ucontext_t.  There is
no change to the ABI at all, in the sense that everything that is
currently guaranteed by the ABI is still guaranteed.  An extra
guarantee is added: the top 32 bits of the GPRs will not change
unpredictably as long as you don't call a function and don't use
setcontext or swapcontext to return from a signal handler.

I think actually it would be useful to have the saving/restoring of
the high 32 bits controlled by a prctl, so that programs have to ask
explicitly for the new behaviour (and programs that don't want to use
the high 32 bits don't incur the extra overhead).

Paul.
