Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 4D0E4679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jul 2006 16:52:23 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so3101425ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 09 Jul 2006 23:52:21 -0700 (PDT)
Message-ID: <528646bc0607092352j4c5d2bdagd1d03169f4edc042@mail.gmail.com>
Date: Mon, 10 Jul 2006 00:52:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sass, Ronald" <rsass@uncc.edu>
Subject: Re: linux-2.6.17.4 and Xilinx Virtex
In-Reply-To: <1A3FF4C9782A1249BDFC2FF2B5749C98150E1100@EXEVS01.its.uncc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1A3FF4C9782A1249BDFC2FF2B5749C98150E1100@EXEVS01.its.uncc.edu>
Cc: rsass@ittc.ku.edu, linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Let's move this conversation over to the linuxppc-embedded mailing list

On 7/8/06, Sass, Ronald <rsass@uncc.edu> wrote:
>
> Hello Grant,
>
>  I noticed that somewhere between 2.6.11 and 2.6.17 you started
>  adding support to the Linux kernel for some Virtex-* based boards
>  to the Linux kernel.  I've got some hacked up kernel mods for the
>  ML-310 (and soon) ML-410 boards that I am trying to clean up for
>  sharing.  I've never directly contributed to the kernel, so all of
>  this is new to me.  I had a couple of questions about the direction
>  you are taking:

I've got some things that I still need to clean up.  As it stands
right now, I've done some brain-dead stuff with the ppc_sys
infrastructure which I really should fix.

>
>  (1)  I noticed that you restructured
> arch/ppc/platforms/4xx/xparameters
>       to support multiple boards.  That's cool.  Do you use XPS/EDK to
>       update these files or do you just change the xparameters.h `by
>       hand' for each base system?

No; unfortunately EDK does not support generating a BSP for linux 2.6.
 I generate a 2.4 bsp into a clean directory and then copy
xparameters_ml300.h into the 2.6 tree.

>  (2)  I also noticed that the CONFIG_XILINX_VIRTEX_II_PRO (and files
>       arch/ppc/platforms/4xx/virtex_ii_pro.[ch]) changed to
> be just
>       CONFIG_XILINX_VIRTEX (and
> arch/ppc/platforms/4xx/virtex.[ch]).
>       Is this change intended to be more generic to support V2P,
>       V-4, and V-5 devices?

Yes

>  (3)  I also noticed that even though CONFIG_XILINX_VIRTEX was added,
>       the option CONFIG_XILINX_VIRTEX_II_PRO is still in the .config
>       file.  As far as I can tell, the "VIRTEX_II_PRO" option is not
>       referenced in the source.  Should it be removed?

I don't think so; but others may disagree.  The macro is convenient
for determining exactly which virtex part is being compiled for.  Plus
it give a clean dependancy hierarchy from board->part->part family.  I
left it in as a mirror to the XILINX_VIRTEX_4 macro which is in use.

>
>  Thanks for taking the initative here!  Do you know, is there anyone
>  else trying to formally incorporate Xilinx boards into the stock
>  kernel.org source tree?

I hear rumors that MontaVista will be merging their virtex-II/virtex-4
support into mainline real-soon-now.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
