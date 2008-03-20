Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18401.58564.246569.341133@cargo.ozlabs.ibm.com>
Date: Thu, 20 Mar 2008 15:15:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: unprivileged use of MSR_SE
In-Reply-To: <20080320002407.D911C26F995@magilla.localdomain>
References: <20080320002407.D911C26F995@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> I'd like to clean this up for powerpc too.  If there is no way at all for
> user-mode to set MSR_SE, then it doesn't much matter whether it shows up
> when ptrace reads it--ptrace just needs to ignore attempts to set it.  So
> if there's no reason not to, what I would do is remove MSR_SE from the
> MSR_DEBUGCHANGE mask and make sigreturn always clear MSR_SE.

OK, I found MSR_DEBUGCHANGE, it's in ptrace.c. :)  So it only applies
to attempts to change the MSR of a process using ptrace.  So, what you
want is just to disallow changing MSR via PTRACE_POKEUSR or
equivalent, then?

Paul.
