Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B6D632C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 14:42:19 +1000 (EST)
Message-ID: <1375332127.3743.51.camel@pasglop>
Subject: Re: [PATCH 4/5] powerpc/powernv: Pick up correct number of PEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 01 Aug 2013 14:42:07 +1000
In-Reply-To: <20130801042446.GA5540@shangw.(null)>
References: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1375260424-20777-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1375262326.3743.4.camel@pasglop> <20130801042446.GA5540@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-01 at 12:24 +0800, Gavin Shan wrote:
> at correct ? Don't we get the total number of PEs from a config
> >register on the bridge ? I didn't think the IODA architecture specified
> >the total number of PE of a given implementation...
> >
> 
> For now, the firmware has fixed values (1/128/256), which isn't figured
> out from EEH capability register. That might be something to do later
> for the f/w.

Sure but we can fix the firmware easily, we need per-chip code in there
anyway, while in Linux, we mostly avoid exposing the specifics of a
given implementation of the architecture, we only expose the
architectural version (IODA1 vs IODA2).

> >For example, does Torrent implement 128 ?
>
> 
> I don't know what's "Torrent" :-)

It's one of our IO chips for P7 :-) It has a built-in HFI (sort-of
infiniband thingy) and implements PCIe slots with IODA1. It has *some*
differences to P7IOC however.

> >I'd rather stick to safe here, if the firmware doesn't say, just use
> >one.
> >
> >Now some of the PHB registers are actually architected in IODA afaik, so
> >we could just go look but let's not make a precedent here.
> >
> 
> Ok. Thanks, Ben. Please drop this one :-)

Will do :-)

Cheers,
Ben.
