Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5216B67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 21:17:21 +1000 (EST)
Date: Thu, 31 Mar 2005 03:17:19 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Li Yang-r58472 <LeoLi@freescale.com>
Message-ID: <20050331111718.GA31467@gate.ebshome.net>
References: <9FCDBA58F226D911B202000BDBAD46730117355F@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730117355F@zch01exm40.ap.freescale.net>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 04:22:26PM +0800, Li Yang-r58472 wrote:
> Good point.
> There is also IMMR need to be passed from bootloader to kernel.  We 
> can make more use of the u-boot bd_info mechanism.  But it binds ppc 
> linux to u-boot boot loader.  I don't know if we should make it a 
> porting convention.

Well, immr is _already_ part of bd_t passed from U-Boot! I was 
surprised that none of board ports (some of which are made for U-Boot 
only) use this. 

In 8248 based board port I'm working on right now, I already defined 
CPM_MAP_ADDR as follows:

#define CPM_MAP_ADDR            (((bd_t*)__res)->bi_immr_base)

--
Eugene
