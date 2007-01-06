Return-Path: <SRS0+fef3928c67572704aad8+1231+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32292DDE02
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jan 2007 10:12:57 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: David Woodhouse <dwmw2@infradead.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 07:13:09 +0800
Message-Id: <1168125190.24110.67.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: bbrv@genesi-usa.com, Paul Mackerras <paulus@samba.org>,
	Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-01-06 at 15:23 -0700, Grant Likely wrote:
> 2. Dwmw2 says that reading the HD has an off-by-one showstopper bug
> which prevents Linux from reading the partition table (and that it is
> the same bug that was on the pegasos, but is now fixed).

It's an off-by-one in partition table numbering. When we ask for
"hd:0" (the whole disk) we get "hd:1", and so on. It screws yaboot's
partition table scan, because when it asks for the first sector of the
disk it's given the first sector of the first partition.

Something very similar to this already got fixed on Pegasos after I
reported it -- and I didn't think it was _particularly_ far-fetched for
me to expect the Efika firmware to be adapted to the "definitions, whims
and determinations" of the CHRP specification too.

> I have not confirmed this issues as I don't have a working HD on my
> Efika.  However, dwmw2 has stated that he cannot support the Efika in
> Fedora until this issue is resolved. 

"Cannot" is a strong word when you're talking about software -- and is
almost always untrue. I think what I said was "can't sensibly", which
makes a lot more sense.

I've got a locally-hacked yaboot which works around it enough to boot my
system, but I'm not going to get far if I suggest that we ship a
different copy of the boot loader just for Efika "because it's speshul".
Especially when the bug was known so long ago.

I think the workaround on Pegasos was to use Amiga partitions, and to
hack (perhaps even unintentionally) the Amiga partition code in yaboot
to compensate for the brokenness. So the Amiga partition code probably
won't work on CHRP-compatible machines, while the rest of the partition
code won't work on Efika/oldPegasos. I baulked at the idea of continuing
this hack by using Amiga partitions on Efika too, and preferred to put
the thing back on the shelf and wait for it to be fixed -- especially as
I'm away for the rest of the month anyway.

-- 
dwmw2
