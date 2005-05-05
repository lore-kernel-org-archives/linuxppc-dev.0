Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id E3E87679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 21:36:59 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j45BfWwW009606
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 5 May 2005 14:41:32 +0300 (EEST)
Message-ID: <427A01B7.9090200@intracom.gr>
Date: Thu, 05 May 2005 14:21:27 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <4278DDBF.8080705@ru.mvista.com>
In-Reply-To: <4278DDBF.8080705@ru.mvista.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice support
 for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> This patch contains actual Ethernet driver on platform bus. Currently 
> tested on MPC8272ADS  (PQII) board.
> 

[snip]

> 

Hi Vitaly

Since I'm also working on this, lets try to merge our work in
one driver.

A few points regarding my driver.

1) It currently supports both 8xx FEC, 82xx FCCs.
2) It will also support SCC ENETS on both 8xx & 82xx, and
    FECs on coldfire's & 52xx's.
3) We should treat the current MII logic as temporary since
    Andy Flemming has a replacement by a MII bus.

Regarding your driver, there are a couple of things it
does arguably better than mine.

1) It has more complete platformization.
2) Adjustuble ring sizes.

And here are some gripes.

1) I'm not a proponent of having drivers configuring pins,
    clocks & other things that are properties of each specific board.
    I'd rather have the bootloader or the platform initialization
    handle it once, and have the driver just use these settings.
    Opinions on this matter differ however :).
2) There are a number of platform defines that are not needed.

Well, what do you think?

Regards

Pantelis
