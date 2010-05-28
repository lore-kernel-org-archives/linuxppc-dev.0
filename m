Return-Path: <paulus@ozlabs.org>
Date: Fri, 28 May 2010 12:05:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
Message-ID: <20100528020556.GA10586@brick.ozlabs.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100527141203.GA20770@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 27, 2010 at 07:42:03PM +0530, Ananth N Mavinakayanahalli wrote:

> While we are at it, can we also add nop to the list of emulated
> instructions?

I have a patch in development that emulates most of the arithmetic,
logical and shift/rotate instructions, including ori.

While you're here (in a virtual sense at least :), could you explain
what's going on with the emulate_step() call in resume_execution() in
arch/powerpc/kernel/kprobes.c?  It looks like, having decided that
emulate_step() can't handle the instruction, you single-step the
instruction out of line and then call emulate_step again on the same
instruction, in resume_execution().  Why on earth is it trying to
emulate the instruction when it has already been executed at this
point?  Is there any reason why we can't just remove the emulate_step
call from resume_execution()?

Paul.
