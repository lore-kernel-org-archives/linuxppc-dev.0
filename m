Date: Fri, 2 Mar 2001 10:29:48 +0000 (GMT)
From: Stephen Turner <S.R.E.Turner@statslab.cam.ac.uk>
Reply-To: Stephen Turner <sret1@cam.ac.uk>
To: 86356@bugs.debian.org
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	Andrew Sharp <andy@netfall.com>, "Marco d'Itri" <md@Linux.IT>,
	Michel Lanners <mlan@cpu.lu>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug#86356: analog: analog segfaults
In-Reply-To: <01022318305301.06077@localhost>
Message-ID: <Pine.LNX.3.96.1010302101639.19312B-100000@gamma.statslab.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This turns out to be a bug in gcc, not analog. On ppc, gcc 2.95.2 seems to
have alignment problems when a function is passed certain long lists of
arguments including doubles. But apparently the bug is fixed in the (not yet
released) 2.95.3 version of gcc.

Thanks to Kevin Hendricks for diagnosing this problem and for testing it on
his machine.

The following short program will test whether your gcc has this problem:
====================================
#include <stdio.h>

void f(int b0, int b1, int b2, int b3, int b4, int b5,
       double a0, int a1, int a2, int a3, double a4, int a5, int a6, int a7)
{
  printf("%d %d %d %d %d %d\n", b0, b1, b2, b3, b4, b5);
  printf("%f %d %d %d %f %d %d %d\n", a0, a1, a2, a3, a4, a5, a6, a7);
}

int main(void) {
  f(0, 1, 2, 3, 4, 5, 0.0, 1, 2, 3, 4.0, 5, 6, 7);
  return(0);
}
====================================

--
Stephen Turner               http://www.statslab.cam.ac.uk/~sret1/
  Statistical Laboratory, Wilberforce Road, Cambridge, CB3 0WB, England
  "Your account can only be used for a single internet session at any one
   time and for no more than 24 hours in any one day." (NTL terms of use)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
