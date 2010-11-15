Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17E03B7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 04:53:27 +1100 (EST)
Received: from mail125-tx2 (localhost.localdomain [127.0.0.1])	by
	mail125-tx2-R.bigfish.com (Postfix) with ESMTP id 00A35940124	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 15 Nov 2010 17:53:16 +0000 (UTC)
Received: from TX2EHSMHS027.bigfish.com (unknown [10.9.14.248])	by
	mail125-tx2.bigfish.com (Postfix) with ESMTP id A74725E8053	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 15 Nov 2010 17:53:15 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oAFHrD7D026546	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 10:53:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAFHrDSo004486	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 11:53:13 -0600 (CST)
Date: Mon, 15 Nov 2010 11:53:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
Message-ID: <20101115115311.72429aa9@udp111988uds.am.freescale.net>
In-Reply-To: <72D46FED-AFC8-4599-ADB0-2A2B634CCE48@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
	<AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
	<3B38AD35-39A2-4A54-8109-65D6DE436227@kernel.crashing.org>
	<AANLkTin8+13mr-tV-2iCG+zGRfF6xZ23cN+=44dsaQor@mail.gmail.com>
	<72D46FED-AFC8-4599-ADB0-2A2B634CCE48@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Timur Tabi <timur.tabi@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 Nov 2010 11:43:12 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Nov 15, 2010, at 10:13 AM, Timur Tabi wrote:
> 
> > On Mon, Nov 15, 2010 at 9:16 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> > 
> >> The programming model (if you look at the free-space in the registers and data structures) supports a 64-bit address.  I'm trying to avoid changing the driver in the future if we have >36-bit.  However this is such a minor worry that I'll stop and just ack the patch as is.
> > 
> > I must still be missing something.  I'm looking at the description of
> > the SATR register in the MPC8572 RM, and it shows this:
> > 
> > 0 - 3 |   4 - 5   |     6     |   7  |   8 - 11  |   12 - 15  | 16-21 | 22-31
> > ---  | STFLOWLVL | SPCIORDER | SSME | STRANSINT | SREADTTYPE |  ---  |  ESAD
> > 
> > The most that we can extend ESAD to is 16 bits, for a total of a
> > 48-bit physical address.  Where are the other 16 bits supposed to go?
> 
> I was looking at the link addresses.  I stand corrected so our max is 48-bits.

Looks like 42 bits -- just because bits 16-21 could be used to extend
ESAD doesn't mean that they have been.

-Scott
