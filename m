Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17924.38960.570648.271691@cargo.ozlabs.ibm.com>
Date: Sat, 24 Mar 2007 14:17:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
In-Reply-To: <20070323140929.GA17198@kryten>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
	<17923.46762.363994.307295@cargo.ozlabs.ibm.com>
	<20070323140929.GA17198@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard writes:

> Keep reading :) Later on I remove all the debugger() indirect branches.

Well, you replace one indirect branch with another.  I'm not sure how
that is any better.

> Keep in mind with xmon and kprobes disabled these calls are fast. I
> verified it in sim after Christophs 300 cycle rant, a pessimistic
> estimate is 20 cycles on power5, including function call overhead.

With xmon disabled the debugger() call is already fast.  Generally I
see notifiers as being useful when you have some event, or some group
of events, where you can imagine lots of different software modules
(e.g. random device drivers) being interested in it.  I don't see that
that is the case with any of the kprobes notifiers.

Also I don't see any real point to forcing these disparate things to
go through the one notify_die() interface, with the consequent
demultiplexing that you then have to do in the receiving function.

Paul.
