Date: Mon, 28 Dec 1998 20:10:50 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.LNX.4.03.9812281946552.1425-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.BSI.3.96.981228200616.770A-100000@usr02.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Dec 1998, Geert Uytterhoeven wrote:

> > fb_info->fbmem = ioremap(0xC0000000, board_size);  /* returns 0xC8000000 */
> > fb_info->fbmem_phys = virt_to_phys((unsigned char *)fb_info->fbmem);
> 
> Try
> 
>     fb_info->fbmem_phys = 0xC0000000;
> 
> instead, i.e. use the address you passed to ioremap()[*].
> 

This didn't work -- it generated a "Machine check in kernel mode."

I'm wondering if this is because virt_to_phys and phys_to_vert don't seem to
have a relationship to ioremap -- the inline functions in virt_to_phys and
phys_to_virt for non-APUS machines just add or subtract KERNELBASE from the
address passed in -- and KERNELBASE is 0xc0000000.  ioremap() returned a
value 0x0800000 higher than passed in.  I'm not sure what to experiment with
next.. though I think I'll take a look at how the APUS does the virt_to_phys
and phys_to_vert.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

..Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
