Message-ID: <3D4F5107.2040606@gmx.de>
Date: Tue, 06 Aug 2002 06:31:03 +0200
From: Michael Habermann <MHabermann@gmx.de>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging kernel modules
References: <20020805230054.71397.qmail@web40207.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:
> But here's the question - is there any way to dump the
> module load addresses, after the fact?  'insmod -m'

If necessary, it also works without tools.

The linux kernel has the symbol module_list, which contains a linked
list of all modules. You can follow the linked list until you find your
module. Take the address of the struct module list entry (!) and add
(size_of_struct+4). Then you get to the start address of your module.

E.g.:
&struct module = 0xc100b000
size_of_struct = 0x60

=> .text = 0xc1000064


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
