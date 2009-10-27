Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79600B7C06
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 20:16:56 +1100 (EST)
In-Reply-To: <1256601653.2076.51.camel@pasglop>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>	
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<1256597241.2076.38.camel@pasglop>	
	<21C04675-E563-49E2-B2E6-7CAB9D8BE985@embeddedalley.com>
	<1256601653.2076.51.camel@pasglop>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF2108C9F5.3115433C-ONC125765C.003129B4-C125765C.0032EE38@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 27 Oct 2009 10:16:17 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 27/10/2009 01:00:53:
>
> On Mon, 2009-10-26 at 16:26 -0700, Dan Malek wrote:
> > Just be careful the get_user() doesn't regenerate the same
> > translation error you are trying to fix by being here......

yes, I had some problems with this initially but managed to work around that.
I noticed another problem though, I got multiple TLB errors for the same
address when I did it in C. Noticed by just printk:ing every hit
for a dcbX insn in do_page_fault. I can't explain it, but it seems
like when moving to C you have to execute a rfi insn and that might somehow
restart the dcbX insn before moving on to the page fault routine(or something
totally different)

>
> It shouldn't since it will always come up with a proper DAR but
> you may want to double check before hand that your instruction
> address you are loading from is -not- your marker value for bad DAR.

hmm, I check that the insn really is a dcbX insn, but not that the address is
!= 0x00f0. Don't see how it could be as if something is wrong with
the insn address you get ITLB error instead of a DTLB error.

Anyhow, things seems stalled as I haven't heard from Scott or Rex for a while.
If this isn't working now, I really don't know what is wrong and need
some debugging help.

>
> > It is nice doing things in C code, but you have to be aware
> > of the environment and the side effects when in this kind
>
> Yup.
>
> Cheers,
> Ben.
>
>
>
