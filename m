Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id A2F1ADDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 04:31:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so530667anc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 09:31:21 -0800 (PST)
Message-ID: <fa686aa40711230931u37163c3fvefd043d988d0cab8@mail.gmail.com>
Date: Fri, 23 Nov 2007 10:31:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: ML403 USB driver
In-Reply-To: <87lk8pdzcw.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <13858912.post@talk.nabble.com>
	<87lk8pdzcw.fsf@macbook.be.48ers.dk>
Cc: Lorenz Kolb <linuxppcemb@lkmail.de>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

I've done a bunch more work on the host side of the c67x00 driver.
I'd like to try and get it into 2.6.25.  I'm planning to post a
cleaned up set of patches to the usb-list this afternoon for review.

However, the change set between what you posted and what I have now is
quite large so I've also pushed my incremental patch set to my git
tree so you can see how it has changed from your original patchset.

(BTW, ignore the last patch in the series; that was for
experimentation only and it won't be in the cleaned up patchset)

You can see the tree at:
http://git.secretlab.ca/git/gitweb.cgi?p=linux-2.6-virtex.git;a=shortlog;h=virtex-c67x00-dev

Or you can pull from:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-c67x00-dev

Grant Likely (17):
      [C67x00] Fix calculation of frame bandwidth
      [c67x00] Remove unnecessary references to pt_regs
      [C67x00] Added error handling paths to lowlevel interface code
      [C67x00] Change 'struct c67x00_drv' to 'struct c67x00_device'
      C67x00: Add registration banner
      [C67x00] Merge c67x00-hub.c into c67x00-hcd.c
      C67x00: fixes for 2.6.24
      c67x00: consolidate header files
      C67x00: Eliminate done list lock
      c67x00: Fix incorrectly handled error path.
      c67x00: Tighten up error paths
      c67x00: Fix race condition in ll_start()
      c67x00: eliminate unnecessary INIT_COMPLETION() in low level interface.
      c67x00: Use an inline function instead of #define for dbg_td
      c67x00: Fix manipulation of urb_iso_count
      c67x00: fix unnecessary list_for_each_entry_safe()
      c67x00: eliminate done tasklet

Peter Korsgaard (4):
      [C67x00] Make usb_hcd_irq work for multi-role USB controllers w/
shared irq
      [C67x00] Base support for the Cypress c67x00 multi-role USB controllers
      [C67x00] HCD support for Cypress c67x00
      [C67x00] Gadget support for Cypress c67x00

 drivers/usb/Kconfig                |    2 +
 drivers/usb/Makefile               |    2 +
 drivers/usb/c67x00/Kconfig         |   22 +
 drivers/usb/c67x00/Makefile        |   15 +
 drivers/usb/c67x00/c67x00-drv.c    |  301 +++++++++
 drivers/usb/c67x00/c67x00-hcd.c    |  390 ++++++++++++
 drivers/usb/c67x00/c67x00-hcd.h    |  162 +++++
 drivers/usb/c67x00/c67x00-ll-hpi.c |  512 ++++++++++++++++
 drivers/usb/c67x00/c67x00-sched.c  | 1188 ++++++++++++++++++++++++++++++++++++
 drivers/usb/c67x00/c67x00-udc.c    |  166 +++++
 drivers/usb/c67x00/c67x00-udc.h    |   59 ++
 drivers/usb/c67x00/c67x00.h        |  236 +++++++
 drivers/usb/core/hcd.c             |    6 +-
 drivers/usb/gadget/Kconfig         |    7 +
 include/linux/usb/c67x00.h         |   45 ++
 15 files changed, 3112 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/c67x00/Kconfig
 create mode 100644 drivers/usb/c67x00/Makefile
 create mode 100644 drivers/usb/c67x00/c67x00-drv.c
 create mode 100644 drivers/usb/c67x00/c67x00-hcd.c
 create mode 100644 drivers/usb/c67x00/c67x00-hcd.h
 create mode 100644 drivers/usb/c67x00/c67x00-ll-hpi.c
 create mode 100644 drivers/usb/c67x00/c67x00-sched.c
 create mode 100644 drivers/usb/c67x00/c67x00-udc.c
 create mode 100644 drivers/usb/c67x00/c67x00-udc.h
 create mode 100644 drivers/usb/c67x00/c67x00.h
 create mode 100644 include/linux/usb/c67x00.h


Cheers,
g.

On 11/23/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Lorenz" == Lorenz Kolb <linuxppcemb@lkmail.de> writes:
>
>  Lorenz> Hi,
>
>  Lorenz> we just tried the USB driver (from Peter Korsgaard) from
>  Lorenz> Grant's virtex tree.
>
>  Lorenz> Nevertheless we could not get the peripheral ports work as gadgets.
>  Lorenz> Has anyone tried (and probably fixed) that before?
>
> My driver so far only has host support. I'm working on the peripheral
> support (or rather, a colleage of mine is) but it's quite early days
> ..
>
>  Lorenz> Anyway, only one of the two peripheral ports seems to be active.
>
> The Linux gadget stack only support a single peripheral port.
>
> --
> Bye, Peter Korsgaard
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
