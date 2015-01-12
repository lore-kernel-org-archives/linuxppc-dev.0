Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 229531A0569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 11:55:07 +1100 (AEDT)
Date: Mon, 12 Jan 2015 11:55:05 +1100
From: Anton Blanchard <anton@samba.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Message-ID: <20150112115505.15d95434@kryten>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CAC418D@AcuExch.aculab.com>
References: <1420768591-6831-1-git-send-email-anton@samba.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CAC418D@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> The unrolled loop (deleted) looks excessive.
> On a modern cpu with multiple execution units you can usually
> manage to get the loop overhead to execute in parallel to the
> actual 'work'.
> So I suspect that a much simpler 'word at a time' loop will be
> almost as fast - especially in the case where the code isn't
> already in the cache and the compare is relatively short.

I'm always keen to keep things as simple as possible, but your loop is
over 50% slower. Once the loop hits a steady state you are going to run
into front end issues with instruction fetch on POWER8.

Anton

> Try something based on:
> 	a1 = *a++;
> 	b1 = *b++;
> 	while {
> 		a2 = *a++;
> 		b2 = *b++;
> 		if (a1 != a2)
> 			break;
> 		a1 = *a++;
> 		b1 = *b++;
> 	} while (a2 != a1);
> 
> 	David
> 
