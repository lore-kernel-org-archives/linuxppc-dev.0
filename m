Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc3-s27.bay0.hotmail.com (bay0-omc3-s27.bay0.hotmail.com
	[65.54.246.227]) by ozlabs.org (Postfix) with ESMTP id 5AA2767BE7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 16:22:54 +1000 (EST)
Message-ID: <BAY117-F38602DE22BC1EB7A1E1660C8670@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: linux kernel hang in execve("/sbin/init")
Date: Sat, 22 Jul 2006 02:10:46 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I googled...and googled...etc. etc.. when trying to solve the problem of my 
linux kernel seemingly locking or hanging when it gets to the last part of 
the linux init in main.c

I saw lots of information and suggestions related to try /bin/sh or make 
sure your initrd is ok or make sure you have more than one session..etc. 
etc... .. and all of these topics were mostly from 2001-2003...well.. 
2006...it's here and apparently some of us haven't gotten smarter..

I had this problem recently where my kernel would boot and freeze or hang in 
execve of /sbin/init and also of /bin/sh or /bin/bash...

I debugged and debugged.. and finally thougt... why not try the default 
Kernel config for my target, the PrPmc800 from Motorola... and see what that 
does..   Originally, I started with the MontaVista 3.1 Pro setup for the 
board and it works...so I used it's Kernel .config file to configure my 
latest and greatest (at the time) 2.6.16.18 kernel thinking... well.. this 
has to work..

so.. I ended up with a kernel that semingly hang/froze/locked on the execve 
call in the linux init routines...

guess what folks... the google searches left me just on the verge of giving 
up.

I am here to post this info as somewhat of another answer/alternative to 
people in the same predicament...

if you are having problems with your cross-compiled / embedded ppc kernel 
freezing or hanging on execve, try using the default configuration for your 
target when you build the kernel...

in my case, I did this sort of thing and all of a sudden, my kernel was 
working:

cd to kernel dir
make distclean
make CROSS_COMPILE=powerpc-7400-linux-gnu- prpmc800_defconfig
make zImage.initrd

etc..etc..

it turns out that since I was basing my initial config off of the 2.4.x 
.config from MontaVista, my kernel didn't boot as desired...

so I figured.. after all the googling and working on it that the default 
PrPmc800 config had to boot... why else call it the default config..

so that's my story..   since then, I have copied the kernel 
dir/arch/ppc/configs/prpmc800_defconfig to a temporary file, and modified it 
as necessary...

moral of the story... if you are cross-compiling and having problems where 
you hang on execve("/sbin/init") or execve("/bin/sh") or 
execve("/bin/bash")..etc...   try what I did before you go crazy analyzing 
the initrd or the various /etc/ file configurations or any of the other 
typical bs...
