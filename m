Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id F3FF4DF271
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:30:20 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so143129anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:30:19 -0700 (PDT)
Message-ID: <fa686aa40806050930r12827baod5d742959c982d0c@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:30:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <484812B9.3040300@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de> <4848036D.5060004@freescale.com>
	<484809D1.2070300@scram.de> <48480B3C.9080101@freescale.com>
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
	<484811DE.9@freescale.com> <484812B9.3040300@scram.de>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 10:22 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Timur,
>
>> It's a little late for that.  I'm okay with coming up with a new property to
>> provide system-level indexing, but it needs to be the same property name for
>> each type of device.  I don't want linux,i2c-index and linux,dma-index and
>> linux,ssi-index, etc.  I also don't understand why we need the linux, prefix,
>> since device enumeration is not specific to Linux.
>
> Full ACK here.

NAK because there is already a mechanism that does what you want.  Its
called the aliases node.

For the record, I'm making 2 arguments here:

1) if you *do* need an enumerated index then use the aliases node.
You don't need to invent a new property
2) for i2c purposes, explicit enumeration is not needed or desired.
All the necessary data is already present in the device tree in that
i2c device nodes are children of i2c bus nodes.  The i2c bus numbers
should be dynamically assigned.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
