Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.0.2.1.0.20010626172652.00a69210@pop.gmx.de>
Date: Tue, 26 Jun 2001 17:32:38 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Segmentation fault while dynamic linking
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The simple program below produces a segmentation fault when dynamically
linked. When linked with '--static', it works fine.

What can be the problem?

The Segmentation Fault occurs at a lot of programs like busyboxes 'ls' and
unfortnately also at gdbserver.

My configuration: Kernel 2.4.4, glibc 2.2.2, bash 2.05, FADS, MPC855T


#include <stdio.h>
#include <time.h>
int main(int argc, char** argv){
   time_t tm;

   time(&tm);
   printf("This line is displayed\n");
   localtime(&tm);  //produces Segmentation fault
   printf("This one not\n");

   return 0;
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
