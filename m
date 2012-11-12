Return-Path: <xenidis@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B63272C0320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 08:33:24 +1100 (EST)
Received: by mail-oa0-f51.google.com with SMTP id n12so6157891oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2012 13:33:21 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: hoo boy, interrupt Handling on BGQ
Date: Mon, 12 Nov 2012 15:33:18 -0600
Message-Id: <9FB7F97D-D988-495B-93C8-746963DFF15C@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Cc: Kumar Gala <kumar.gala@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So interrupts need to go to FW before Linux, please let not talk about =
how silly that is.
Lets talk about something far more silly...
In order to get to the Linux exception handlers, we have to tell FW =
where the interrupt page is, and then it _copies_ it.

IFAICT, this means that each vectors on the "copied" page must:
1) construct an 64-bit absolute address to a per vector stub
2) leap at the (with bctr or blr)
3) restore CTR or LR and anything else that (1) messed up
4) normal branch to the actual vector

This is what I'll be working on, but I'd love to hear any other ideas.
-jx
