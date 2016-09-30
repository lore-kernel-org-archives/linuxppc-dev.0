Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sllyQ2xD6zDrXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 19:10:06 +1000 (AEST)
Date: Fri, 30 Sep 2016 11:10:02 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160930091002.GA1747@krava>
References: <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
 <20160920002820.GE11991@kernel.org> <20160922150022.GA20134@krava>
 <20160922162713.GA31617@krava> <20160926083533.GA15523@krava>
 <20160926150343.GJ5588@kernel.org>
 <20160926165954.GD5871@two.firstfloor.org>
 <20160927141846.GA6589@krava> <20160929221948.GB29214@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160929221948.GB29214@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2016 at 07:19:48PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 27, 2016 at 04:18:46PM +0200, Jiri Olsa escreveu:
> > On Mon, Sep 26, 2016 at 09:59:54AM -0700, Andi Kleen wrote:
> > > On Mon, Sep 26, 2016 at 12:03:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Mon, Sep 26, 2016 at 10:35:33AM +0200, Jiri Olsa escreveu:
> > > > > ping.. is that working for you? IMO we can include this
> > > > > as additional patch to the set..
> > > > 
> > > > No, it doesn't fails to build on the first cross env I tried, fixing it
> > > > now, resulting patch:
> > > 
> > > Yes it shouldn't be difficult to fix cross building. I don't think
> > > there are any fundamental problems.
> > 
> > right, how about attached patch
> > 
> > Arnaldo,
> > could you please try it on cross build.. I still dont have setup for that :-\
> > 
> > thanks,
> > jirka
> 
> So, this makes it work for me in one of the cross build envs I have (all
> in https://hub.docker.com/r/acmel/) if I apply this patch on top:
> 
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 653faee2a055..8332959fbca4 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -42,7 +42,7 @@ $(OUTPUT)fixdep-in.o: FORCE
>  	$(Q)$(MAKE) $(build)=fixdep
>  
>  $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $<
> +	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
>  
>  FORCE:
>  
> -------------------
> 
> I've broken up the patch into multiple ones, to get first fixdep
> working, then to move to jevents, I'm putting this on a
> tmp.perf/hostprog branch till I've tested it all.

looks great, thanks

jirka
