Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49AB4B7CF7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Apr 2010 17:50:30 +1100 (EST)
Date: Fri, 2 Apr 2010 15:50:24 +0900
To: sachinp@in.ibm.com
Subject: Re: 2.6.34-rc3 : Badness at lib/dma-debug.c:820 during ibmvscsi init
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <4BB590C6.3090108@in.ibm.com>
References: <4BB57E3F.3050502@in.ibm.com>
	<20100402151229V.fujita.tomonori@lab.ntt.co.jp>
	<4BB590C6.3090108@in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100402154959K.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, brking@linux.vnet.ibm.com,
	linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 02 Apr 2010 12:07:58 +0530
Sachin Sant <sachinp@in.ibm.com> wrote:

> FUJITA Tomonori wrote:
> > On Fri, 02 Apr 2010 10:48:55 +0530
> > Sachin Sant <sachinp@in.ibm.com> wrote:
> >
> >   
> >> 2.6.34-rc3 boot on a power5 box produces this badness message
> >> during ibmvscsi initialization.
> >>
> >> ibmvscsi 30000003: Client reserve enabled
> >> ibmvscsi 30000003: sent SRP login
> >> ibmvscsi 30000003: SRP_LOGIN succeeded
> >> ibmvscsi 30000003: DMA-API: device driver frees DMA memory with wrong function [device address=0x0000000000011520] [size=36 bytes] [mapped as scather-gather] [unmapped as single]
> >>     
> >
> > ibmvscsi has been incompatible with the dma debug facility, I
> > guess. The driver uses dma_unmap_single for buffers mapped via
> > dma_map_sg. It works but it's the API violation.
> >
> > Does this patch work?
> >   
> Yes, this patch fixed the issue for me. Thanks

Thanks, here's the patch in the proper format.

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] ibmvscsi: fix DMA API misuse

ibmvscsi uses dma_unmap_single() for buffers mapped via
dma_map_sg(). It works however it's the API violation. The DMA debug
facility complains about it:

http://marc.info/?l=linux-scsi&m=127018555013151&w=2

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Tested-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index dc1bcbe..0856436 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -322,16 +322,6 @@ static void set_srp_direction(struct scsi_cmnd *cmd,
 		srp_cmd->buf_fmt = fmt;
 }
 
-static void unmap_sg_list(int num_entries,
-		struct device *dev,
-		struct srp_direct_buf *md)
-{
-	int i;
-
-	for (i = 0; i < num_entries; ++i)
-		dma_unmap_single(dev, md[i].va, md[i].len, DMA_BIDIRECTIONAL);
-}
-
 /**
  * unmap_cmd_data: - Unmap data pointed in srp_cmd based on the format
  * @cmd:	srp_cmd whose additional_data member will be unmapped
@@ -349,24 +339,9 @@ static void unmap_cmd_data(struct srp_cmd *cmd,
 
 	if (out_fmt == SRP_NO_DATA_DESC && in_fmt == SRP_NO_DATA_DESC)
 		return;
-	else if (out_fmt == SRP_DATA_DESC_DIRECT ||
-		 in_fmt == SRP_DATA_DESC_DIRECT) {
-		struct srp_direct_buf *data =
-			(struct srp_direct_buf *) cmd->add_data;
-		dma_unmap_single(dev, data->va, data->len, DMA_BIDIRECTIONAL);
-	} else {
-		struct srp_indirect_buf *indirect =
-			(struct srp_indirect_buf *) cmd->add_data;
-		int num_mapped = indirect->table_desc.len /
-			sizeof(struct srp_direct_buf);
 
-		if (num_mapped <= MAX_INDIRECT_BUFS) {
-			unmap_sg_list(num_mapped, dev, &indirect->desc_list[0]);
-			return;
-		}
-
-		unmap_sg_list(num_mapped, dev, evt_struct->ext_list);
-	}
+	if (evt_struct->cmnd)
+		scsi_dma_unmap(evt_struct->cmnd);
 }
 
 static int map_sg_list(struct scsi_cmnd *cmd, int nseg,
-- 
1.7.0
