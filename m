From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199905192056.PAA21815@cegt201.bradley.edu>
Subject: Re: possible egcs c compiler bug
To: allison@dirac.nist.gov (Thomas C. Allison)
Date: Wed, 19 May 1999 15:56:30 -0500 (CDT)
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199905192019.QAA00884@dirac.nist.gov> from "Thomas C. Allison" at May 19, 99 04:19:17 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have found what *appears* to be a bug in the C compiler.  I have experienced
> this bug in R4 (regardless of the compiler/library installed) as well as in
> the latest (i.e. all the latest packages through 5/15/1999) pre-R5
> installation.  I include a short program below which illustrates the problem
> I am having.  The code compiles without error on my i386 machine
> running RHL 5.2.  The version of EGCS on the PC is 1.0.3 versus 1.1.2 on my
> PowerMac, so I don't know if this is a PPC problem or an EGCS problem.
> Any input is greatly appreciated.

"It's not a bug, it's a feature"...

You're using something that is not technically the proper way to use
va_list in your code.  However, that code works on everything but ppc.
It has to do with the way va_list is implemented on any ppc platform,
and causes all sorts of strange things to happen when you don't follow
the spec close enough.  Find a better way to copy the va_list.  Just
using the = operator isn't enough on ppc.  Use a block copy of
sizeof(va_list) bytes, or some such.  This has come up before, so if
you search the list archives, you should find sample code.  Someone
else could give a lot more details on this.  I only know the general
overview.

      Brad Boyer
      flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
