Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id DA7B767BCF
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:12:05 +1100 (EST)
Date: Mon, 4 Dec 2006 14:12:02 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Message-ID: <20061204131202.GA28704@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204124026.GB28159@aepfle.de>
	<20061204130254.424c7979@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061204130254.424c7979@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, Alan wrote:

> On Mon, 4 Dec 2006 13:40:26 +0100 (MET)
> Olaf Hering <olaf@aepfle.de> wrote:
> 
> > 
> > 
> > the hald media changed polling does really confuse things.
> > noone knows why the delays are needed, but they give us access to
> > the CD.
> 
> Can you tell me what happens if you completely pull the reset out of the
> dma_end function. Do you still need delays then.

Did you mean like this?

@@ -215,7 +217,10 @@ static void sl82c105_bmdma_stop(struct a
        struct ata_port *ap = qc->ap;

        ata_bmdma_stop(qc);
+#if 0
        sl82c105_reset_engine(ap);
+       udelay(50);
+#endif

        /* This will redo the initial setup of the DMA device to matching
           PIO timings */

[  315.923917] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  315.923927] ata1.00: (BMDMA stat 0x41)
[  315.923935] ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  315.924039] ata1: soft resetting port
[  346.243816] ata1.00: qc timeout (cmd 0xa1)
[  346.243829] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  346.243882] ata1.00: revalidation failed (errno=-5)
[  346.243891] ata1: failed to recover some devices, retrying in 5 secs
[  351.253802] ata1: soft resetting port
[  381.573813] ata1.00: qc timeout (cmd 0xa1)
[  381.573823] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  381.573876] ata1.00: revalidation failed (errno=-5)
[  381.573884] ata1: failed to recover some devices, retrying in 5 secs
 
