Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id DF890DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 00:02:03 +1100 (EST)
Date: Wed, 18 Mar 2009 16:02:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/4] NAND: FSL-UPM: add multi chip support
Message-ID: <20090318130201.GA32320@oksana.dev.rtsoft.ru>
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
	<1237281143-8768-2-git-send-email-wg@grandegger.com>
	<20090317192735.GC4287@oksana.dev.rtsoft.ru>
	<49C0A59D.3040105@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49C0A59D.3040105@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 08:41:17AM +0100, Wolfgang Grandegger wrote:
> Anton Vorontsov wrote:
> > On Tue, Mar 17, 2009 at 10:12:19AM +0100, Wolfgang Grandegegr wrote:
> >> From: Wolfgang Grandegger <wg@grandegger.com>
> >>
> >> This patch adds support for multi-chip NAND devices to the FSL-UPM
> >> driver. This requires support for multiple GPIOs for the RNB pins.
> >>
> >> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> >> ---
> >>  drivers/mtd/nand/fsl_upm.c |   90 +++++++++++++++++++++++++++++++++----------
> >>  1 files changed, 69 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
> >> index 7815a40..ca7e85a 100644
> >> --- a/drivers/mtd/nand/fsl_upm.c
> >> +++ b/drivers/mtd/nand/fsl_upm.c
> >> @@ -23,6 +23,8 @@
> >>  #include <linux/io.h>
> >>  #include <asm/fsl_lbc.h>
> >>  
> >> +#define FSL_UPM_NAND_MAX_CHIPS 4
> > 
> > Is there any reason to hardcode max chips? Some obscure limit in the
> > UPMs maybe?
> 
> Not really. It's limited by NAND_MAX_CHIP. See
> http://lxr.linux.no/linux+v2.6.28.8/include/linux/mtd/nand.h#L40

OK, then you could just use that constant, since we'll only allocate
the 8 ints.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
