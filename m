Return-Path: <paulus@ozlabs.org>
Date: Wed, 28 Jul 2010 14:47:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Please pull my perf.git urgent branch
Message-ID: <20100728044731.GA2408@brick.ozlabs.ibm.com>
References: <20100727124019.GB14947@brick.ozlabs.ibm.com>
	<20100727112854.7bf97d48@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100727112854.7bf97d48@schlenkerla.am.freescale.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 27, 2010 at 11:28:54AM -0500, Scott Wood wrote:

> Doesn't the setting of .period need to be maintained (it is in the other
> powerpc perf_event implementation that this is derived from)?

Gah, yes it does.

> I don't see how this is a security fix -- the existing initializer above
> should zero-fill the fields that are not explicitly initialized.  In fact,
> it's taking other fields that were previously initialized to zero and is
> making them uninitialized, since perf_sample_data_init only sets addr and
> raw.

So I misunderstood how an initializer for an automatic struct works.
Brown paper bag time for me... :(

Regarding the other fields, I assume Peter et al. have checked that
they don't need to be cleared, so it's a microoptimization to not
clear them.

> CCing linuxppc-dev on the original patch would have been nice...

True, but at least I can blame Peter Z. for that. :)

Kumar and Ben, how do you want to proceed on this one?

Paul.
