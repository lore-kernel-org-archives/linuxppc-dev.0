Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBDEAB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 17:55:51 +1000 (EST)
Subject: Re: halt/reset on assert?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Evan Lavelle <sa212+lppc@cyconix.com>
In-Reply-To: <4D9C6413.8030103@cyconix.com>
References: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
	<m2sju1uoti.fsf@igel.home>  <4D9C6413.8030103@cyconix.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 17:55:33 +1000
Message-ID: <1302162933.2458.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-06 at 14:01 +0100, Evan Lavelle wrote:
> #define MY_ASSERT(expr) if(!(expr)) BUG()

Make it

#define MY_ASSERT(expr) do { if .... } while(0)

To ensure it has proper single statement semantics in C.

Cheers,
Ben.
