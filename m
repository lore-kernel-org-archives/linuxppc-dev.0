Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94FB9DDED3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 13:40:01 +1000 (EST)
Message-ID: <46F9D482.8090407@garzik.org>
Date: Tue, 25 Sep 2007 23:39:46 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: 2.6.23-rc6-mm1: Build failure on ppc64 drivers/ata/pata_scc.c
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920131315.GE24105@skynet.ie>
	<20070920150925.0caf3aef@the-village.bc.nu>
	<alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
In-Reply-To: <alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kamalesh@linux.vnet.ibm.com, linux-ide@vger.kernel.org,
	Mel Gorman <mel@skynet.ie>, Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Satyam Sharma wrote:
> Hi,
> 
> 
> On Thu, 20 Sep 2007, Alan Cox wrote:
>> On Thu, 20 Sep 2007 14:13:15 +0100
>> mel@skynet.ie (Mel Gorman) wrote:
>>
>>> PPC64 building allmodconfig fails to compile drivers/ata/pata_scc.c . It
>>> doesn't show up on other arches because this driver is specific to the
>>> architecture.
>>>
>>> drivers/ata/pata_scc.c: In function `scc_bmdma_status'
>> Its not been updated to match the libata core changes. Try something like
>> this. Whoever is maintaining it should also remove the prereset cable handling
>> code and use the proper cable detect method.
> 
> It appears you forgot to fix scc_std_softreset() and one of its callsites
> in scc_bdma_stop(). A complete patch is attempted below -- please review.
> 
> 
> [PATCH -mm] pata_scc: Keep up with libata core API changes
> 
> Little fixlets, that the build started erroring / warning about:
> 
> drivers/ata/pata_scc.c: In function 'scc_bmdma_status':
> drivers/ata/pata_scc.c:734: error: structure has no member named 'active_tag'
> drivers/ata/pata_scc.c: In function 'scc_pata_prereset':
> drivers/ata/pata_scc.c:866: warning: passing arg 1 of 'ata_std_prereset' from incompatible pointer type
> drivers/ata/pata_scc.c: In function 'scc_error_handler':
> drivers/ata/pata_scc.c:908: warning: passing arg 2 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 3 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 5 of 'ata_bmdma_drive_eh' from incompatible pointer type
> make[2]: *** [drivers/ata/pata_scc.o] Error 1
> 
> Signed-off-by: Satyam Sharma <satyam@infradead.org>
> Cc: Alan Cox <alan@redhat.com>
> Cc: Mel Gorman <mel@skynet.ie>
> 
> ---
> 
> Andrew, this includes (supercedes) the previous two ones from Mel / Alan.
> 
>  drivers/ata/pata_scc.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

applied
