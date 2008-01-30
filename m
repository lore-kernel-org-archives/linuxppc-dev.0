Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 1E9C8DDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 04:04:26 +1100 (EST)
Date: Wed, 30 Jan 2008 18:04:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD FAILURE] 2.6.24-git7 section type conflict at various
	drivers on powerpc
Message-ID: <20080130170417.GA24386@uranus.ravnborg.org>
References: <47A0A3AF.5050005@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47A0A3AF.5050005@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 09:49:59PM +0530, Kamalesh Babulal wrote:
> Hi,
> 
> Following are the different build failure with 2.6.24-git7 kernel on the powerpc
> 
> drivers/net/typhoon.c:181: error: typhoon_card_info causes a section type conflict
> make[2]: *** [drivers/net/typhoon.o] Error 1
> 
> drivers/net/natsemi.c:259: error: natsemi_pci_info causes a section type conflict
> make[2]: *** [drivers/net/natsemi.o] Error 1
> 
> drivers/net/bnx2.c:95: error: board_info causes a section type conflict
> make[2]: *** [drivers/net/bnx2.o] Error 1
> 
> drivers/net/via-velocity.c:454: error: velocity_id_table causes a section type conflict
> make[2]: *** [drivers/net/via-velocity.o] Error 1

A quick look told me that they are all caused by const data
annotated with __devinitdata.
Try replacing all annotations of const variables
from __devinitdata to __devinitconst.

	Sam
