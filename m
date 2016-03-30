Return-Path: <mpe@ellerman.id.au>
Message-ID: <1459306502.25307.13.camel@ellerman.id.au>
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jeremy Kerr <jk@ozlabs.org>,
 patchwork@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 13:55:02 +1100
In-Reply-To: <20160329210639.12136fd5@canb.auug.org.au>
References: <20160329175944.33a211cc@kryten> <56FA435A.5010804@ozlabs.org>
 <20160329210639.12136fd5@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 21:06 +1100, Stephen Rothwell wrote:
> Hi Jeremy,
> 
> On Tue, 29 Mar 2016 16:56:58 +0800 Jeremy Kerr <jk@ozlabs.org> wrote:
> > 
> > From the mail that Anton has sent to linuxppc-dev:
> > 
> > > From: Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> > > Reply-To: Anton Blanchard <anton@samba.org>  
> > 
> > Do you know why mailman would be re-writing From: there? It's confusing
> > patchwork, as multiple mails are now coming from that address.
> 
> Yep, Anton posts from samba.org.  They publish a DMARC policy that
> breaks mailing lists.  The best thing we can do is to do the above
> rewrite of the From header.
> 
> The alternative is that all our Yahoo, Gmail and Hotmail subscribers
> (at least) would bounce the email.
> 
> So this rewriting will happen for any From: line that has an address
> that has such a DMARC policy.  We have had posts from Yahoo subscribers
> bounced in the past.

[adding patchwork list to cc]

So it sounds like this is just something we're going to have to live with.

It's causing problems on patchwork because patchwork only uses the email
address to lookup a user. This is causing patches to be misattributed on
ozlabs.org, eg:

  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=68366&state=*

Paul was the first person to have a From header rewritten, eg to:

  From: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

And so in the patchwork database the user "linuxppc-dev@lists.ozlabs.org" has a
name of "Paul Mackerras via Linuxppc-dev".

The subsequent two patches (ppc4xx-rng and perf jit) are from different people,
who also had their From address rewritten due to DMARC.

So I think patchwork needs to:
 - detect mails that have been rewritten due to DMARC
   - AFAICS the only way to do this is to notice that the From address is the
     same as the list address.
 - when it sees those mails, use the Reply-To header instead.

cheers
