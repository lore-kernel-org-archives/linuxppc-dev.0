Return-Path: <hiep@netvisiontel.co.kr>
Received: from netvisiontel.co.kr (unknown [221.145.251.142])
	by ozlabs.org (Postfix) with ESMTP id 14BC767A6E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 14:45:54 +1000 (EST)
Message-ID: <003801c53415$5a62d030$c800a8c0@hieptran>
From: "Hiep Tran" <hiep@netvisiontel.co.kr>
To: "ML linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>	<1110334456.32556.21.camel@gaston>	<20050308194229.41c23707.davem@davemloft.net>	<1110340214.32524.32.camel@gaston><57a429f8eb807987d88b06129861d507@freescale.com><4230D1AC.5070506@katalix.com><ba5d844255b5ba76b2685f9397faf689@freescale.com><423734FB.40101@katalix.com><96c50184a02557c88dee0e6d17f3a539@freescale.com><6b870ceb81370f10886e5b7a5943ae82@freescale.com>
	<be784d868895f716feaf92e8fe93f826@freescale.com>
Date: Tue, 29 Mar 2005 13:11:16 +0900
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ks_c_5601-1987";
	reply-type=response
Subject: Problem when accessing variables
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I just joint to embedded software world and I am facing with a problem 
related to ppc_405-gcc compiler. My problem is my source code if compiled by 
gcc compiler and run on Linux platform, everything is OK, but if my source 
code is compiled with ppc_405-gcc and transfering to Power PC and to be run, 
I am always facing with "pointer problem" described as follows:

I have file called "hashtable.c", which contains some functions to 
manipulate a structure in C programming language (it's really a hashtable 
structure, which I am implementing). These functions include adding, 
removing, lookupping etc on a input pointer parameter, which point to a 
hashtable structure.

I have another file called "test.c", which will use functions of hashtable, 
which mentioned above. And in this file, I can manipulate my hashtable 
structure by calling functions in file "hashtable.c" only. But if I access 
to members of hashtable structure or hashtable's node structure directly 
(without calling hashtable functions to receive these structure's members) 
then my test program is always died by a invalid pointer, which is referring 
to structure's member. the test.c and hashtable.c files were compiled and 
linked together.

But if I copy all functions in hashtable.c and paste to test.c and then 
compile, create my program by using the test.c file only the my test program 
is run well.

I think my problem related to linking between object files (it's seem to me 
that, pointers, which are allocated memory, or global variables declared in 
this file will cause problem when access it in another file) on ppc_405-gcc 
compiler because my problem is still run well on Linux computer when it was 
compiled and linked by gcc compiler.

My temporary solution is I added a new function to the file hashtable.c, 
this function returns data members, which reside inside node structures of 
hashtable structure and I can access these data pointers without facing any 
problem.

Anyone could give me any option to set to ppc_405-gcc compiler or any 
solution to help to me passing the problem.

Thanks,
Hiep Tran
