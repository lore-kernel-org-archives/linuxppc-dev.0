Return-Path: <csnook@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 5C152DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 02:42:15 +1000 (EST)
Message-ID: <46A236FC.2080300@redhat.com>
Date: Sat, 21 Jul 2007 12:40:28 -0400
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>, viro@ftp.linux.org.uk
Subject: Re: [PATCH][12/37] Clean up duplicate includes in drivers/net/
References: <200707211702.46375.jesper.juhl@gmail.com>
In-Reply-To: <200707211702.46375.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: info@netxen.com, Patrick McHardy <kaber@coreworks.de>,
	Judy Fischbach <jfisch@cs.pdx.edu>, Luke Yang <luke.yang@analog.com>,
	bonding-devel@lists.sourceforge.net,
	Bryan Wu <bryan.wu@analog.com>, kong.lai@tundra.com,
	Jay Vosburgh <fubar@us.ibm.com>,
	James Morris <jmorris@namei.org>, linuxppc-embedded@ozlabs.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Alex V Lasso <a_villacis@palosanto.com>,
	Ulrich Kunitz <kune@deine-taler.de>,
	Chad Tindel <ctindel@users.sourceforge.net>,
	Amit S Kale <amitkale@netxen.com>, Jay Cliburn <jcliburn@gmail.com>,
	Samuel Ortiz <samuel@sortiz.org>, Brian Pugh <bpugh@cs.pdx.edu>,
	Daniel Drake <dsd@gentoo.org>, alexandre.bounine@tundra.com,
	Pantelis Antoniou <panto@intracom.gr>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Lukasz Stelmach <stlman@poczta.fm>, Ron Mercer <linux-driver@qlogic.com>,
	atl1-devel@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	James P Ketrenos <ipw2100-admin@linux.intel.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jesper Juhl wrote:
> Hi,
> 
> This patch cleans up duplicate includes in
> 	 drivers/net/
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/drivers/net/atl1/atl1_main.c b/drivers/net/atl1/atl1_main.c
> index fd1e156..4a18b88 100644
> --- a/drivers/net/atl1/atl1_main.c
> +++ b/drivers/net/atl1/atl1_main.c
> @@ -75,7 +75,6 @@
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/mii.h>
> -#include <linux/interrupt.h>
>  #include <net/checksum.h>
>  
>  #include <asm/atomic.h>

Define "duplicate".  I ask because this patch just got posted a few days ago:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
  drivers/net/atl1/atl1_main.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/atl1/atl1_main.c b/drivers/net/atl1/atl1_main.c
index 4a18b88..fd1e156 100644
--- a/drivers/net/atl1/atl1_main.c
+++ b/drivers/net/atl1/atl1_main.c
@@ -75,6 +75,7 @@
  #include <linux/compiler.h>
  #include <linux/delay.h>
  #include <linux/mii.h>
+#include <linux/interrupt.h>
  #include <net/checksum.h>

  #include <asm/atomic.h>

I've always been under the impression that one should include all the files 
whose contents you use directly, because other includes that happen to include 
them might no longer need to in the future and cease including them.  You can 
fight it out with Al if you feel like it.  I'm keeping the rest of the CC list 
because the other maintainers might have similar feelings about the 
appropriateness of these includes in their drivers.

	-- Chris
