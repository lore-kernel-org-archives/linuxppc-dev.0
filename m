From: jlquinn@us.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <852568D6.006ADE94.00@D51MTA03.pok.ibm.com>
Date: Fri, 5 May 2000 15:27:21 -0400
Subject: Help with cross-endian bitfields?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all.  I'm working on getting the Advansys driver working and what
appears to be the final stumbling block is a difference in the layout of
bitfields between little-endian and big-endian systems.  In particular,
there are structs like the following:

struct blah {
  uchar a : 3;
  uchar b : 3;
  uchar c : 2;
}

On a little endian machine, this works like I expect.  (blah & 0x07) ==
blah.a is true.  On linuxppc (and apparently MacOS as well), this is NOT
true.  blah.a refers to the 3 most significant bits.  The linuxppc behavior
seems counterintuitive to me because I expected each successive member in a
struct to be the next physical piece of data I encounter.

Can someone tell me what's going on here?  Am I going to have to have
ifdef's on these structs, or resort to mask macros, or is there a
reasonable solution here.

Thanks,
Jerry Quinn

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
