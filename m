Message-ID: <3ECBD7DF.2080609@mrv.com>
Date: Wed, 21 May 2003 22:47:43 +0300
From: Eran Mann <emann@mrv.com>
MIME-Version: 1.0
To: digitalRNA <horizonprits@yahoo.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot-0.3.0 + Linux boot failed on walnut
References: <3ECBB43B.2000601@yahoo.co.jp>
In-Reply-To: <3ECBB43B.2000601@yahoo.co.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


digitalRNA wrote:
> Hello,
>
> Now I am trying to boot Linux using u-boot-0.3.0 not openbios on walnut.
> But it failed.
> It looks failed around timer initialization on vmlinux.
> But in the case of openbios, the Linux can boot.
> Are there any information about this issue?
<snip>
Last time I checked the Walnut support code in linuxppc_2_4_devel and
linuxppc_2_5 assumed OpenBIOS board_info structure and not
U-Boot/PPCBoot board_info structure. The result is that the kernel took
the first 4 bytes of the Ethernet address passed from U-Boot as the
memory size, which ofcourse made the MM code quite unhappy later on ;-)

The brute-force solution is to replace the definition of the struct in
walnut.h (which is in arch/ppc/platforms/4xx in 2.5 and in
arch/ppc/platforms in 2.4_devel)

typedef struct board_info {
...
} bd_t;

with:
#include <asm/ppcboot.h>

The non-brute-force solution is of course to do it based on #ifdef
CONFIG_USE_PPCBOOT or something like that. Unfortunately this
configuration option does not exist in 2.5 .

--
Eran Mann
Senior Software Engineer
MRV International
Tel: 972-4-9936297
Fax: 972-4-9890430
www.mrv.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
