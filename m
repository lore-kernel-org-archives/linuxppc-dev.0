Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id A3145DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 04:30:29 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so556368ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 11:30:26 -0700 (PDT)
Message-ID: <fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
Date: Mon, 12 May 2008 12:30:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
In-Reply-To: <20080512173130.0D747181804D@mail89-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 12, 2008 at 11:31 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>  Not easily.  As we discussed before, there is nowhere that really
>  specifies this information.  In some cases I've modified the device tree
>  generator to understand what is backward compatible, as with ns16550,
>  but for other cores it makes more sense to me to put this compatibility
>  information with the driver if it has to be anywhere.

The main concern is that the driver will balloon with data which
impacts the load size for all builds that compile it in.  It also
reduces the impact of minor modifications of the IP cores (ie. the
kernel still works when I've up-revved an ip core from 1.00a to
1.00b.)

I understand that it is hard within the EDK TCL scripts context, but
this is exactly what compatible is designed for and I don't think
continually adding more versions to the list is sustainable in the
long term.  The more I think about it, the more I'm uneasy about this
approach.

For the time being, I'm going to resist merging this change into my
tree, but I'll keep it in my "don't forget about this" list.  It's not
going into .26 anyway, so there is no time pressure.  Later, when
we're closer to the .27 merge window, I'll look at it again, but I
really would prefer to find a way to add to the compatible list.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
