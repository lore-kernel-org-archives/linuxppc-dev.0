Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FCC4B6EE7
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2012 03:04:59 +1100 (EST)
Received: by wibhr17 with SMTP id hr17so3390927wib.3
 for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2012 09:04:56 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
To: Timur Tabi <timur@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F63A7A4.4000205@freescale.com>
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com>
Date: Mon, 19 Mar 2012 16:04:52 +0000
Message-Id: <20120319160452.B57D13E05A5@localhost>
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Mar 2012 15:50:44 -0500, Timur Tabi <timur@freescale.com> wrote:
> Kumar Gala wrote:
> 
> > This seems like paper taping over the real issue.  We should be able to call of_platform_bus_probe() multiple times.
> 
> I tried debugging it, but I couldn't figure it out.  My guess is that the
> nodes probed by of_platform_bus_probe() are somehow "reserved", so that
> the second time it's called, they're skipped.  I figured that this was
> just a side-effect of the way the OF layer works.

The problem is that you want to create devices for grandchildren
nodes when the bus ids passed in don't match any of the child nodes so
the of_platform_bus_probe() doesn't iterate down to that level.  This
is correct and expected behaviour.

g.
