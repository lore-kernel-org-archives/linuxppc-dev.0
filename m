Message-ID: <36DEBCB0.7A98EB80@business.wm.edu>
Date: Thu, 04 Mar 1999 12:02:40 -0500
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Reply-To: kbhend@business.wm.edu
MIME-Version: 1.0
To: gdt@linuxppc.org, sbb@gnu.org, linuxppc-dev@lists.linuxppc.org,
        egcs@egcs.cygnus.com
Subject: Problem with egcs and denormalized constants?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The LinuxPPC port of JDK 1.2 can't pass the Java Compatibility Kit runtime-vm
tests because of some sort of error which is related to having very small
de-nromalized float constants.

I don't know whether this is an egcs problem (it happens with both egcs 1.1.1
and egcs 1.0.2), glibc problem (tested with the very latest glibc 1.99 rpm from
Gary) but it is an error.  

Will someone please compile and try the follwoing very simple test program and
help me understand what is happening here.  Is this an egcs problem?

[root@kbhend fltbug]# cat t3.c
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


float flMin (int i)
 {
   float fl;
   if (i == 0) fl = 1.4023984e-37F;
   if (i == 1) fl = 1.4023984e-38F;
   if (i == 2) fl = 1.4023984e-39F;
   if (i == 3) fl = 1.4023984e-40F;
   if (i == 4) fl = 1.4023984e-41F;
   if (i == 5) fl = 1.4023984e-42F;
   if (i == 6) fl = 1.4023984e-43F;
   if (i == 7) fl = 1.4023984e-44F;
   if (i == 8) fl = 1.4023984e-45F;
   return fl;
 }


int main(int argc, char** argv)
{
  int i;
  float f;

  for (i=0;i<9;i++) {
     f = flMin(i);
     fprintf(stdout,"flmin(%1d) is %20.13e\n",i,f);
  }
  fprintf(stdout,"But flmin(7)/10.0F is %20.13e\n",(flMin(7)/10.0F));
}


Here is the output from my LinuxPPC box:

[root@kbhend fltbug]# ./t3
flmin(0) is  1.4023984275674e-37
flmin(1) is  1.4023983434895e-38
flmin(2) is  1.4023984836193e-39
flmin(3) is  1.4023914771270e-40
flmin(4) is  1.4024195030963e-41
flmin(5) is  1.4026997627891e-42
flmin(6) is  1.4012984643248e-43
flmin(7) is  1.4012984643248e-44
flmin(8) is  0.0000000000000e+00
But flmin(7)/10.0F is  1.4012984643248e-45            


Here is the correct output from my AIX box using an old version of gcc:

kbhend$ gcc -ot3 -O0 t3.c
kbhend$ ./t3
flmin(0) is  1.4023984275674e-37
flmin(1) is  1.4023983434895e-38
flmin(2) is  1.4023984836193e-39
flmin(3) is  1.4023914771270e-40
flmin(4) is  1.4024195030963e-41
flmin(5) is  1.4026997627891e-42
flmin(6) is  1.4012984643248e-43
flmin(7) is  1.4012984643248e-44
flmin(8) is  1.4012984643248e-45
But flmin(7)/10.0F is  1.4012984643248e-45


Notice the difference in the value of flmin(8) when loaded from a constant.

I looked at the assmebler and the constant for that value is correctly
identified and present.

What do you think?

Kevin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
