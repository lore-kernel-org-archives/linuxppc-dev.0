Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46961DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 18:26:45 +1000 (EST)
In-Reply-To: <1241641262-5202-6-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Message-ID: <OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 7 May 2009 10:26:40 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> This patch is NOT intended for inclusion into mainline, but rather a
> request for help. For some reason which I don't understand yet, the
> Ethernet interface on the ARIA board does not work in the default
> configuration, because MII probing fails.
> 
> What I'm seeing is this; the problem is with this part of code in
> "drivers/net/fs_enet/mii-fec.c":
> 
> 156         fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
> ...
> 163         out_be32(&fec->fecp->fec_mii_speed, fec->mii_speed);

Just a stab in the dark: Perhaps the fec->fecp->fec_mii_speed field is
misaligned or is 16 bits ?

   Jocke
