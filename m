Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id C8A8DDDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:19:00 +1100 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 16/16] Support for Ebony in arch/powerpc
References: <20070213061026.7979DDDDF0@ozlabs.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 13 Feb 2007 09:18:57 -0800
In-Reply-To: <20070213061026.7979DDDDF0@ozlabs.org> (David Gibson's message of
	"Tue, 13 Feb 2007 17:10:26 +1100 (EST)")
Message-ID: <adabqjym0vy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 >  config 440GP
 >  	bool
 >  	depends on EBONY
 > -	default y
 > +	select IBM_NEW_EMAC_ZMII
 > + 	default y

Maybe we could take this opportunity to clean up the CPU selection in
Kconfig and use select instead... right now we have a mess like

config 440GP
        bool
        depends on EBONY
        default y

config 440
        bool
        depends on 440GP || 440SP || 440SPE || 440EP
        default y

etc... -- it would be nice for this to look like

config EBONY
	bool
	select 440GP

config 440GP
	bool
	select IBM_NEW_EMAC_ZMII
	select 440

config 440
	bool

I'm happy to do this cleanup after things settle down though
