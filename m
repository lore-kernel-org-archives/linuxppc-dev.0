Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1b9L4dD2zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:23:02 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 81so23999753pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Apr 2017 20:23:02 -0700 (PDT)
Date: Mon, 10 Apr 2017 13:22:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on
 POWER9 guests
Message-ID: <20170410132245.16802599@roar.ozlabs.ibm.com>
In-Reply-To: <1491725015.4166.188.camel@kernel.crashing.org>
References: <20170407125602.31146-1-npiggin@gmail.com>
 <20170407125602.31146-2-npiggin@gmail.com>
 <1491725015.4166.188.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 09 Apr 2017 18:03:35 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2017-04-07 at 22:55 +1000, Nicholas Piggin wrote:
> > POWER9 hypervisors will not necessarily run guest threads together on
> > the same core at the same time, so msgsndp should not be used.  
> 
> Maybe we shouldn't advertise doorbells at all ?

Possibly not. I don't know if there is a good way to switch it off
in the guest from the host with device tree currently. Might be better
to clear it early in the guest rather than test it here though?

Thanks,
Nick
