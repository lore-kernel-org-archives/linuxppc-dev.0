Message-ID: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: map iomem in linux_2_4_dev
Date: Mon, 27 May 2002 13:59:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, every one:

I've searched through the achieve, but failed to find stuff about mapping
io-memmory in this linux_2_4_dev version.
After check the source code, it seems from 2_4_dev onwards, no need to use
ioremap to map io memory. We
should use io_block_mapping() instead.

What confused me is that after i add the following statement in
m8xx_setup.c. My pcmcia_cs package still can't get access to this address.
The mesage from pcmcia is : GetNextTuple: No more items.

What i add in m8xx_setup.c is:

#ifdef CONFIG_FADS

io_block_mapping(PCMCIA_MEM_ADDR,PCMCIA_MEM_ADDR,PCMCIA_MEM_SIZE,_PAGE_IO);
#endif

But after i insert my PCMCIA card to my FADS board, i check the
/var/log/debug information. I found that:
...
m8xx_pcmcia: SetMemMap(0,0,0x21,300 ns, 0xff020000-0xff020000, 0x0000)
----
Does anyone know why this SetMemMap size is 0 instead of PCMCIA_MEM_SIZE? Is
this the reason of pcmcia module fail?

Appreciate your help!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
