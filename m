From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14975.55329.292764.981333@tango.linuxcare.com.au>
Date: Tue, 6 Feb 2001 21:55:29 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A6DCBBE.60AB54CE@mvista.com>
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<3A6DCBBE.60AB54CE@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Heh :-)....Right, but it will require a context, and active_mm is
> the proper place to store/retrieve it.  Doesn't the HIGHMEM option
> require we properly use a kernel context?  Or, do we just get lucky
> there, too :-).

The way we do things on 6xx/7xx, kernel accesses to addresses >=
0xc0000000 don't depend on active_mm or on the currently selected
context at all.  We can effectively choose a different context for
each 256MB segment of the address space, and we always choose context
0 for segments 0xc to 0xf.  Further, the hash_page routine looks in
swapper_pg_dir for linux PTEs for addresses >= 0xc0000000, rather than
in the page tables associated with current->active_mm or current->mm.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting Open Source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
