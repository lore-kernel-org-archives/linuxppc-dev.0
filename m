Message-ID: <36DF08BD.228E5AF0@andrew.cmu.edu>
Date: Thu, 04 Mar 1999 17:27:09 -0500
From: Randy Gobbel <gobbel@andrew.cmu.edu>
MIME-Version: 1.0
To: kbhend@business.wm.edu
CC: gdt@linuxppc.org, sbb@gnu.org, linuxppc-dev@lists.linuxppc.org,
        egcs@egcs.cygnus.com
Subject: Re: Problem with egcs and denormalized constants?
References: <36DEBCB0.7A98EB80@business.wm.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:
> 
> Hi,
> 
> The LinuxPPC port of JDK 1.2 can't pass the Java Compatibility Kit runtime-vm
> tests because of some sort of error which is related to having very small
> de-nromalized float constants.
> 
> I don't know whether this is an egcs problem (it happens with both egcs 1.1.1
> and egcs 1.0.2), glibc problem (tested with the very latest glibc 1.99 rpm from
> Gary) but it is an error.
> 
> Will someone please compile and try the follwoing very simple test program and
> help me understand what is happening here.  Is this an egcs problem?
> 
> [root@kbhend fltbug]# cat t3.c
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <stdio.h>
> 
> float flMin (int i)
>  {
>    float fl;
>    if (i == 0) fl = 1.4023984e-37F;
>    if (i == 1) fl = 1.4023984e-38F;
>    if (i == 2) fl = 1.4023984e-39F;
>    if (i == 3) fl = 1.4023984e-40F;
>    if (i == 4) fl = 1.4023984e-41F;
>    if (i == 5) fl = 1.4023984e-42F;
>    if (i == 6) fl = 1.4023984e-43F;
>    if (i == 7) fl = 1.4023984e-44F;
>    if (i == 8) fl = 1.4023984e-45F;
>    return fl;
>  }
> 
> int main(int argc, char** argv)
> {
>   int i;
>   float f;
> 
>   for (i=0;i<9;i++) {
>      f = flMin(i);
>      fprintf(stdout,"flmin(%1d) is %20.13e\n",i,f);
>   }
>   fprintf(stdout,"But flmin(7)/10.0F is %20.13e\n",(flMin(7)/10.0F));
> }
> 
> Here is the output from my LinuxPPC box:
> 
> [root@kbhend fltbug]# ./t3
> flmin(0) is  1.4023984275674e-37
> flmin(1) is  1.4023983434895e-38
> flmin(2) is  1.4023984836193e-39
> flmin(3) is  1.4023914771270e-40
> flmin(4) is  1.4024195030963e-41
> flmin(5) is  1.4026997627891e-42
> flmin(6) is  1.4012984643248e-43
> flmin(7) is  1.4012984643248e-44
> flmin(8) is  0.0000000000000e+00
> But flmin(7)/10.0F is  1.4012984643248e-45
> 
> Here is the correct output from my AIX box using an old version of gcc:
> 
> kbhend$ gcc -ot3 -O0 t3.c
> kbhend$ ./t3
> flmin(0) is  1.4023984275674e-37
> flmin(1) is  1.4023983434895e-38
> flmin(2) is  1.4023984836193e-39
> flmin(3) is  1.4023914771270e-40
> flmin(4) is  1.4024195030963e-41
> flmin(5) is  1.4026997627891e-42
> flmin(6) is  1.4012984643248e-43
> flmin(7) is  1.4012984643248e-44
> flmin(8) is  1.4012984643248e-45
> But flmin(7)/10.0F is  1.4012984643248e-45
> 
> Notice the difference in the value of flmin(8) when loaded from a constant.
> 
> I looked at the assmebler and the constant for that value is correctly
> identified and present.
> 
> What do you think?

It's pretty easy to see what's going on if you look at it with gdb.  

(gdb) x/10 0x1802078
0x1802078 <.LC0>:       1.40239843e-37  1.40239834e-38  1.40239848e-39 
1.40239148e-40
0x1802088 <.LC4>:       1.4024195e-41   1.40269976e-42  1.40129846e-43 
1.40129846e-44
0x1802098 <.LC8>:       0       2.79124188e+23
(gdb) x/10x 0x1802078
0x1802078 <.LC0>:       0x023ee274      0x0098b529      0x000f4551     
0x000186ee
0x1802088 <.LC4>:       0x00002718      0x000003e9      0x00000064     
0x0000000a
0x1802098 <.LC8>:       0x00000000      0x666c6d69

Sure looks like an egcs bug to me.  The constant is being generated
incorrectly--it should show up as a 1 in hex.  If I manually stuff a 1
into .LC8, the program prints out the correct number:

(gdb) x/10x 0x1802078
0x1802078 <.LC0>:       0x023ee274      0x0098b529      0x000f4551     
0x000186ee
0x1802088 <.LC4>:       0x00002718      0x000003e9      0x00000064     
0x0000000a
0x1802098 <.LC8>:       0x00000001      0x666c6d69
(gdb) c
Continuing.
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

-Randy
--
http://www.cnbc.cmu.edu/~gobbel/
PGP fingerprint: 32 8A E8 24 A1 46 26 BC  F9 9D 0E B6 81 A9 02 0C

NOTICE: I DO NOT ACCEPT UNSOLICITED COMMERCIAL EMAIL MESSAGES OF ANY
KIND.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
