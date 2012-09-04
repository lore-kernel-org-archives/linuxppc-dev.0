Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 652812C0093
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 00:27:23 +1000 (EST)
Message-ID: <1346768840.27919.2.camel@gandalf.local.home>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 04 Sep 2012 10:27:20 -0400
In-Reply-To: <1346741491.7619.12.camel@concordia>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-04 at 16:51 +1000, Michael Ellerman wrote:

> My guess would be we're calling that quite early and the __put_user()
> check is getting confused and failing. That means we'll have left some
> code unpatched, which then fails.
> 
> Can you try with the patch applied, but instead of returning if the
> __put_user() fails, just continue on anyway.
> 
> That will isolate if it's something in the __put_user() (I doubt it), or
> just that the __put_user() is failing and leaving the code unpatched.

As a test case, continuing on error is fine, but I would not recommend
that as a fix. If it fails, but still does the patch, that could be
harmful, and confusing of a result.

Need to figure out why put_user is failing.

-- Steve
