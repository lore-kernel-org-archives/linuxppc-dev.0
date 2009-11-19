Return-Path: <alonz@discretix.com>
Received: from mail.discretix.com (mail.discretix.com [192.116.217.178])
	by ozlabs.org (Postfix) with SMTP id 12DC81007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 23:57:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
Date: Thu, 19 Nov 2009 14:57:15 +0200
Message-ID: <8B957E110B62714A84290A01A597805F05D2AE38@Exchange.discretix.com>
In-Reply-To: <56a3f016-525a-4eb2-9a0f-1477ea2eee91@VA3EHSMHS019.ehs.local>
References: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com>
	<56a3f016-525a-4eb2-9a0f-1477ea2eee91@VA3EHSMHS019.ehs.local>
From: "Alon Ziv" <alonz@discretix.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Cc: John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Monday, November 16, 2009, Stephen wrote:
> There are at least two other ways that you might be able to reset a
> board:
> 1) Internally through the ICAP device.
> 2) Through a GPIO connected externally to the reset logic.
>=20

Unfortunately none of these is relevant for the specific board in
question (Xilinx ML510 reference system)...

> Probably it would be best to have a mechanism in the device tree which
> references the reset mechanism?

I am sorely lacking in expertise for this :(, and wouldn't even know
where to begin...  Is it possible at all to add custom information into
the device tree?  And even if yes--how will platform code bind to the
reset mechanism?

> [...] In any event, you probably don't want a driver to
> eplicitly reference the plaform code.  If you want to do it explicitly
> like this, it would better to have the plaform code reference the
driver
> mechanism.

I don't see how this can be done: if the driver is to publish some
"driver_reset_system" function to the platform code, it needs _some_
mechanism for telling this fact to the system...  And such a mechanism
won't look all that different from my callback, IMO (except it may be
slightly prettied up).
Of course, one obvious thing that must be done is move this code out of
arch/powerpc/platforms/44x/virtex.c and into (e.g.)
arch/powerpc/kernel/setup-common.c, and add some
"set_machine_restart_function" wrapper to access it more cleanly (also
defining this function as a null function when inapplicable).  If this
satisfies your standards, I can easily post an updated patch :)

-az
*************************************************************************=
*********************
IMPORTANT: The contents of this email and any attachments are confidentia=
l. They are intended for the=20
named recipient(s) only.
If you have received this email in error, please notify the system manage=
r or the sender immediately and do=20
not disclose the contents to anyone or make copies thereof.
