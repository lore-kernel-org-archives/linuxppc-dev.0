Date: Fri, 4 Jun 1999 14:31:03 +1000
Message-Id: <199906040431.OAA00904@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: patrik@ucolick.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.GSO.4.03.9906032056170.28081-100000@isis.ucolick.org>
	(message from Patrik Jonsson on Thu, 3 Jun 1999 21:01:03 -0700 (PDT))
Subject: Re: Problem with linux/in.h
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.GSO.4.03.9906032056170.28081-100000@isis.ucolick.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Patrik Jonsson <patrik@ucolick.org> wrote:

> When I try to compile code that uses networking (I tried ssh and freeciv) 
> I get this error:

Are you using R4 (i.e. glibc-1.99) or R5 (i.e. glibc-2.1)?  If you are
using glibc-1.99, I recommend you change the definition of __GLIBC__
in /usr/include/features.h to say

#define __GLIBC__ 1

rather than 2.  The problem is that some of the kernel include files
omit some definitions if __GLIBC__ == 2, since glibc-2.1 likes to
define things that should really be left to the kernel headers (IMHO).

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
