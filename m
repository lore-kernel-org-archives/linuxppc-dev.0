Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 856E9679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 08:47:47 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <wd@denx.de>
Date: Sun, 8 May 2005 00:47:38 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEJOCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050507183913.A7238C1512@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: How to fix 8xx dcbst bug? 
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> In message <JPEALJAFNGDDLOPNDIEECEAKDDAA.joakim.tjernlund@lumentis.se> you wrote:
> >
> ...
> > safe, just look at ld.so. This should not be a requirement but for 8xx it is currently and I think 8xx gets
> > away with it because nobody is using swap on 8xx.
> 
> I understand that the "not using swap" refers to 2.6 kernel only, right?
> 
> Because on 2.4, we use swap on several systems quite heavily. I  have
> to admit that we had to patch pgtable.h to get it work.

I was once told by a senior kernel hacker(Dan?) that using swap could make an already
populated pte invalid. This was for 2.4 kernels.

ldso uses dcbst and icbi heavly during relocation but always after doing a store to the
address in question. That will make sure that if dcbst/icbi causes a TLB Miss, it will be
a simple/regular TLB miss not requiring any special handling i fault.c

Perhaps using dcbst/icbi in this way will not make the pte go away between the store and the
dcbst/icbi instructions when also using swap. Someone more exprienced will have to answer that.

 Jocke
