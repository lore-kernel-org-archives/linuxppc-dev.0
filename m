Return-Path: <pladow@gmail.com>
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40DD52C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 06:32:02 +1000 (EST)
Received: by mail-la0-f54.google.com with SMTP id ea20so2429444lab.41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Aug 2013 13:31:56 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <520058E0.8080304@ovro.caltech.edu>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
 <CAN8Q1EfWOedMFKtFQbTmmydnLoLe24=c3Fo1Ao3sTdDmuYBJqQ@mail.gmail.com>
 <520058E0.8080304@ovro.caltech.edu>
Date: Thu, 8 Aug 2013 13:31:55 -0700
Message-ID: <CAN8Q1EczGM+aQMPti+QdvUHHbsn=ARV7sKptXc5M7gvEFoDkKQ@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 7:01 PM, David Hawkins <dwh@ovro.caltech.edu> wrote:
> I suspect the lack of either the 5V or 3.3V power rail to the card
> might be the problem.
>
> Did you probe the PCI edge connect to see what supplies were present?

For those that are interested, we did figure out what was going on.
Turns out that the clock buffer driving the PCI connector was, well,
less than adequate.  With some cards, the load on the clock line was
large enough that the clock was in horrible shape.  Fixing the clock
line and the card that failed to be recognized started working.  For
the other cards that worked, the load on the clock line was
significantly less, but the clock was still marginal.

Anyway, turned out to be a hardware issue.  Thanks to all that helped!

Pete
