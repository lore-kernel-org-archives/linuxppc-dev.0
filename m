Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54E172C010E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2013 05:15:17 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 19 Mar 2013 14:15:14 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 66670C9002A
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:15:07 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2JIF7tT296198
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:15:07 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2JIF6V7010759
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:15:06 -0400
Message-ID: <5148AB26.4060705@linux.vnet.ibm.com>
Date: Tue, 19 Mar 2013 13:15:02 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com> <20130314134212.GA6736@concordia>
In-Reply-To: <20130314134212.GA6736@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2013 08:42 AM, Michael Ellerman wrote:
> On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
>> The firmware_has_feature() function makes it easy to check for supported
>> features of the hardware. There is not corresponding function to check for
>> features supported by the client architecture.
> 
> Actually it doesn't tell you about features of the hardware, it tells
> you about features of the firmware, or the platform ..
> 
> So I think you should really just be adding a new firmware feature flag,
> and adding whatever glue code is required to set it based on what you
> find in the device tree.
> 
> Also notice where you end up using it:
> 
> -       if (firmware_has_feature(FW_FEATURE_OPAL))
> +       if (firmware_has_feature(FW_FEATURE_OPAL) ||
> +           platform_has_feature(OV5_TYPE1_AFFINITY)) {
> +               dbg("Using form 1 affinity\n");
> 		form1_affinity = 1;
> 
> Could be:
> 
> +       if (firmware_has_feature(FW_FEATURE_FORM1_AFFINITY) ||
> 

To make sure I understand what you're suggesting...

You think there should be a single firmware_has_feature() for all current
uses and also for checking items such as FORM1_AFFINITY and PRRN 
features as reported by the device tree for vector 5 portions of the
client architecture bits. I think this could be done by checking the
device tree ibm,architecture-vec-5 node for a specified feature and
setting a bit the appropriate bit in powerpc_firmware_features.

I like this more than separate firmware_has_feature() and platform_has_feature()
routines to check.

-- 
-Nathan
