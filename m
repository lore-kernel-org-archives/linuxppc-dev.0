From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14801.33926.732061.909418@argo.linuxcare.com.au>
Date: Wed, 27 Sep 2000 16:24:22 +1100 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <Pine.HPX.4.10.10009261219380.24143-100000@gra-ux1.iram.es>
References: <14784.22458.21233.588776@argo.linuxcare.com.au>
	<Pine.HPX.4.10.10009261219380.24143-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> On Thu, 14 Sep 2000, Paul Mackerras wrote:
> > As I recall, it was necessary to disable the cache in the idle task so
> > that the idle task's clearing of pages didn't trash the cache for
> > other tasks.
>
> why ? When you are sleeping, the next task to run may or may not be the
> same.
>
> If it is the same, you loose, but any task sleeping should not expect
> the caches to be hot when it restarts....

Cort did the measurements, I don't recall the actual numbers myself.
I think that what was happening was that the idle task would run
e.g. during a disk read and the net effect with things like a kernel
compile was that it ran slower overall when the idle task was clearing
pages with the cache enabled.  Cort's solution was to disable the
cache entirely while the idle task was running.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
