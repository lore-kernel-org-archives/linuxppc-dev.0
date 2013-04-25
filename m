Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E8C52C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 21:59:04 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 07:59:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 89C18C90048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 07:58:49 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PBwnKL248424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 07:58:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PBwmVl003199
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 08:58:49 -0300
Date: Thu, 25 Apr 2013 19:58:43 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130425115843.GA12358@shangw.(null)>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1366836580.2869.16.camel@pasglop>
 <20130425080836.GA27415@shangw.(null)>
 <20130425081333.GA10637@shangw.(null)>
 <1366879678.2869.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366879678.2869.25.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 06:47:58PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-04-25 at 16:13 +0800, Gavin Shan wrote:
>> It should be "chip_data" (not "irq_data"). Hopefully, you haven't
>> get time to see the reply. Otherwise, it would a bit confused ;-)
>
>Doesn't ics-opal already use chip_data ?
>

Yeah, Ben. that have been used now. So we can't use it for other purposes :-)

>I was thinking just duplicating the irq_chip (including chip_data) so it
>can be used by ics-opal just fine for all calls, just then overriding
>the eoi callback and using container_of to get to the PHB.
>
>Any reason that wouldn't work ?
>

It should work and I had the code (with your idea implemented) and verified
that on simulator. I'll send next version (together with the changes on f/w)
for review after it works correctly on real hardware box.

(I hope it can be done as early as possible to catch 3.10 merge window).

Thanks,
Gavin
