From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14828.59472.822072.622235@argo.linuxcare.com.au>
Date: Wed, 18 Oct 2000 11:01:20 +1100 (EST)
To: minyard@acm.org
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Allowing signal handlers to modify SE and BE
In-Reply-To: <m2lmvoqimb.fsf@c469597-a.grlnd1.tx.home.com>
References: <m2lmvoqimb.fsf@c469597-a.grlnd1.tx.home.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Corey Minyard writes:

> I noticed the following in signal.c:
>
> /*
>  * These are the flags in the MSR that the user is allowed to change
>  * by modifying the saved value of the MSR on the stack.  SE and BE
>  * should not be in this list since gdb may want to change these.  I.e,
>  * you should be able to step out of a signal handler to see what
>  * instruction executes next after the signal handler completes.
>  * Alternately, if you stepped into a signal handler, you should be
>  * able to continue 'til the next breakpoint from within the signal
>  * handler, even if the handler returns.
>  */
> #define MSR_USERCHANGE	(MSR_FE0 | MSR_FE1)

This came from Kevin Buettner in July 1997 when he was hacking on gdb
to get it working properly under ppc/linux.  I don't know if Kevin is
still around or who the current maintainer of gdb on ppc/linux is.  We
can change this definition if you can get an ack from someone who
knows that it won't break gdb.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
