Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17946.5029.162940.708672@cargo.ozlabs.ibm.com>
Date: Mon, 9 Apr 2007 20:21:25 +1000
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

> True and we are removing a set of indirect branches that exist already
> (debugger). Id prefer not to have 2 sets of duplicate hooks for all this
> stuff.

There are two concerns I have here.  First, using notifiers tends to
obscure what's going on since the notify call goes off and calls some
random set of functions somewhere, and it's not obvious when reading
the code what that set of functions is.  That's fine when there is a
reason why the set of kernel code modules that want to know about the
event needs to be able to be extended at will without impacting the
generator of the event, but that isn't the case with single-step,
breakpoint or page fault.  If there are only two functions to be
called, I'd rather have a couple of explicit calls than use a
notifier.

The other thing is that we seem to be throwing all sorts of unrelated
events into the die_notifier.  The symptom of that is that you have
one set of handlers that are only interested in the debug events, and
another set that are only interested in the events where the machine
really is dying (oops, etc.).  That is, you have two sets of handlers
that are interested in disjoint sets of events.  That says to me that
we shouldn't be using a single notifier for all the events.
Particularly for page faults I really don't see the point of calling
handlers that are only interested in oopses.

Paul.
