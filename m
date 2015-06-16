Return-Path: <rric.net@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EF571A05C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 19:29:03 +1000 (AEST)
Received: by wgez8 with SMTP id z8so7770636wge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 02:28:59 -0700 (PDT)
Sender: Robert Richter <rric.net@gmail.com>
Date: Tue, 16 Jun 2015 11:28:55 +0200
From: Robert Richter <rric@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 ak@linux.intel.com, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 04/14] perf, tools: Allow events with dot
Message-ID: <20150616092855.GB26569@rric.localhost>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150603103204.GI1828@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603103204.GI1828@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.06.15 12:32:04, Jiri Olsa wrote:
> On Tue, Jun 02, 2015 at 10:12:04AM -0700, Sukadev Bhattiprolu wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The Intel events use a dot to separate event name and unit mask.
> > Allow dot in names in the scanner, and remove special handling
> > of dot as EOF. Also remove the hack in jevents to replace dot
> > with underscore. This way dotted events can be specified
> > directly by the user.
> > 
> > I'm not fully sure this change to the scanner is correct
> > (what was the dot special case good for?), but I haven't
> > found anything that breaks with it so far at least.
> 
> can't see anything either
> 
> Robert,
> does it ring a bell? seems like you introduced it ;-)

It is not a dot, it is a regex to handle any other char or <eof> to
return from <event> state to <INITIAL> and rescan the text again.

The change below does not only add the dot for config but also for
names of groups, pmus and tracepoints (might not be complete, see
PE_NAME).

To be sure this is only valid in config syntax, add

 name_config               [a-zA-Z_*?][a-zA-Z0-9_*?.]*

and change name to name_config in <config>.

This should be cleaned up with name_minus by merging both.

I also think we can remove PE_NAME from event_term: at all. We need to
return PE_TERM then instead from <config>.

If you need help with the changes, I could then prepare something and
send it to you, let me know.

-Robert

> 
> thanks,
> jirka
> 
> 
> > 
> > V2: Add the dot to name too, to handle events outside cpu//
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/parse-events.l |    5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 09e738f..13cef3c 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -119,8 +119,8 @@ event		[^,{}/]+
> >  num_dec		[0-9]+
> >  num_hex		0x[a-fA-F0-9]+
> >  num_raw_hex	[a-fA-F0-9]+
> > -name		[a-zA-Z_*?][a-zA-Z0-9_*?]*
> > -name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?]*
> > +name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
> > +name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.]*
> >  /* If you add a modifier you need to update check_modifier() */
> >  modifier_event	[ukhpGHSDI]+
> >  modifier_bp	[rwx]{1,3}
> > @@ -165,7 +165,6 @@ modifier_bp	[rwx]{1,3}
> >  			return PE_EVENT_NAME;
> >  		}
> >  
> > -.		|
> >  <<EOF>>		{
> >  			BEGIN(INITIAL);
> >  			REWIND(0);
> > -- 
> > 1.7.9.5
> > 
