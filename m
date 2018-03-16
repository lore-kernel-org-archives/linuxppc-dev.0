Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402fN56bjkzF0Wy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 19:52:05 +1100 (AEDT)
Date: Fri, 16 Mar 2018 09:52:00 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Cc: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 1/5] rfi-flush: Move the logic to avoid a redo into
 the debugfs code
Message-ID: <20180316095200.78f31a50@naga.suse.cz>
In-Reply-To: <4ae7af3f-219e-33dc-d7fa-49141d268222@linux.vnet.ibm.com>
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1521067243-19520-2-git-send-email-mauricfo@linux.vnet.ibm.com>
 <4ae7af3f-219e-33dc-d7fa-49141d268222@linux.vnet.ibm.com>
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

On Thu, 15 Mar 2018 17:36:00 -0300
Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com> wrote:

> On 03/14/2018 07:40 PM, Mauricio Faria de Oliveira wrote:
> > From: Michael Ellerman <mpe@ellerman.id.au>
> > 
> > rfi_flush_enable() includes a check to see if we're already
> > enabled (or disabled), and in that case does nothing.
> > 
> > But that means calling setup_rfi_flush() a 2nd time doesn't actually
> > work, which is a bit confusing.
> > 
> > Move that check into the debugfs code, where it really belongs.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Mauricio Faria de Oliveira
> > <mauricfo@linux.vnet.ibm.com> ---
> >  arch/powerpc/kernel/setup_64.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/setup_64.c
> > b/arch/powerpc/kernel/setup_64.c index c388cc3..3efc01a 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -846,9 +846,6 @@ static void do_nothing(void *unused)
> > 
> >  void rfi_flush_enable(bool enable)
> >  {
> > -	if (rfi_flush == enable)
> > -		return;
> > -
> >  	if (enable) {
> >  		do_rfi_flush_fixups(enabled_flush_types);
> >  		on_each_cpu(do_nothing, NULL, 1);
> > @@ -902,13 +899,19 @@ void __init setup_rfi_flush(enum
> > l1d_flush_type types, bool enable) #ifdef CONFIG_DEBUG_FS
> >  static int rfi_flush_set(void *data, u64 val)
> >  {
> > +	bool enable;
> > +
> >  	if (val == 1)
> > -		rfi_flush_enable(true);
> > +		enable = true;
> >  	else if (val == 0)
> > -		rfi_flush_enable(false);
> > +		enable = false;
> >  	else
> >  		return -EINVAL;
> > 
> > +	/* Only do anything if we're changing state */
> > +	if (enable != rfi_flush)  
> 
> Hi, Mauricio.
> 
> Do we need to take into account if no_rfi_flush == true?

I think it makes sense you are able to override that using debugfs.

It's interface used for diagnostics and testing.

If this was in sysfs it would be a different story.

Thanks

Michal
