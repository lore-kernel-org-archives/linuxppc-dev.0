Return-Path: <peter.asemann@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B16567A33
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 20:17:54 +1000 (EST)
Received: by fmmailgate05.web.de (8.12.10/8.12.10/webde Linux 0.7) with ESMTP
	id j499wY7w030014
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 May 2005 11:58:34 +0200
Received: from [131.188.52.149] (helo=[131.188.52.149])
	by smtp07.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.105 #282)
	id 1DV51y-00035n-00
	for linuxppc-embedded@ozlabs.org; Mon, 09 May 2005 11:58:30 +0200
Message-ID: <427F3441.2010108@web.de>
Date: Mon, 09 May 2005 11:58:25 +0200
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: Writing a small test program - a bit off topic
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there!

I *hope* this mail isn't very off topic. In principle it probably is, 
but I don't know a mailing list which is about writing test programs to 
test processors in order to debug a hardware to get linux running. Plus, 
I suppose there are people out there who could help me. So I hope you 
won't stone me for this post.

Whatever:
I have to write some test program for a mpc875 processor. It should run 
in the processor cache as the memory of the hardware doesn't work for 
hardware-problem-reasons.

I set up the memory mapping of the IMMR of the processor with the 
debugger (BDM4GDB) so the IMMR is at 0xff000000.
Then I want to change the state of two leds. This can be done by writing 
some values into some memory-mapped MPC registers (PEDAT / PEDIR) which 
reside at IMMR + 0xac8 / 0xad8.

I wrote a C program to do that; As there is no OS I think I can just try 
to write to memory locations directly:

#define CONFIG_8xx

int main(void){
long* a;
long* b;
a = (long*)0xff000ac8;
*a = 0x00001800;
b = (long*)0xff000ad8;
*b = 0x00001800;
}

Actually, if I compile it (using Denx ELDK 3.1) with

ppc-linux-gcc -static led.c -o led

the resulting program is 477K big.
On the other hand, if I do

ppc-linux-as -mcom led.s
and
ppc-linux-as -mcom led.s -o led.bin

the resulting program is 439 byte big.

Now, my questions are: Will the 439 byte program faciliated this way do 
what I want? Did I make some fatal newbie mistakes? Does somebody know 
how to upload code to the mpc instruction cache and execute it?

Thanks for reading,

Peter Asemann
