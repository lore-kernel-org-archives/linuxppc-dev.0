In-Reply-To: <9812159137.AA913779792@ccmail.ray.ca>
Date: Thu, 17 Dec 1998 19:38:27 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Small error?? in IDE dma processing?
Message-Id: <19981217193827.008878@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul !

On the linux kernel mailing list, I've catched the following message :

On Tue, Dec 15, 1998,  <jason.harp@mail.ray.ca> wrote:

>   Can you confirm an error in the following code for dma_intr(): (2.0)
>     
>     
>             dma_stat = inb(dma_base+2);             /* get DMA status */
>             outb(inb(dma_base)&~1, dma_base);     /* stop DMA operation */
>             stat = GET_STAT();                      /* get drive status */
>     
>     
>     Should this not be:
>     
>     
>             outb(inb(dma_base)&~1, dma_base);      /* stop DMA operation*/
>             dma_stat = inb(dma_base+2);             /* get DMA status */
>             stat = GET_STAT();                      /* get drive status */
>     
>      
>     Similar for (2.1) the DMA status is retrieve before you stop the DMA 
>     operation.

The error was then confirmed I think by Andre M. Hedrick.

Then, I looked at our ide-dma.c and ide-pmac.c, and it looks like we have
the same kind of issue:

ide-pmac.c, line 301:

    case ide_dma_end:
        drive->waiting_for_dma = 0;
        dstat = in_le32(&dma->status);
        out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
        /* verify good DMA status */
        return (dstat & ((RUN|DEAD|ACTIVE)) != RUN;

shouldn't we do the same split and reverse the status read and the
control write ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
