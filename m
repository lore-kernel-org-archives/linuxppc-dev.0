Return-Path: <chris.friesen@genband.com>
Received: from exprod7og109.obsmtp.com (exprod7og109.obsmtp.com [64.18.2.171])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A5ED2C017F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 09:33:32 +1000 (EST)
Message-ID: <516F30A6.5070408@genband.com>
Date: Wed, 17 Apr 2013 17:30:46 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: BUG: branch trace support for 64-bit Book-E (was Re: questions around
 Book III-E and branch trace)
References: <516EED8D.3040304@genband.com>
In-Reply-To: <516EED8D.3040304@genband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2013 12:44 PM, Chris Friesen wrote:
> Hi,
>
> I'm trying to wrap my head around how linux handles branch tracing on
> Book III-E. I think I understand how we set MSR[DE] and DBCR0[IDM|BT],
> and how we handle fixing things up if an instruction being traced causes
> an exception.

While poking around looking for answers to my previous questions I seem 
to have stumbled over a bug in branch tracing for 64-bit Book-E.

Commit ec097c8 added support for branch tracing for 32-bit code, but 
didn't do the 64-bit path.  As it stands, debug_crit/debug_debug in 
exceptions-64e.S only check DBSR_IC, so branch tracing will not get 
fixed up and will die a horrible death (typically in a tbr exception 
handler).

I was banging my head trying to figure out why this wasn't working when 
I finally clued in to the fact that head_booke.h only applied to the 
32-bit implementation.  This might be something useful to put in a 
comment up at the top of the file.

Chris
