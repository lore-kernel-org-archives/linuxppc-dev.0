Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4787E2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 05:49:43 +1100 (EST)
Message-ID: <41A234BD.1020207@mvista.com>
Date: Mon, 22 Nov 2004 11:49:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
References: <419E6900.5070001@mvista.com>
	<20041120162622.GA19099@infradead.org>
In-Reply-To: <20041120162622.GA19099@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:

>Just looking through this and you should share some more code with mips,
>e.g. the mavell register layout should move from asm-mips/marvell.h and
>your file to linux/marvell.h or something, especially as another ppc
>plattform (pegasosII) needs it aswell.  
>

Yes, and there is already include/linux/mv643xx.h that has a bunch of 
64340 definitions which share offset with the 64360 (and some with the 
64260).  However, to be correct, there needs to be a lot of munging.  
mv643xx.h should be renamed to mv64xxx.h and all of the MV64340 macros 
need to be renamed as well.  This ripples into the mips code which I 
didn't want to battle with right now.  I would prefer that this patch go 
in and then submit a separate patch that fixes and combines the hdr 
files & macros they contain.  Doing it that way, there is one patch for 
the ppc bridge support and one patch for the hdr file clean up.  That's 
cleaner than mixing the two (IMHO).  It is on the todo list.

Mark
