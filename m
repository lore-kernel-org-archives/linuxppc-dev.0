Return-Path: <npiggin@gmail.com>
Date: Mon, 9 Apr 2018 16:13:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [PATCH v2 4/9] powerpc/powernv: OPAL console standardise
 OPAL_BUSY loops
Message-ID: <20180409161342.02f41b8a@roar.ozlabs.ibm.com>
In-Reply-To: <1523253213.11062.7.camel@kernel.crashing.org>
References: <20180409052431.26405-1-npiggin@gmail.com>
 <20180409052431.26405-5-npiggin@gmail.com>
 <1523253213.11062.7.camel@kernel.crashing.org>
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

On Mon, 09 Apr 2018 15:53:33 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-04-09 at 15:24 +1000, Nicholas Piggin wrote:
> > Convert to using the standard delay poll/delay form.
> > 
> > The console code:
> > 
> > - Did not previously delay or sleep in its busy loop.
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Does it help with anything ? We don't technically *have* to delay or
> wait, I thought it would be good to try to hit the console as fast as
> possible in that case...

We can always make exceptions to the standard form, but in those
cases I would like to document it in the OPAL API and comment for
the Linux side.

My thinking in this case is that it reduces time in firmware and
in particular holding console locks. Is it likely / possible that
we don't have enough buffering or some other issue makes it worth
retrying so quickly?

Thanks,
Nick
