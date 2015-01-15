Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FB61A0DB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:46:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 14:46:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1CD363578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:46:12 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F4kCMV40960042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:46:12 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F4kBul015315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:46:11 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
In-reply-to: <1421295393-sup-926@delenn.ozlabs.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421295393-sup-926@delenn.ozlabs.ibm.com>
Date: Thu, 15 Jan 2015 15:46:10 +1100
Message-Id: <1421296950-sup-6378@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ian Munsie's message of 2015-01-15 15:41:24 +1100:
> At the moment we don't set it at boot - we just go with whatever the
> card is already set to do. I'm thinking it might be a good idea to
> always set this bit on boot so the only time it's disabled is if a user
> has explicitly gone and disabled it.

While I think of it - if we change this on boot we should also change
reset_image_select to match the currently loaded image. e.g. if
reset_loads_image has defaulted to off and reset_image_select has
defaulted to factory, but the user image has been loaded - that way we
avoid unexpectedly switching to factory if the card gets reset.

Cheers,
-Ian
