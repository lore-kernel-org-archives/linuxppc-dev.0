From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14784.22458.21233.588776@argo.linuxcare.com.au>
Date: Thu, 14 Sep 2000 15:44:42 +1100 (EST)
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <200009131951.VAA00816@piglet.grunz.lu>
References: <200009122018.WAA00786@piglet.grunz.lu>
	<200009131951.VAA00816@piglet.grunz.lu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> > - if not, would it be a good idea to enable it by default?
>
> What do you think, Paul, Cort?

As I recall, it was necessary to disable the cache in the idle task so
that the idle task's clearing of pages didn't trash the cache for
other tasks.  This introduces its own set of complexities, for example
you have to make sure the cache is reenabled on all exception entries
and also before you call schedule in the idle task.  You also have to
make sure that you don't get any inconsistencies in the cache, which
means you would have to flush the cache for the page before starting
to clear it with the cache disabled.

It would be cleaner to have the page mapped with a non-cacheable
mapping while the idle task is clearing it but you still have to be
careful about cache inconsistencies, particularly if the page is
mapped twice and one mapping is cacheable and the other isn't.

I'm not sure that the current code still addresses all those issues
correctly and completely.  Unused things tend to be subject to
bitrot. :-)

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
