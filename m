Return-Path: <rric.net@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06FF72C0091
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2012 03:50:31 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id ji2so2376727bkc.15
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 08:50:27 -0800 (PST)
Sender: Robert Richter <rric.net@gmail.com>
Date: Tue, 20 Nov 2012 17:50:19 +0100
From: Robert Richter <rric@kernel.org>
To: Stephane Eranian <eranian@google.com>
Subject: Re: perf: POWER-event translation questions
Message-ID: <20121120165019.GP2504@rric.localhost>
References: <20121108011035.GA20670@us.ibm.com>
 <CABPqkBQrUVTY9rfeaO+pdaNwZcAgXF45SHnAYJfTvi4HAsPPeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABPqkBQrUVTY9rfeaO+pdaNwZcAgXF45SHnAYJfTvi4HAsPPeQ@mail.gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Anton Blanchard <anton@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.11.12 11:26:26, Stephane Eranian wrote:
> On Thu, Nov 8, 2012 at 2:10 AM, Sukadev Bhattiprolu
> <sukadev@linux.vnet.ibm.com> wrote:

> > 2. Can we allow hyphens in the {name} token  (please see my change to
> >    util/parse-events.l below). With this change, I can run:
> >
> The current code does not support this but Andi fixed that in his HSW patch
> and I use it for the PEBS-LL patch series as well.
>
> >           perf stat -e cpu/cmplu-stall-bru /tmp/nop
> >
> >    without any changes to the user level tool (parse-events.l) I have
> >    tested some common cases, not sure if it will break something :-)

But ...

> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index c87efc1..1967bb2 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -80,7 +80,7 @@ event         [^,{}/]+
> >  num_dec                [0-9]+
> >  num_hex                0x[a-fA-F0-9]+
> >  num_raw_hex    [a-fA-F0-9]+
> > -name           [a-zA-Z_*?][a-zA-Z0-9_*?]*
> > +name           [-a-zA-Z_*?][-a-zA-Z0-9_*?]*
                     ^

... I wouldn't allow hyphens at the beginning of a name.

And, I am wondering if parsing reserved names like 'cpu-cycles' works
too, e.g. cpu/cpu-cycles-foobar/. There are many reserved words in the
lexer with hyphens in it. This might cause unexpected problems.

-Robert
