Return-Path: <michael@ellerman.id.au>
Message-ID: <1339120842.3330.2.camel@concordia>
Subject: Re: [PATCH] Disable /dev/port interface on powerpc systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Fri, 08 Jun 2012 12:00:42 +1000
In-Reply-To: <1332577383.19329.5.camel@hbabu-laptop>
References: <1332308237.23222.49.camel@hbabu-laptop>
 <1332314613.2982.38.camel@pasglop> <1332577383.19329.5.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-03-24 at 01:23 -0700, Haren Myneni wrote:
> Ben, Here it is the updated patch based on your suggestions. Please let
> me know if it has any issues.
> 

This breaks the i386 defconfig build with:

drivers/char/mem.c:903:3: error: implicit declaration of function
'arch_has_dev_port' [-Werror=implicit-function-declaration]


I think because that file includes <asm/io.h> directly, not via
include/linux/io.h, so your stub is never seen.

cheers
