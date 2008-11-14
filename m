Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 3AF89DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:00:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1260418rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 21:00:04 -0800 (PST)
Date: Thu, 13 Nov 2008 22:00:01 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
Message-ID: <20081114050001.GA15181@secretlab.ca>
References: <200811131149.14715.yur@emcraft.com>
	<20081113064533.77eccc1b@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081113064533.77eccc1b@zod.rchland.ibm.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Ilya Yanok <yanok@emcraft.com>,
	Detlev Zundel <dzu@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 06:45:33AM -0500, Josh Boyer wrote:
> On Thu, 13 Nov 2008 11:49:14 +0300
> Yuri Tikhonov <yur@emcraft.com> wrote:
> > +		sysacecf@4fe000000 {
> > +			compatible = "xlnx,opb-sysace-1.00.b";
> 
> Odd.  This isn't a xilinx board by any means.  This should probably
> look something like:
> 
> 	compatible = "amcc,sysace-440spe", "xlnx,opb-sysace-1.00.b";

Actually, if there is a sysace, it is definitely a xilinx part.  It
won't be on the SoC.  However, compatible = "xlnx,opb-sysace-1.00.b"
isn't really accurate.  It should really be compatible = "xlnx,sysace"
and the driver modified to accept this string.  "xlnx,opb-sysace-1.00.b"
is an FPGA block used to interface to the system ace which is
definitely not in use here.

So while it does get things to work, it is not a clean description of
the hardware.

g.
