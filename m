From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14777.65296.649836.830091@argo.linuxcare.com.au>
Date: Sat, 9 Sep 2000 20:12:48 +1100 (EST)
To: Tilmann Bitterberg <tibit-ibm@bitterberg.de>
Cc: Linuxppc Development Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_HIGHMEM problems
In-Reply-To: <Pine.LNX.4.21.0009081006530.1436-200000@ford>
References: <Pine.LNX.4.21.0009081006530.1436-200000@ford>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tilmann Bitterberg writes:

> After looking at arch/ppc/mm/init.c:pmac_find_end_of_memory, I
> realized that there is no chance to return a total of more than
> ram_limit (which is in 512MB in my case).

Hmmm, you're right, the ram_limit limit shouldn't be applied if
CONFIG_HIGHMEM is defined.  Your patch looks a bit wrong though, we
need phys_mem.regions[0].size to reflect the total amount of ram we
are going to be using (including high memory).  I haven't had a chance
to test the highmem stuff on a machine that has a lot of memory myself
yet.

> Problem: After freeing all init stuff I get a
> Machine check in kernel mode
> Caused by (from: SRR1=81032) Machine check.
> TRAP 0200
> TASK = co1a5ff0[0] 'swapper'
> Last syscall: 120

Well, we would need to know where the machine check happened,
preferably with a stack trace.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
