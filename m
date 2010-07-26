Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A647B6F04
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 07:38:06 +1000 (EST)
Date: Mon, 26 Jul 2010 14:37:04 -0700
From: Greg KH <gregkh@suse.de>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Message-ID: <20100726213704.GA16268@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12801701823001-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 11:49:41AM -0700, Fushen Chen wrote:
> This adds support for the USB host controller on APM SoC using
> Synopsys Designware IP.
> 
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>

Can I get some acks from the other developers who have worked on this
driver to verify that this version does indeed work, and that their work
has been integrated properly into the driver?

> --- /dev/null
> +++ b/drivers/usb/dwc_otg/dwc_otg_apmppc.c
> @@ -0,0 +1,408 @@
> +/*
> + * DesignWare HS OTG controller driver
> + *
> + * Author: Mark Miesfeld <mmiesfeld@apm.com>
> + *
> + * Based on versions provided by APM and Synopsis which are:
> + *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
> + * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
> + * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
> + * otherwise expressly agreed to in writing between Synopsys and you.

WTF?

Um, I think someone needs to rethink this submission, as this really
doesn't look like GPL code...

Oh, and where do I go get that "writing" between me and Synopsys to fix
this up?  :)

> + * The Software IS NOT an item of Licensed Software or Licensed Product under
> + * any End User Software License Agreement or Agreement for Licensed Product
> + * with Synopsys or any supplement thereto. You are permitted to use and
> + * redistribute this Software in source and binary forms, with or without
> + * modification, provided that redistributions of source code must retain this
> + * notice. You may not view, use, disclose, copy or distribute this file or
> + * any information contained herein except pursuant to this license grant from
> + * Synopsys. If you do not agree with this notice, including the disclaimer
> + * below, then you are not authorized to use the Software.

Same here, what is going on?

Has someone run this through the proper legal approval to make public?
If so, someone needs to go kick a lawyer.  If not, they just got in big
trouble...

> + * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> + * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundation,
> + * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


It's fun to just tack on the GPL boilerplate on a file, but when it
conflicts with other stuff in the same file, it kind of just makes us
all go crazy.

I can't take this at all, please go clean it up.

ick,

greg k-h
