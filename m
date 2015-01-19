Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F385A1A0C21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 16:04:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 19 Jan 2015 15:04:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9FD412BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 16:03:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0J53v3846071874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 16:03:58 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0J53vwn007953
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 16:03:57 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] CXL: Use image state defaults for reloading FPGA
In-reply-to: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
Date: Mon, 19 Jan 2015 16:03:56 +1100
Message-Id: <1421643145-sup-9090@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Looks like you forgot your Signed-off-by line - mpe, do you want Ryan to
resend the whole patch (maybe with the below explanation included), or
just reply with a Signed-off-by?

This would also be good to CC: Stable, as these new defaults mean that
the card will be fully reset when sapphire PERSTs them on reboot,
whereas before it was left up to the default value of this register in
each card, and could lead to a card getting into a bad state requiring a
full power cycle to recover. The symptoms we saw was the tlbia / slbia
we do on boot timing out and the driver init aborting.

Cheers,
-Ian
