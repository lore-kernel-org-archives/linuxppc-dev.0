Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04104400b2eab6a50b99@[192.168.0.1]>
Date: Sat, 13 Feb 1999 00:07:28 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: making progress on 6500 ethernet - need advice
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not getting much interest on the linuxppc-user list, so I thought 
I'd try here. I've had this ethernet problem ever since about 
2.1.125, before which I did not try to run ethernet.

---------

My PowerMac 6500, running 8.5.1, with a Farallon 10BT 21041-based 
ethernet card installed, stock IDE harddrive with one Mac HFS 
partition and the rest partitioned/formatted in the usual way for 
Linux, has had ethernet problems (with Linux only) for a long time 
now. The symptoms are listed at the end of this post.

Some of you have been kind enough to e-mail suggestions, but nothing 
has worked. However, I would like to report a significant result and 
hope that those brighter than me can suggest a strategy for closing 
this out once and for all.

I did a straight side by side comparison with the Samba 
linux-pmac-2.1.1 and the linux.cs.nmt.edu linux-vger-2.2.0 kernels.

I compiled each according to:

	make distclean
	make pmac_config
	make config (used return key to select every default value)
	make dep
	make clean
	make vmlinux
	make modules
	make modules_install

and ran each kernel under identical conditions. Bottom line:

linux-pmac-2.2.1 compiled and ethernet works
linux-vger-2.2.0 compiled and ethernet does not work

I seriously doubt the 2.2.0->2.2.1 changes are the difference, 
because I have also compiled the kernel.org 2.2.1 and it failed as 
well.

Instead, my main suspicion over time has been the config file, and 
with such a clear-cut example of success and failure, I felt 
confident about comparing .config files for the  first time ever.

I'm afraid I'm very disappointed.

My generated .config file for linux-pmac-2.2.1 and linux-vger-2.2.0 
differ in only [2] minor places:

	1) The linux-pmac-2.2.1 .config contains a commented out
		"# CONFIG_PC_KEYBOARD is not set" statement while the
		linux-vger-2.2.0 does not reference it.

	2) The linux-pmac-2.2.1 .config contains a commented out
		"# CONFIG_USB is not set" statement while the
		linux-vger-2.2.0 does not reference it.

With the config files virtually identical, I have run out of 
possibilities as to why the samba kernel is the only one that works. 
significantly, the only other kernel that has worked for me w.r.t. 
ethernet was the Samba 2.1.130 kernel. My 6500 only likes Samba.

Figuring out the key has become a quest for me. I am asking for 
suggestions as to where in the kernel source to begin looking for 
clues. Performing a global difference on the entire source is 
obviously not efficient. I'm looking for suggestions on paring the 
task down.


Thanks,


Stefan Jeglinski


----------------------- t h e   p r o b l e m ---------------------------


With *non-samba* kernels, the ethernet fails repeatably in the following way:

1) in a terminal window, start pinging a destination. This 
destination can be anything from the resident Farallon card to any IP 
on the net. The pings proceed normally.

2) Launch Netscape or vanilla ftp.

3) within a short while (a couple of web pages or ftp directory 
changes), the Netscape or ftp client stalls, and the ping 
terminal-output stops cold, never to continue.

3a) from time to time, the ping exhibits an odd pattern before 
failure: amongst the normal 200-600 ms ping returns, there are 
interspersed (every 6 or 7 pings) return times of 6000-7000 ms, very 
repeatable when it happens, but it does not always occur before 
failure.

4) pinging from the other side to the Linux-resident ethernet card 
again seems fine until the failure, when suddenly no pings are 
returned at all.

5) reboot cures it until the procedure is tried again, which brings 
the same overall failure 100% of the time.

5a) *Almost* always there is a crash (freeze) on reboot, right at the 
shutdown message about not being able to locate module pf-4. I do not 
think not being able to locate the module is relevant; rather, this 
point in the shutdown is very close to where the ifdown script is 
being run repeatedly to tear down the routing table, IIRC. After I 
have an ethernet failure, this script is unable to complete and just 
hangs.


Stefan Jeglinski

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
