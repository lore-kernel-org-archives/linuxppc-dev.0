Date: Mon, 26 Jul 1999 14:33:28 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Question about getservbyport() -
Message-ID: <Pine.GSO.4.05.9907261430310.24590-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[r5, stock egcs/glibc]

I noticed yesterday that when getservbyport() receives a request
containing a port that /etc/services doesn't know about (such as
1022), it segfaults the program.  I would have guessed it would return
a null servent struct?  Here's the code:

#include <iostream.h>
#include <netdb.h>

void main() {
  struct servent sd;
  sd=*getservbyport(23, "tcp"); //1022
}

This works, but when 23 is replaced by 1022, wham-o.


Thanks,
Pete

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16
> > You are perfectly free to believe what you want to, and so am I.
> Actually, this turns out not to be the case. God does not give us
> the freedom to believe anything we wish. We are morally obligated to
> believe the truth. Doing anything else is a sin. You are not free to
> interpret the Bible anyway you wish. -DFL (Pretty neat, huh?)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
