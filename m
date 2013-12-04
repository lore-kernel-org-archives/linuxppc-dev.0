Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5393C2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 03:47:50 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 4 Dec 2013 16:47:45 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 41DEB219005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 16:47:43 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB4GlUOQ59244750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 16:47:31 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB4GlggU030577
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 09:47:42 -0700
Message-ID: <529F5CAC.1030208@fr.ibm.com>
Date: Wed, 04 Dec 2013 17:47:40 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] offb: make the screen properties endian safe
References: <1383185307.5117.74.camel@pasglop>
 <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
 <1384987801.26969.114.camel@pasglop> <528E2A89.90601@fr.ibm.com>
 <1385063848.4882.6.camel@pasglop> <5290E820.2080809@fr.ibm.com>
 <1385240643.4882.133.camel@pasglop>
In-Reply-To: <1385240643.4882.133.camel@pasglop>
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

On 11/23/2013 10:04 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2013-11-23 at 18:38 +0100, Cedric Le Goater wrote:
>> So, 32bpp "works" but 16 is broken ... I guess my palette fix is just a lucky
>> hack and I need to dig deeper in fb code to have a better understanding of
>> the color map. 
>>
>> I should have provided you two patches in the first place. Do you want the 
>> device tree data fixes for the frame buffer screen properties ? It helps to 
>> have a display for little endian guests even if the colors are wrong.
> 
> Before you pull your hair out, check if it works in BE :-)

I spent some more time on this topic and I have a few more patches to 
send you.

The first patch is straight forward. It fixes host endian order issues 
in the offb code when accessing the OF device tree properties. 

The following patch is more of an attempt to fix the pseudo-palette 
entries on little endian. Hopefully this is the good direction. If not, 
I still have some hair to pull out :)

Cheers,

C.
