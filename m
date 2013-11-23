Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp15.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07BD62C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2013 04:38:51 +1100 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Sat, 23 Nov 2013 17:38:46 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 689CE17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 17:38:29 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rANHcUEC51183636
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 17:38:30 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rANHcgbx010127
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 10:38:42 -0700
Message-ID: <5290E820.2080809@fr.ibm.com>
Date: Sat, 23 Nov 2013 18:38:40 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] offb: make the screen properties endian safe
References: <1383185307.5117.74.camel@pasglop>
 <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
 <1384987801.26969.114.camel@pasglop> <528E2A89.90601@fr.ibm.com>
 <1385063848.4882.6.camel@pasglop>
In-Reply-To: <1385063848.4882.6.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2013 08:57 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-11-21 at 16:45 +0100, Cedric Le Goater wrote:
>>>  - fbdev *generally* assume native endian framebuffer, but of course
>>> under qemu today, the adapter will use a big endian frame buffer
>>> aperture. You can compile in support for foreign endian but I don't know
>>> how that actually works.
>>
>> OK. I will see how I can extend the tests. But, are you suggesting I should
>> be using the foreign endian framework for the frame buffer ? 
> 
> Well, if it works ... did you try 16 and 32bpp ?

So, 32bpp "works" but 16 is broken ... I guess my palette fix is just a lucky
hack and I need to dig deeper in fb code to have a better understanding of
the color map. 

I should have provided you two patches in the first place. Do you want the 
device tree data fixes for the frame buffer screen properties ? It helps to 
have a display for little endian guests even if the colors are wrong.

Thanks,

C.
