Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 8E832B7D5D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:51:46 +1000 (EST)
Received: by pwj6 with SMTP id 6so1159873pwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 09:51:44 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272384698-4359-2-git-send-email-agust@denx.de>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
	<1272384698-4359-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 10:51:21 -0600
Message-ID: <u2gfa686aa41004270951o9a225091k1f68a7bf34f2972a@mail.gmail.com>
Subject: Re: [PATCH 1/4] powerpc/fsl_soc.c: prepare for addition of mpc5121
	USB code
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 10:11 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Factor out common code for registering a FSL EHCI platform
> device into new fsl_usb2_register_device() function. This
> is done to avoid code duplication while adding code for
> instantiating of MPC5121 dual role USB platform devices.
> Then, the subsequent patch can use
> for_each_compatible_node(np, NULL, "fsl,mpc5121-usb2-dr") {
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0fsl_usb2_register_device();
> }
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0arch/powerpc/sysdev/fsl_soc.c | =A0231 +++++++++++++++++++------------=
---------

Hi Anatolij,

Thanks for this work.  However, I've got concerns.

Forgive me for ragging on code that you didn't write, but this
fsl_soc.c code for registering the USB device really doesn't belong
here anymore.  It should be part of the drivers/usb/host/ehci-fsl.c
and the driver should do of-style binding (Which should be a lot
easier if I manage to get the merge of platform bus and of_platform
bus into 2.6.35).

This patch series makes the fsl_soc.c code even more complicated, and
scatters what is essentially driver code over even more places in the
arch/powerpc tree.  I'm really not keen on it being merged in this
form.

g.
