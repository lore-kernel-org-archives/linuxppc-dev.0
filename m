From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AFB37F4.16620@bjapp3>
Date: Fri, 11 May 2001 08:53:08 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: About LCD driver?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
	My lcd device is via MPC850 parport(because my lcd display screen is small).I w
rite my own driver for it.Here is my do.

	in .config file,I add
	CONFIG_PLCD=y


	in drivers/char/Makefile,I add
	ifeq(($CONFIG_PLCD),y)
		L_OBJS+=plcd.o
	endif


	in driver/char/mem.c,I add
	#ifdef CONFIG_PLCD
		plcd_init();	/*in my plcd.c file*/
	#endif

	At last,i add a new file plcd.c in drivers/char/ .I make zImage again.
I fount plcd.o in drivers/char/.
	In my driver plcd_init ,I use printk output some information,
When kernel is run,no information was seen.Writing driver like me is right?
I thank i should see device in /proc/devices,but i could not.I have fill the
each elemnet of struct file_operations.There is noting in boot log,and nothing i
n /proc/devices.What can i do?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
