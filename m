From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14979.48995.833510.969973@gargle.gargle.HOWL>
Date: Fri, 9 Feb 2001 20:58:59 +1100 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: David Edelsohn <dje@watson.ibm.com>, Cort Dougan <cort@fsmlabs.com>,
        Dan Malek <dan@mvista.com>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <Pine.HPX.4.10.10102090003130.15466-100000@gra-ux1.iram.es>
References: <200102082208.RAA22218@mal-ach.watson.ibm.com>
	<Pine.HPX.4.10.10102090003130.15466-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> I agree with you, but that's only a gut feeling. Did you also notice that
> Linux/PPC only uses half the recommended hash table size unless I'm
> grossly mistaken ?
>
> My feeling is that the hash table should be rather over- than under-sized,
> especially with the amount of sharing there is between all the
> applications running on "modern" desktops (large shared libraries for
> X/KDE/GNOME among other things).

We use a smaller than recommended hash table size for a couple of reasons:

- The hash table occupancy rates measured by Cort were very small,
  typically less than 10% IIRC.

- A bigger hash table takes longer to clear when you have to do a
  flush_tlb_all().   Fortunately there are only a couple of places
  where flush_tlb_all is called, and they can both easily be changed
  to flush_tlb_range.  However, it is still necessary to clear the
  hash table on a MMU context overflow.

- The recommended sizes are based on the idea that you have to try
  quite hard to keep all the active PTEs in the hash table.  We don't,
  we can quickly fault PTEs into the hash table on demand so it is
  less important for us to try to keep all the active PTEs in the hash
  table.

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
