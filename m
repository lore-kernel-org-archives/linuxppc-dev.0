Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 78241DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 11:51:48 +1100 (EST)
Message-ID: <493486A3.4040502@consentry.com>
Date: Mon, 01 Dec 2008 16:51:47 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,
 Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(replying to myself again)

I wrote:
> But the key difference is that we see a persistent failure, while the
> erratum only mentions a problem with "the next transaction".

I think the timeout recovery code is not adequate for these CPM errors,
and that is why a transient error becomes a persistent one.  The
function cpm_i2c_force_close in i2c-cpm.c sends a CPM_CR_CLOSE_RX_BD
command, which will abort any receive transaction in progress, but if
it's the transmit phase that got the CPM hung up, there is no code to
abort that (and there does not exist a CP command to do so, as far as
I can tell).

So the I2C disable/enable seems to be an appropriate fix for the
persistent failure part of the problem.  Again, this doesn't explain
how it gets hung up the first time.

					-=] Mike [=-
