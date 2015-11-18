Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 083A61A0736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 22:10:50 +1100 (AEDT)
Message-ID: <1447845043.7303.1.camel@ellerman.id.au>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 18 Nov 2015 22:10:43 +1100
In-Reply-To: <564C5BBC.8020701@linux.vnet.ibm.com>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <564C5BBC.8020701@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-18 at 12:06 +0100, Laurent Dufour wrote:
> On 18/11/2015 10:18, Michael Ellerman wrote:
> > Hi folks,
> > 
> > I'm intermittently seeing the following oops on at least one powerpc box.
> > 
> > The BUG_ON() is from:
> > 
> > static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
> > {
> > 	...
> > 	count = blk_rq_map_sg(req->q, req, sdb->table.sgl);
> > 	BUG_ON(count > sdb->table.nents);
> > 
> > Looking at the dump it looks like count was 2, I can't work out what nents was.
> > 
> > The machine's just a fairly boring bare metal setup, with a single IPR adapter:
> > 
> > 0001:08:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 02)
> > 	Subsystem: IBM PCIe3 x8 SAS RAID Internal Adapter 6Gb (57D7)
> > 	Flags: bus master, fast devsel, latency 0
> > 	Kernel driver in use: ipr
> > 
> > 
> > Anyone seen it before or have any ideas?
> 
> Hi Michael,
> 
> I'm facing the same panic on my bare metal system.
> 
> Sounds to be raised by the latest update to 4.4-rc1

Yeah I think it's new since 4.3.

Do you see it regularly, or just every now and then?

cheers
