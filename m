Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id E5651DE261
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 06:38:52 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so304017and
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 12:38:51 -0700 (PDT)
Message-ID: <fa686aa40710301238o32d211e6h5c1ffc05abf09b82@mail.gmail.com>
Date: Tue, 30 Oct 2007 13:38:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Subject: Re: RFC: replace device_type with new "class" property?
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2872@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
	<20071030163343.GA4517@loki.buserror.net>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F2872@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/30/07, Yoder Stuart-B08248 <stuart.yoder@freescale.com> wrote:
> Another good reason for device_type-- it helps
> distinguish between two similar classes of devices.
> Both "open-pic" and "isa-pic" look very similar but
> have different encodings of their interrupt cells.
> Without a device_type it may be difficult or impossible
> to distinguish them unless the "name" and
> "compatible" are luckily clear enough.

I don't think you want to go down that path.  If your compatible list
does not uniquely describe what the device is (followed by a list of
devices it is compatible with); then it is not specific enough.  It's
fine for a device driver to go looking at other properties to get more
details; but drivers should primarily bind on the compatible list.

In other words; device_type and/or class are a coarser grained
description of the device than the compatible list.  If you match on
compatible; why would there be any need at all to look at 'name',
'device_type' or the proposed 'class' properties?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
