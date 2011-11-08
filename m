Return-Path: <miche@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 52D411007D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 08:45:21 +1100 (EST)
Subject: [PATCH RFC v3 0/3] Support multiple VirtioConsoles.
To: Greg Kroah-Hartman <gregkh@suse.de>
From: Miche Baker-Harvey <miche@google.com>
Date: Tue, 08 Nov 2011 13:44:53 -0800
Message-ID: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>,
 Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eric Northrup <digitaleric@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Amit pointed out that the patches never went out. This was a resend of
the series meant to go out on 11/2/2011; Now it's a resend of the mail this
morning, with everyone copied on the same mail.  So sorry for the spam!
This is v3.)

This patchset applies to linux-next/next-20111102.

This series implements support for multiple virtio_consoles using KVM.

This patchset addresses several issues associated with trying to
establish multiple virtio consoles. 

I'm trying to start a guest via KVM that supports multiple virtual
consoles, with getty's on each, and with some being console devices.

These patches let me establish more than one VirtioConsole (I'm
running eight at the moment), and enable console output appearing on
one of them.  It still doesn't successfully generate console output on
multiple VirtioConsoles.

Let me apologise for my last patch having gotten into Linus' tree, and
leaving other people to deal with crashes.  I had meant to be asking
for guidance, but I didn't mark it as "RFC".

This series reflects the input from Konrad Rzeszutek, Amit Shah, Stephen
Boyd, and Rusty Russell.  I think we do have to limit hvc_alloc() to one
thread.

I would appreciate any comments or feedback, or accept if appropriate.

Thanks,
Miche Baker-Harvey

---

Miche Baker-Harvey (3):
      virtio_console:  Fix locking of vtermno.
      hvc_init():  Enforce one-time initialization.
      Use separate struct console structure for each hvc_console.


 drivers/char/virtio_console.c |    9 ++++++---
 drivers/tty/hvc/hvc_console.c |   33 +++++++++++++++++++++++++++++++--
 drivers/tty/hvc/hvc_console.h |    1 +
 3 files changed, 38 insertions(+), 5 deletions(-)

-- 
