Return-Path: <LeoLi@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF560B713C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 19:48:20 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6513DDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 19:48:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5B9lxKW014296
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 02:48:09 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5B9lviA006717
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 04:47:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/6] rapidio: add common mapping APIs for RapidIO memory
	access
Date: Thu, 11 Jun 2009 17:47:56 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED483CCD@zch01exm26.fsl.freescale.net>
In-Reply-To: <90AED712-28A1-4800-978C-125A887D0DA7@kernel.crashing.org>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<90AED712-28A1-4800-978C-125A887D0DA7@kernel.crashing.org>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Zhang Wei <zw@zh-kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On May 12, 2009, at 3:35 AM, Li Yang wrote:
>
>> Add the mapping functions used to support direct IO memory access of=20
>> rapidIO.
>>
>> Signed-off-by: Zhang Wei <zw@zh-kernel.org>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>
>Use inbnd/outbnd instead of inb/outb which make one think of=20
>byte level io accessors.
>
>As I look at this I don't think this is the correct API.  I=20
>think we should be using the DMA mapping API to hide these=20
>details.  The concept of mapping like this seems to be more a=20
>function of FSL's Address translation/mapping unit (ATMU) than=20
>anything specific to the RIO bus standard.

This is a separate RIO block level ATMU.  Although it looks like the
system level ATMU, system ATMU doesn't have the knowledge of rapidIO
target device ID.  The mapping need to be dynamic, as it's easy to have
more RIO devices than the outbound windows.

- Leo
