From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199907262017.PAA17351@cegt201.bradley.edu>
Subject: Re: Question about getservbyport() -
To: phandel@cise.ufl.edu (Peter Handel)
Date: Mon, 26 Jul 1999 15:17:47 -0500 (CDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.05.9907261430310.24590-100000@eclipse.cise.ufl.edu> from "Peter Handel" at Jul 26, 99 02:33:28 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I noticed yesterday that when getservbyport() receives a request
> containing a port that /etc/services doesn't know about (such as
> 1022), it segfaults the program.  I would have guessed it would return
> a null servent struct?  Here's the code:

Yes, the funcion getservbyport returns a NULL on failure.

> #include <iostream.h>
> #include <netdb.h>
> 
> void main() {
>   struct servent sd;
>   sd=*getservbyport(23, "tcp"); //1022
> }
> 
> This works, but when 23 is replaced by 1022, wham-o.

Yes, that is what this code will do any time it doesn't find a valid
result.  I think you're missing something fundamental here in the
nature of C and pointers.  You shouldn't write your function that
way.  The problem is that when you give it a port that doesn't exist,
you are getting a NULL pointer back, and the first thing your code
tries to do is use it.  You need to save that return value and check
to see if it NULL before you try to use it.  Here's a somewhat cleaned
up version of your code.

void main() {
     struct servent sd, *sp;

     sp = getservbyport(23, "tcp");
     if(sp)
	   sd = *sp;
}

In this way, you prevent crashes by never trying to use the pointer
before you check the validity of your return value.  In fact, you
should do something similar with almost any function that returns
pointers, particularly things like malloc().  This sort of thing
causes so many problems.  I wish everyone would learn to check for
errors on anything that has any chance of generating an error...

	  Brad Boyer
	  flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
