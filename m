Message-ID: <369927C8.693A3A43@pop.agri.ch>
Date: Sun, 10 Jan 1999 23:20:57 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: linux-pmac@samba.anu.edu.au,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: [Fwd: header confusions 2.1.24vs. 2.1.131]
Content-Type: multipart/mixed; boundary="------------CF9BDBC8C5CE4E58B5969D39"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------CF9BDBC8C5CE4E58B5969D39
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Well in the meantime I found that this proplem is not unusual..
Can any body help??

See on the archive search fd_set!!

Thanks to  everybody

Andreas
--------------CF9BDBC8C5CE4E58B5969D39
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-pmac@samba.anu.edu.au>
Received: from kong.bstc.net (kong.bstc.net [207.239.221.11])
	by ief.ch (8.9.1/8.9.1) with SMTP id LAA27013
	for <a.tobler@schweiz.ch>; Sun, 10 Jan 1999 11:31:00 GMT
Received: (qmail 18080 invoked from network); 10 Jan 1999 12:41:01 -0000
Received: from samba.anu.edu.au (150.203.164.44)
  by kong.bstc.net with SMTP; 10 Jan 1999 12:41:01 -0000
Received: from localhost ([127.0.0.1]:27223 "HELO" ident: "NO-IDENT-SERVICE[2]") by samba.anu.edu.au with SMTP id <12674785-2991>; Sun, 10 Jan 1999 22:30:35 +1100
Message-Id: <36988FF6.A4E4AB1B@pop.agri.ch>
Errors-To: listproc-errors@samba.anu.edu.au
Reply-To: toa@pop.agri.ch
Originator: linux-pmac@samba.anu.edu.au
Sender: linux-pmac@samba.anu.edu.au
Precedence: bulk
From: Andreas Tobler <toa@pop.agri.ch>
To: Multiple recipients of list <linux-pmac@samba.anu.edu.au>
Subject: header confusions 2.1.24vs. 2.1.131
X-Listprocessor-Version: 6.0c -- ListProcessor by Anastasios Kotsikonas
X-URL: http://samba.anu.edu.au/listproc
X-Comment: Discussion of native Linux on PCI Powermacs
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
X-Mailer: Mozilla 4.07 (Macintosh; I; PPC)
Date: Sun, 10 Jan 1999 22:30:35 +1100
X-Censor-LoC: -1
Content-Transfer-Encoding: 7bit

Hello,

it comes again, I didn't found a clear solution about my problem. Only a dirty hack.

I tried to compile the ACE package from: www.cs.wustl.edu/~schmidt/ACE.html.
Under R4 I managed it also now under pre-5, but I'm not happy with the solution.
The problem has to do with the 'fb_set' struct and its member fds_bits. The
definition of it is in the select.h/ types.h. In R4 there is a definition of
the struct in <linux/posix_types.h>
like this:

"typedef struct fd_set {
"			unsigned long fds_bits [__FDSET_LONGS];
"} __kernel_fd_set;

in pre-R5 it looks like this (also in <linux/posix_types.h>) :

"typedef struct {  // without the fd_set!!
"			unsigned long fds_bits [__FDSET_LONGS];
"} __kernel_fd_set;

Changing the pre-5 definition in the R4 definition doesn't help.

When I compile it under pre-5 with the latest egcs 1.1.1.c, I get an error
which complains about fds_bits is not member of the struct fd_set.
A look at the corresponding code line shows me, that a operation on fds_bits
is done.

Modifying this fds_bits into __fds_bits in code works, the compiler is
satiesfied. (If the code really works is another question.) 

My question, what is going wrong and why do the locations and definitions of
the header files change from 2.1.24 to 2.1.131?


Any hints are welcome

Thanks
Andreas

--------------CF9BDBC8C5CE4E58B5969D39--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
