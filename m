Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240947n72dc331aj18b38a07f9119020@mail.gmail.com>
Date: Wed, 24 Oct 2007 10:47:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F75CD.6080606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<471F6C3F.10003@freescale.com>
	<fa686aa40710240939p408d3e5bj5daae8afcb5ab77f@mail.gmail.com>
	<471F75CD.6080606@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > If you need to scan the tree, don't do it when the driver registers,
> > do it in the platform code instead.  Otherwise you unconditionally
> > incur the penalty of scanning the whole device tree on every system
> > that loads the driver, regardless of whether or not the device is
> > present.
>
> So your saying that the fabric driver should be embedded in the platform driver?

No; that's not what I mean.

But the scanning of the device tree to decide whether or not to
instantiate the driver should be called from platform code.  The
device tree should not be scanned on driver loading.

In other words: populate either a platform_device or an
of_platform_device that the driver can bind against.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
