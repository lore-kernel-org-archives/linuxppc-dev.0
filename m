From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14977.60657.871016.955014@diego.linuxcare.com.au>
Date: Thu, 8 Feb 2001 11:48:49 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A818DAE.3182B163@mvista.com>
References: <3A6CCBDC.3D7B722A@mvista.com>
	<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<14975.55035.835724.234984@tango.linuxcare.com.au>
	<3A806D89.16B31EA0@mvista.com>
	<14976.30150.97137.755604@tango.linuxcare.com.au>
	<3A808560.6FF96E3C@mvista.com>
	<14976.38302.725479.486320@diego.linuxcare.com.au>
	<3A818DAE.3182B163@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> I don't yet have a proposal, and in retrospect it does seem the
> discussion started on a negative tone.  I'm thinking about flying

Well, it did start with a remark of yours about our "mostly incorrect
use of the MMU". :)

I think that it is seductive but misleading when the PPC docs say that
the PPC supports a "large virtual address space".  Yes it does, in a
sense, but it's not one that you can access directly on a 32-bit PPC;
you have to go changing segment registers to get at all of it - i.e.,
there's no such thing as a pointer into this space that the CPU
understands natively.  You could have such a pointer as a 64-bit
value, but to use it you have to split it apart and put one part in a
segment register and make a pointer that the CPU understands out of
the other part.  And the other thing is that there just aren't enough
segment registers on 32-bit PPCs to be really useful (except as a way
of coarsely partitioning the address space).

And of course when you go to a 64-bit PPC all of those sort of
problems go away; you just have 64-bit pointers and set up your
logical -> physical translation however you want, and you can then
basically ignore the MMU's "virtual" address space except as something
internal to the translation process that only really affects what
values you have to put in the segment and hash tables.

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting open source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
