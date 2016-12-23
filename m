Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlTNt2hGnzDw7g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 00:13:50 +1100 (AEDT)
Date: Fri, 23 Dec 2016 14:13:45 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 11/15] livepatch: use kstrtobool() in
 enabled_store()
In-Reply-To: <20161216221942.mbtyq46kgs4fbraq@treble>
Message-ID: <alpine.LSU.2.20.1612231413070.5990@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <50c4817cbccd6e6cfd0c85c96bf127f84ee79cc8.1481220077.git.jpoimboe@redhat.com>
 <20161216165555.GK393@pathway.suse.cz>
 <20161216221942.mbtyq46kgs4fbraq@treble>
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

On Fri, 16 Dec 2016, Josh Poimboeuf wrote:

> On Fri, Dec 16, 2016 at 05:55:55PM +0100, Petr Mladek wrote:
> > On Thu 2016-12-08 12:08:36, Josh Poimboeuf wrote:
> > > The sysfs enabled value is a boolean, so kstrtobool() is a better fit
> > > for parsing the input string since it does the range checking for us.
> > > 
> > > Suggested-by: Petr Mladek <pmladek@suse.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > ---
> > >  kernel/livepatch/core.c | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > index 6a137e1..8ca8a0e 100644
> > > --- a/kernel/livepatch/core.c
> > > +++ b/kernel/livepatch/core.c
> > > @@ -408,26 +408,23 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  {
> > >  	struct klp_patch *patch;
> > >  	int ret;
> > > -	unsigned long val;
> > > +	bool enabled;
> > >  
> > > -	ret = kstrtoul(buf, 10, &val);
> > > +	ret = kstrtobool(buf, &enabled);
> > >  	if (ret)
> > >  		return -EINVAL;
> > 
> > I would return "ret" here. It is -EINVAL as well but... ;-)
> 
> That was a preexisting issue with the kstrtoul() return code, but I'll
> sneak your suggested change into this patch if nobody objects.

Fine with me.

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
