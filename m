Message-Id: <v04003a00b2c59005ee3f@[205.161.35.44]>
In-Reply-To: <199901151610.QAA16497@snowcrash.cymru.net>
References: <199901150157.MAA01789@tango.anu.edu.au> from "Paul Mackerras"
 at Jan 15, 99 12:57:32 pm
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 15 Jan 1999 20:00:18 -0500
To: Alan Cox <alan@cymru.net>, alan@cymru.net, jskov@cygnus.co.uk,
        cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org,
        Jes.Sorensen@cern.ch, linux-apus@sunsite.auc.dk,
        Paul.Mackerras@cs.anu.edu.au
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map()
 disappearing]
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:10 AM -0500 1/15/99, Alan Cox wrote: [Re: Synchronization [was Re:
The Magic Show: kernel_ma]
>> was that it basically said "an interrupt or another processor might
>> have changed memory, so don't keep values from memory cached in
>> registers".  With wmb() on SMP, this seems to be extended to include
>> "make sure other cpus can see the values we just wrote".  I don't know
>> exactly how rmb() differs from mb().
>
>	rmb()	Do not re-order reads across this point (CPU or compiler)
>	wmb() 	Do not re-order writes across this point (CPU or compiler)
>	mb()	Do not re-order reads or write across this point
>
>
A simple way to force any good C compiler to not save any intermediate values
or pointers in registers and still allow full compiler optimization is as
follows:

1) create a macro to be placed before and after the critical section of code
   that needs to be protected. The macro increments a compiler variable and
   generates a unique label with the incremented number as a suffix.

2) create a second macro that is inserted at the beginning of the main routine
   that has a private volatile integer variable which is initialized to 1 and
   then has a computed goto based on the variable's value where the value of 1
   branches to a label immediately after the goto and the other values of the
   volitile variable branch to the before and after labels from the macro in
   #1 above. The volatile variable is never set to any value other than 1 but
   the compiler cannot optimize the computed goto out of existance because
   the variable is volatile.

3) any compiler that generates proper code will recognize that a branch based
   on a volatile variable prohibits keeping any values in registers at the
   target label(s) that are branched to.


Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
