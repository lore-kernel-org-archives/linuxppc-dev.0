Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 6AB97DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 22:54:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so228439wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 05:54:14 -0700 (PDT)
Message-ID: <fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
Date: Wed, 13 Jun 2007 06:54:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 6/6] [C67x00] Merge c67x00-hub.c into c67x00-hcd.c
In-Reply-To: <87645sieew.fsf@p4.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
	<11816893503814-git-send-email-grant.likely@secretlab.ca>
	<11816893511659-git-send-email-grant.likely@secretlab.ca>
	<87645sieew.fsf@p4.be.48ers.dk>
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  Grant> Rather than c67x00-hub.c being compiled seperately, the
>  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
>  Grant> This is a very bad idea.  Simplest solution is to merge the
>  Grant> two files into one and be done with it.
>
> Yeah, it isn't exactly pretty, but it's what the other hcd drivers do,
> E.G.:
>
> % grep -rs "include.*hub.c" *c
> ehci-hcd.c:#include "ehci-hub.c"
> ohci-hcd.c:#include "ohci-hub.c"
> uhci-hcd.c:#include "uhci-hub.c"
>
> I don't quite know why they do it like that though ..

True, but that doesn't mean that it's a good idea to follow the lead.
There are lots of other examples of ugly code in the kernel that is
tolerated just because nobody has cleaned it up yet, but is still
unacceptable for new code.

We know it's an ugly thing to do, and the fix is simple and easy.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
