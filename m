From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199908260906.CAA17265@falcon.csc.calpoly.edu>
Subject: kernel entry point, where in code?
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Date: Thu, 26 Aug 1999 02:06:22 -0700 (PDT)
Cc: borja.001@berlin.snafu.de, jfuller@falcon.csc.calpoly.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't quite know where to go from here...

I have gotten the 2.2.10 kernel from linuxppc.org a while ago.  I did not have
problems compiling it at all.  I did:
gmake config
gmake dep
gmake
gmake modules
gmake modules_install

moved the kernel and the System.map to the /boot and rebooted.

I get through the quik loader.  (Booting from OF) but the screen does not seem
to clear like it does normaly.  And then the computer hangs.

So what I am left with is the boot prompt in OF something like:

boot:
\
device...  /bandit/
device...  /chaos/control

What I can figure is the kernel hangs somewhere before start_kernel and up
to and including the console_init function call.  Because with my kernel which
works I think these messages are the same and the screen blanks and then starts
with the boot process.

in file init/main.c:

asmlinkage void __init start_kernel(void)
{

I have been trying to figure out where this is called so that I can try and
figure out what is going wrong?  I have no errors from the kernel.  I have
searched all the arch, include/asm-ppc and other directories I can think of in
the source.

Along those lines...

Is it printk which prints the messages on the screen at bootup.  PRIOR to the
init scripts.  I don't even get the linux_banner before the machine locks up...
;-(

Or if I am totaly off-base here...

Where does the kernel code start executing?

Thanks in advance
Ira Weiny
iweiny@acm.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
