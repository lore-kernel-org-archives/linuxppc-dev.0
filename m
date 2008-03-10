Return-Path: <djwong@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B67EDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 05:13:46 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2AIDLUI024416
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 14:13:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2AIDK3d191544
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 12:13:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2AIDKrc010172
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 12:13:20 -0600
Date: Mon, 10 Mar 2008 11:13:19 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: ADT746X: logical-bitwise & confusion in set_max_duty_at_crit()
Message-ID: <20080310181319.GA7500@tree.beaverton.ibm.com>
References: <47D47B11.1000303@tiscali.nl>
	<20080310084633.5246ecfe@paperstreet.colino.net>
	<1205136413.8621.3.camel@pasglop> <47D4EFC1.1050403@tiscali.nl>
	<64d5b5e6dfd0d1820d21db323ef88e25@kernel.crashing.org>
	<47D5068F.8050709@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47D5068F.8050709@tiscali.nl>
Cc: Colin Leroy <colin@colino.net>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 10, 2008 at 10:59:43AM +0100, Roel Kluin wrote:

> > The & 0xff here is bogus anyway; temp is only ever used as an u8,
> > so just declare it as that, or do proper overflow/underflow checking
> > on it.  The patch will need testing on hardware too, since it changes
> > behaviour (it should be a bugfix, but who knows).
> 
> Maybe someone can test this?

I did.  No regressions observed and it fixes that bug as well.  Sorry I
didn't catch it earlier... :/

Acked-by: Darrick J. Wong <djwong@us.ibm.com>

--D
