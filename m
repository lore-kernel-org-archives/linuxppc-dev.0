Date: Thu, 3 Jun 1999 21:01:03 -0700 (PDT)
From: Patrik Jonsson <patrik@ucolick.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with linux/in.h
In-Reply-To: <Pine.LNX.4.05.9906032255040.642-100000@pc.wackyland.com>
Message-ID: <Pine.GSO.4.03.9906032056170.28081-100000@isis.ucolick.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
When I try to compile code that uses networking (I tried ssh and freeciv) 
I get this error:

In file included from /usr/include/netinet/in.h:27,
                 from packets.c:19:
/usr/include/linux/in.h:109: parse error before `sa_family_t'
/usr/include/linux/in.h:109: warning: no semicolon at end of struct or
union
/usr/include/linux/in.h:116: parse error before `}'

The offending part of in.h is:

struct sockaddr_in {
  sa_family_t		sin_family;	/* Address family		*/
  unsigned short int	sin_port;	/* Port number			*/
  struct in_addr	sin_addr;	/* Internet address		*/

  /* Pad to size of `struct sockaddr'. */
  unsigned char		__pad[__SOCK_SIZE__ - sizeof(short int) -
			sizeof(unsigned short int) - sizeof(struct
in_addr)];
};

The problem seems to be that sa_family_t is never defined. Anyone got an
idea what's going on? This is with the 2.3.4 cvs sources.

Thanks,

	/Patrik



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
