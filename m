Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2011FDE3D9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:44:37 +1100 (EST)
Date: Wed, 7 Jan 2009 15:44:34 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: mal_probe crash
Message-ID: <20090107154434.0c9437ef@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With Linus' latest git, mal_probe crashes. It calls netif_napi_add with
the first parameter NULL. This was ok since the parameter, a net
device, was only used if CONFIG_NETPOLL was set.

Now it is always de-referenced. A quick check shows that ibm_newemac is
the only driver that passed NULL as the first parameter to this call in
2.6.28.

I don't really follow ibm_newemac changes, so the patch may be waiting
to be applied. This is really just a heads up.

Cheers,
   Sean
