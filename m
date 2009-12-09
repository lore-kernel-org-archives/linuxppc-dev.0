Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7539FB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 02:36:48 +1100 (EST)
Date: Wed, 9 Dec 2009 10:36:45 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Increase warp SD buffer
Message-ID: <20091209103645.01058e79@opus.seanm.ca>
In-Reply-To: <20091209144055.GS2937@zod.rchland.ibm.com>
References: <20091209000437.78794a8f@opus.seanm.ca>
	<20091209144055.GS2937@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Dec 2009 09:40:55 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> How does that impact the older revisions?  You're using a cuImage
> with Warp, so the device tree is bundled with that.  If you boot a
> new kernel with this change to the DTS on a older board revision,
> will it do bad things?

The new SD driver takes care of that. If you use the new kernel with an
old FPGA you reserve more space than you need, but the driver will not
touch it.

And if you somehow end up with the new DTS on an older kernel, the old
SD driver will not use the space anyway since the buffer is limited to
one block.

The SD driver is not in the kernel proper because it was implemented in
the FPGA and has a non-standard interface. It requires a change to the
SD core to run. But it is GPLed, so if anybody wants to see it, just
ask.

Cheers,
    Sean
