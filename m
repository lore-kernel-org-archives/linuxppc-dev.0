Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7E0C2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:24:08 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 20 Aug 2013 14:17:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 63CA72BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:24:05 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7K4NsTs8192276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:23:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7K4O4go005157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:24:05 +1000
Message-ID: <1376972643.25016.109.camel@pasglop>
Subject: Re: BUG_ON and gcc don't mix
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Anton Blanchard <anton@samba.org>
Date: Tue, 20 Aug 2013 14:24:03 +1000
In-Reply-To: <20130820123750.7353f2f1@kryten>
References: <20130820123750.7353f2f1@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, wschmidt@us.ibm.com,
 Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-20 at 12:37 +1000, Anton Blanchard wrote:
>    0:   00 00 23 a1     lhz     r9,0(r3)
>    4:   01 00 60 38     li      r3,1
>    8:   20 00 a9 0c     twlgei  r9,32
>    c:   20 00 80 4e     blr
> 
> Nice! I remember chasing this down before and the issue is we need the
> address of the trap instruction for our bug exception table. Maybe
> we need a gcc builtin in which we can get a label on the trap
> instruction. Would that be possible?

I suppose we can always just do a label before builtin_trap and have
the BUG code search a few instructions :-)

Cheers,
Ben.
