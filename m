Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3D032C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 18:05:01 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 02:04:58 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id F098638C8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:04:24 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P84PR4311028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:04:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P84PZr004764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:04:25 -0400
Date: Tue, 25 Jun 2013 16:04:20 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc/eeh: Check PCIe link after reset
Message-ID: <20130625080420.GA18470@shangw.(null)>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1372140384.3944.189.camel@pasglop>
 <20130625074755.GA8486@shangw.(null)>
 <1372147064.3944.200.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372147064.3944.200.camel@pasglop>
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

On Tue, Jun 25, 2013 at 05:57:44PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-06-25 at 15:47 +0800, Gavin Shan wrote:
>> If we just have complete reset for fenced PHB, we need restore it
>> from the cache (edev->config_space[1]) instead of reading that from
>> hardware. Fenced PHB is the special case on PowerNV :-)
>
>Well not really...
>
>In general we can also end up doing a hard reset under pHyp, and bridges
>can lose their state as well, which means they need to be restored from
>cache.
>
>We don't see the real PHB, but we might see the bridges if we have a PE
>that contains a bridge, for example, a PCIe card with a switch on it.
>
>If we hard reset that (because the driver requested it) or if pHyp did a
>reset due to a fence behind the scene, that bridge *will* have lost its
>state and will need to be reconfigured too... or is RTAS doing it all ?
>

Ok. So that would be job of eeh_ops->configure_bridge(). On pSeries, it
should have done with that.

Thanks,
Gavin
