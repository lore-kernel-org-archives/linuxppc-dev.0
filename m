Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 3C199DDDAB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 09:47:15 +1100 (EST)
Message-ID: <499203BB.5010902@am.sony.com>
Date: Tue, 10 Feb 2009 14:46:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [patch] powerpc/ps3: Use hard coded values for LV1 device type
References: <498C6C49.1010200@in.ibm.com> <498CF52E.4040903@am.sony.com>	
	<1234092590.10240.4.camel@localhost>
	<1234138267.31963.77.camel@pasglop>
	<1234151988.8776.4.camel@localhost.localdomain>
In-Reply-To: <1234151988.8776.4.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Mel Gorman <mel@csn.ul.ie>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

James Bottomley wrote:
> On Mon, 2009-02-09 at 11:11 +1100, Benjamin Herrenschmidt wrote:
>> The PS3 platform code wants to use some of the standard SCSI types from
>> there though, as they are part of the hypervisor ABI. (And in fact it
>> can be argued that non-block devices using SCSI do exist, such as
>> scanners, no ?)
>> 
>> Any reason other than pre-historical to have blkdev.h shielded like
>> that ?
> 
> Actually, I think the fix lies in scsi.h ... we can make that into a
> nicely independent protocol header file.  Your current woes come because
> it pulls in scsi_cmnd.h ... perhaps just getting rid of this will fix
> it.
> 
> Can the rest of linux-scsi verify that the fix below doesn't break
> something else?
> 
> I found one cockup: block/cmd-filter.c is apparently not including
> linuc/blkdev.h directly but via scsi/scsi.h ... I fixed this up.
...
> diff --git a/block/cmd-filter.c b/block/cmd-filter.c
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h

I tested this scsi header fix on PS3 and it fixes the BLK_MAX_CDB
not defined build error when CONFIG_BLOCK=n.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
