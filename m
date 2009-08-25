Return-Path: <to-fleischer@t-online.de>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 3C720B7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 03:09:10 +1000 (EST)
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Andy Fleming <afleming@gmail.com>
Subject: Re: gianfar.c: Unwanted VLAN tagging on TX frames
Date: Tue, 25 Aug 2009 19:08:55 +0200
References: <200908241810.54239.to-fleischer@t-online.de>
	<2acbd3e40908241632j7e9da3f7o7e11aa672838b9a5@mail.gmail.com>
In-Reply-To: <2acbd3e40908241632j7e9da3f7o7e11aa672838b9a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908251908.56308.to-fleischer@t-online.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 25 August 2009 at 01:32:18, Andy Fleming wrote:

>
> Hmmm....how have you tested this?  This looks like it has a bad race
> condition.  The TCTRL register applies to all packets, which means if you
> send a packet with VLAN tags, followed by one without, or visa versa,
> there's a reasonable chance that the second packet's VLAN tags (or lack
> thereof) will take precedence.
>
> Without speaking for the company, I suspect that this is just how the eTSEC
> works with VLAN -- all, or nothing.
>
> Andy

Hi Andy,

I have tested it by sending a single ping to a station within the VLAN 
followed by a ping to a station thats not in a VLAN.
OK, thats not really a significant test, because I did not send a VLAN tagged 
frame immediately followed by one without a tag.
You are right, this code can enable/disable VLAN  tagging before the previous 
packet is processed.

Torsten
