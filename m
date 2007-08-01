Return-Path: <dwm@enoyolf.org>
In-reply-to: <18095.56272.4647.158912@cargo.ozlabs.ibm.com> 
References: <31368.1185909681@falcon10.austin.ibm.com>
	<18095.56272.4647.158912@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: ipv6 in yaboot 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2007 21:37:56 -0500
Message-ID: <18071.1185935876@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Nasrat <pnasrat@redhat.com>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 01 Aug 2007 11:03:12 +1000, Paul Mackerras wrote:
> Doug Maxey writes:
> 
> > I just got asked about ipv6 support in yaboot and a quick investigation
> > showed _no_ knowledge of the address formats in the code.
> > 
> > Should I be submitting an RFC for a full parser that can pick that 
> > apart?  Or does has someone have code lurking in the shadows, that 
> > just needed some prompting?  :)
> 
> I would have thought that yaboot would just be passing any network
> addresses in text form to some OF method, so it's up to OF to
> understand ipv6 address formats.  No?

Yes, yaboot _should_ just pass the text representation around.  
However, there are places that the context determination, for 
disklabels, is a simple check for the presence of ':'.  

When I did the original work for building in the tests for determining
if the network device was really an iscsi block device, I may have been
over-concerned that the non-disklabel parts of the IQN, which can and
does have colons, could confuse the parsing.  In the block device path,
there was only a single questionable use.  That usage was fixed by
switching from strchr() to strrchr().

I expect the same syntax issues for the pure network side, as there is
no chance to not take the network path for a pure ipv6 network boot.
In my mind anyway.  Which is always questionable.  ;)

++doug
