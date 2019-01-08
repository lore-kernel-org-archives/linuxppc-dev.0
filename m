Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B20C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 04:03:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A13B2087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 04:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aqmzHBbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A13B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ydst1NQhzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 15:03:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.b="aqmzHBbv"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YdqL4bDDzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 15:01:32 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id r136so1237240pfc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 20:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hI3HFiiQiOBTLixuPxZ9I+eYojMS0YjMnMKMa+vFZv0=;
 b=aqmzHBbvoLVOt7Kzd0jPRPAXuG0MwgDzU65fDYLm0mvdSLfTYsGF/j5wjnjs66hAMy
 3SkmSAYSBAEMLq/Z1oHm/cHUXTbrjipWjnnT4yig3mAZdNbXf1UgnVbG6P+VV2gb8SgI
 hN5fF0DVkSi1e8TLsQV6Bo5BcDEODI8r7HNLU98uaeNKI6iymOkd7Hn6us+oGui1cjkS
 8hlxeLMeV8tZvOxTgTSIDOeJhKtYX7Rn2A2ybKszGIbWZRspawStiEfEs78uThE9JKya
 b0Kjx5Z2Frg2AJUyLdloUVN0BGGOTuzFi/HPKdxI/pHTE96zgHlCzbtTJ9d2yehubXR8
 PypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hI3HFiiQiOBTLixuPxZ9I+eYojMS0YjMnMKMa+vFZv0=;
 b=Dmj8ovsg2Dun+qEPteIlg/fynX1F37LMhu5CY5kkg2etJrtMlIiA0xnyt+8bjFNJ+8
 L2XUF96/gdfl9SDX0EPe/wsrfHFKkkMDND1zy8zyHyLW3d9sUE8Gc8WSb/lkEQRIIiwG
 Tq1VfZ64YUUlJTGMysd1mZSoeYlSaofGavtb9pgw8qJ0x+ONMCQcFp+Br6PiA4jJJHp0
 MppxX/8LmExEO/4rvHUHsTTEOdo4rdm4CXu7H0hFetE4hUWSAH3qmXxeQ2wY9Z4Ho7Fj
 gRI8YFQjntqiZB2O/Ap5z+Qx6KA4PuzEzmWD0yL+JHU05F60gZTz9CvXrg+0PJvdhwYR
 To5A==
X-Gm-Message-State: AJcUukdbRTnL0q4sYMovCG5UlKRwB8LjIcjIRLqO3INwgtB/bzWuB9eM
 p35xt/jVxWJAN8ExuHhD9qUZ3Q==
X-Google-Smtp-Source: ALg8bN5lzQ0TEnC4tGM2QWkSvlrK0kiKtDXVTjW+AYsWMmHGaLKZPdjkTUkbSM05fVQOqZwN2LmacQ==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr135492pgo.223.1546920090935; 
 Mon, 07 Jan 2019 20:01:30 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
 by smtp.gmail.com with ESMTPSA id
 g15sm298482974pfj.131.2019.01.07.20.01.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 20:01:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1ggia1-0007HO-C7; Mon, 07 Jan 2019 21:01:29 -0700
Date: Mon, 7 Jan 2019 21:01:29 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20190108040129.GE5336@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box>
 <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sbest@redhat.com,
 saeedm@mellanox.com, alex.williamson@redhat.com, paulus@samba.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, ogerlitz@mellanox.com,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jan 06, 2019 at 09:43:46AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2019-01-05 at 10:51 -0700, Jason Gunthorpe wrote:
> > 
> > > Interesting.  I've investigated this further, though I don't have as
> > > many new clues as I'd like.  The problem occurs reliably, at least on
> > > one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
> > > I don't yet know if it occurs with other machines, I'm having trouble
> > > getting access to other machines with a suitable card.  I didn't
> > > manage to reproduce it on a different POWER8 machine with a
> > > ConnectX-5, but I don't know if it's the difference in machine or
> > > difference in card revision that's important.
> > 
> > Make sure the card has the latest firmware is always good advice..
> > 
> > > So possibilities that occur to me:
> > >   * It's something specific about how the vfio-pci driver uses D3
> > >     state - have you tried rebinding your device to vfio-pci?
> > >   * It's something specific about POWER, either the kernel or the PCI
> > >     bridge hardware
> > >   * It's something specific about this particular type of machine
> > 
> > Does the EEH indicate what happend to actually trigger it?
> 
> In a very cryptic way that requires manual parsing using non-public
> docs sadly but yes. From the look of it, it's a completion timeout.
> 
> Looks to me like we don't get a response to a config space access
> during the change of D state. I don't know if it's the write of the D3
> state itself or the read back though (it's probably detected on the
> read back or a subsequent read, but that doesn't tell me which specific
> one failed).

If it is just one card doing it (again, check you have latest
firmware) I wonder if it is a sketchy PCI-E electrical link that is
causing a long re-training cycle? Can you tell if the PCI-E link is
permanently gone or does it eventually return?

Does the card work in Gen 3 when it starts? Is there any indication of
PCI-E link errors?

Everytime or sometimes?

POWER 8 firmware is good? If the link does eventually come back, is
the POWER8's D3 resumption timeout long enough?

If this doesn't lead to an obvious conclusion you'll probably need to
connect to IBM's Mellanox support team to get more information from
the card side.

Jason
