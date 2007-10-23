Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7449CDDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 15:47:34 +1000 (EST)
Date: Tue, 23 Oct 2007 00:54:39 -0500
From: Olof Johansson <olof@lixom.net>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: IB/ehca: Fix sg_page() fallout
Message-ID: <20071023055439.GA22426@lixom.net>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com>
	<1193076664-13652-10-git-send-email-jens.axboe@oracle.com>
	<20071023040948.GA19699@lixom.net>
	<20071023043148.GA20904@lixom.net>
	<20071023050512.GK16425@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023050512.GK16425@kernel.dk>
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


More fallout from sg_page changes:

drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user1':
drivers/infiniband/hw/ehca/ehca_mrmw.c:1779: error: 'struct scatterlist' has no member named 'page'
drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_check_kpages_per_ate':
drivers/infiniband/hw/ehca/ehca_mrmw.c:1835: error: 'struct scatterlist' has no member named 'page'
drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user2':
drivers/infiniband/hw/ehca/ehca_mrmw.c:1870: error: 'struct scatterlist' has no member named 'page'


Signed-off-by: Olof Johansson <olof@lixom.net>


---

On Tue, Oct 23, 2007 at 07:05:12AM +0200, Jens Axboe wrote:
> On Mon, Oct 22 2007, Olof Johansson wrote:
> > More fallout from sg_page changes, found with powerpc allyesconfig:
> > 
> > drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user1':
> > drivers/infiniband/hw/ehca/ehca_mrmw.c:1779: error: 'struct scatterlist' has no member named 'page'
> > drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_check_kpages_per_ate':
> > drivers/infiniband/hw/ehca/ehca_mrmw.c:1835: error: 'struct scatterlist' has no member named 'page'
> > drivers/infiniband/hw/ehca/ehca_mrmw.c: In function 'ehca_set_pagebuf_user2':
> > drivers/infiniband/hw/ehca/ehca_mrmw.c:1870: error: 'struct scatterlist' has no member named 'page'
> 
> Thanks a lot Olof, applied both fixups!

I messed up the second fix. :( please replace with this.


-Olof


diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index da88738..ead7230 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1776,7 +1776,7 @@ static int ehca_set_pagebuf_user1(struct ehca_mr_pginfo *pginfo,
 	list_for_each_entry_continue(
 		chunk, (&(pginfo->u.usr.region->chunk_list)), list) {
 		for (i = pginfo->u.usr.next_nmap; i < chunk->nmap; ) {
-			pgaddr = page_to_pfn(chunk->page_list[i].page)
+			pgaddr = page_to_pfn(sg_page(&chunk->page_list[i]))
 				<< PAGE_SHIFT ;
 			*kpage = phys_to_abs(pgaddr +
 					     (pginfo->next_hwpage *
@@ -1832,7 +1832,7 @@ static int ehca_check_kpages_per_ate(struct scatterlist *page_list,
 {
 	int t;
 	for (t = start_idx; t <= end_idx; t++) {
-		u64 pgaddr = page_to_pfn(page_list[t].page) << PAGE_SHIFT;
+		u64 pgaddr = page_to_pfn(sg_page(&page_list[t])) << PAGE_SHIFT;
 		ehca_gen_dbg("chunk_page=%lx value=%016lx", pgaddr,
 			     *(u64 *)abs_to_virt(phys_to_abs(pgaddr)));
 		if (pgaddr - PAGE_SIZE != *prev_pgaddr) {
@@ -1867,7 +1867,7 @@ static int ehca_set_pagebuf_user2(struct ehca_mr_pginfo *pginfo,
 		chunk, (&(pginfo->u.usr.region->chunk_list)), list) {
 		for (i = pginfo->u.usr.next_nmap; i < chunk->nmap; ) {
 			if (nr_kpages == kpages_per_hwpage) {
-				pgaddr = ( page_to_pfn(chunk->page_list[i].page)
+				pgaddr = ( page_to_pfn(sg_page(&chunk->page_list[i]))
 					   << PAGE_SHIFT );
 				*kpage = phys_to_abs(pgaddr);
 				if ( !(*kpage) ) {
