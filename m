Return-Path: <npiggin@gmail.com>
Date: Tue, 27 Mar 2018 17:38:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/nvram: opal_nvram_write handle unknown
 OPAL errors
Message-ID: <20180327173857.0d195b66@roar.ozlabs.ibm.com>
In-Reply-To: <ad352964-1b12-8556-a876-a10e84336a5e@linux.vnet.ibm.com>
References: <20180326150233.23089-1-npiggin@gmail.com>
 <ad352964-1b12-8556-a876-a10e84336a5e@linux.vnet.ibm.com>
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

On Tue, 27 Mar 2018 12:47:31 +0530
Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:

> On 03/26/2018 08:32 PM, Nicholas Piggin wrote:
> > opal_nvram_write currently just assumes success if it encounters an
> > error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
> > on other errors instead.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/platforms/powernv/opal-nvram.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
> > index 9db4398ded5d..13bf625dc3e8 100644
> > --- a/arch/powerpc/platforms/powernv/opal-nvram.c
> > +++ b/arch/powerpc/platforms/powernv/opal-nvram.c
> > @@ -59,6 +59,8 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
> >   		if (rc == OPAL_BUSY_EVENT)
> >   			opal_poll_events(NULL);  
> 
> Current code does continuous poller here. May be we have small breathing time 
> here. What you say?

Yeah that's probably not a bad idea. I cc'ed skiboot list -- what's a
reasonable delay between retries? Linux has a bunch of similar kind of
loops if you grep for opal_poll_events and OPAL_BUSY. It would be good
to convert them all to a standard form with a standard delay as
recommended by OPAL, and where specific calls have different delay
for a good reason, that would be documented in the OPAL API docs.

Thanks,
Nick
