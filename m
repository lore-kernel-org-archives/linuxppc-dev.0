From: Paul Mackerras <paulus@linuxcare.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Michael Meissner <meissner@cygnus.com>
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
Date: Tue, 29 Feb 2000 11:49:03 +1100
Content-Type: text/plain
Cc: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
References: <38BAF958.E31D88A3@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <00022911542401.10645@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Feb 2000, Jeff Garzik wrote:

> That is the crux of the matter....   In the PPC arch, size_t is
> unconditionally the same whether you have a 32-bit or 64-bit procesor...

Well, no... unsigned long is 32 bits wide when compiling for 32-bit
machines, 64 bits wide when compiling for 64-bit machines.

Anyway, I have caved in and put the following ugliness in
asm-ppc/posix-types.h:

#include <linux/config.h>	/* for CONFIG_PPC64 */

[snip]

/* Grrr... gcc thinks size_t is unsigned int, so we either
   have to have this nonsense or use -fno-builtin. - paulus */
#ifdef CONFIG_PPC64
typedef unsigned long	__kernel_size_t;
typedef long		__kernel_ssize_t;
#else
typedef unsigned int	__kernel_size_t;
typedef int		__kernel_ssize_t;
#endif /* CONFIG_PPC64 */

My linuxcare.com.au::linux-pmac-devel rsync tree is now up to 2.3.48, BTW.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
