Date: Thu, 15 Apr 1999 09:05:35 +0200 (MET DST)
From: Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
Reply-To: Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <3715166A.FD1AF78F@wanadoo.fr>
Message-ID: <Pine.OSF.3.94.990415085424.20465D-100000@acaxp6>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-284734640-924159809=:20465"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-284734640-924159809=:20465
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.OSF.3.94.990415085424.20465F@acaxp6>

Hello, LinuxPPC people

Let me give a statement, from the view of a gnuplot developper
who hasn't ever used LinuxPPC:

[...]
> Patch: 
> See below. One just has to split an fprintf command into two.
> It seems that the fprintf in the LinuxPPC libraries does not support
> such long format strings. 

I've had a small look at the patch, and the relevant source code.  If my
knowledge of ANSI regulations for the Standard C library doesn't fail me,
the suspected limitation would constitute an outright bug in fprintf(). 
The only length limit for the *printf() functions allowed by ANSI is that
the output generated (not the format string) can be limited to 509 chars
or so. The gnuplot 3.7 source code doesn't hit that wall, I think, so
fprintf() is not allowed to fail this call. 

Martin: have you tried to boil down the suspected fprintf() problem to a
simpler example case (like a small, complete source code using a long
format string that also crashes)?  If not, the real bug could still be
somewhere else, and fprintf might then just trigger the crash, but not be
the real reason for it.

If ElectricFence or Checker-gcc are available for LinuxPPC, it might be a
good idea to use one of those to see where the problem comes from. 

Hans-Bernhard Broeker (broeker@physik.rwth-aachen.de)
Even if all the snow were burnt, ashes would remain.

--0-284734640-924159809=:20465--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
