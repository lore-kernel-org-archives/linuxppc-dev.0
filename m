Message-ID: <000101bedfdd$9250fc20$6401a8c0@everyone>
From: "Neil Blackwood" <nb@terrafix.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: PROBLEMS BOOTING KERNEL ON EMBEDDED PROCESSOR MBX821
Date: Thu, 5 Aug 1999 17:59:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


        I have just downloaded the 2.2.0pre6 kernel for MBX8xx processors
from
the embedded directory of linuxppc.cs.nmt.edu.

We are running it on a MXX821-004A development board.

Unfortunately we seem to have a problem during the booting of the kernel.

The messages

                        iack = -1

and
                        irq = 7

are displayed continuously.

We have managed to track down the iack message in the kernel source.

In directory

linux/arch/ppc/kernel

in File

ppc8xx_pic.c

In function

mbx_i8259_action()
is the code

                int irq;

                irq = (inl(0x508)>>24)&0xff;
                if (irq!= 0xff)printk("iack 5d\n", irq);

We think this is inconsistent if the value of irq is printed out as -1.



We have previously run a 2.1 version of the kernel successfully. Do you have
any ideas to solve the problem?


I am also looking at including floating point libraries into the kernel.
Does anything currently exist?



                                Neil Blackwood

ps Is this type of enquiry suitable for this mailing list or should I use
USERS.

pps I am completely new to LINUX and operating systems in general, so my
current level of understanding is very low.
------------------------------------------------------
www.terrafix.co.uk

Terrafix Ltd
23c Newfield Industrial Estate
Tunstall, Stoke on Trent
Staffordshire, UK, ST6 5PD

+44 1782 577015, +44 1782 835667 (fax)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
