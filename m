Return-Path: <christopher.cordahi@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.196])
	by ozlabs.org (Postfix) with ESMTP id 6A986685F1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 10:36:02 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id z8so232900qbc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 17:36:00 -0700 (PDT)
Message-ID: <a1a7967e0510191729x520b2aeak@mail.gmail.com>
Date: Wed, 19 Oct 2005 20:29:45 -0400
From: Christopher Cordahi <christopher.cordahi@gmail.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <4c41159c3c06e288e5d69469f1e3ce7b@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <434BC424.50700@ru.mvista.com> <20051018142411.GA14065@logos.cnet>
	<4c41159c3c06e288e5d69469f1e3ce7b@embeddededge.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: ppc_sys fixes for 8xx and 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 18/10/05, Dan Malek <dan@embeddededge.com> wrote:
>
> On Oct 18, 2005, at 10:24 AM, Marcelo Tosatti wrote:
>
> > For 8xx, I was wondering if the PARTNUM field of the IMMR
> > (section 10.4.1 of MPC860UM.pdf) does have meaningful
> > information which could be used to identify the CPU.
>
> It has meaningful information, but not the way you want
> to use it :-)  The PARTNUM/MASKNUM is only useful
> once you know the type of processor (like 823, 850, 885, etc)
> The PARTNUM is only useful within the "family."  For
> example, the 860 and 880 are two different families, and
> will contain the similar PARTNUM values through their life.
> I believe it's tied to the fabrication process.

I don't understand in what way Marcelo wants to use it, but
from my understanding and a quick look of the Freescale product
summary pages it's the opposite of what you're indicating.
I believe the PARTNUM identifies the family not the part.
You can't tell an 885 from an 870 (IMMR contains 0x09xx).
Similarly you can't tell an 860EN from an 860T (IMMR
contains 0x00xx or 0x05xx).
But you can tell an 860 from an 880 which are in different
families.  Note that it's not always obvious which parts
are in the same family.

> You may as well stop looking for an easy (or possibly
> any) way to differentiate these parts in software, but
> due to they way they are fabricated, I don't think that's
> ever going to happen. :-)
Also just because a feature isn't supposed to be present
doesn't mean it's not.
We bought 860EN (4 SCCs) parts but Motorola accidentily
shipped us 860DE (2 SCCs) parts.  We installed, tested and
shipped a few of these parts using all 4 SCCs without
problem.  It wasn't until another unrelated problem occurred
that we noticed that we had used a tray of the wrong part.

Chris
