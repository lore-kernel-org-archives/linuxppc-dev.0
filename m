Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5E3E6679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 03:15:27 +1000 (EST)
Date: Tue, 9 May 2006 10:15:20 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: Viable PPC platform?
Message-ID: <20060509171520.GA10886@gate.ebshome.net>
References: <e3q9gu$vq8$1@sea.gmane.org>
	<20060509174101.389c67c0.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060509174101.389c67c0.ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@ozlabs.org, geneSmith <gd.smth@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 09, 2006 at 05:41:01PM +0100, Alex Zeffertt wrote:
> On Tue, 09 May 2006 10:38:19 -0400
> geneSmith <gd.smth@gmail.com> wrote:
> 
> > I have a ppc405gpr system with 64M ram and 4Meg flash in a
> > AM29LV320. Is this a viable platform for linux? Can a filesystem
> > (JFFS2?) be put this flash type?
> > 
> 
> I would create an initrd and put every file that doesn't need
> to be changed persistently into it instead of JFFS2.

After many years of doing embedded Linux stuff I still don't 
understand why people are so fond of initrd.

For temporary stuff - tempfs is much better and flexible. For r/o 
stuff - just make separate MTD partition (cramfs, squashfs) and mount 
it directly as root. Both options will waste significantly less 
memory.

-- 
Eugene
