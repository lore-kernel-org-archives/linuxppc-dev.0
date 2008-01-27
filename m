Return-Path: <nish.aravamudan@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 9C58DDDEA0
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:22:56 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1272046fgg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 12:22:54 -0800 (PST)
Message-ID: <29495f1d0801271222l3f52935fq40df4dcb82e60976@mail.gmail.com>
Date: Sun, 27 Jan 2008 12:22:54 -0800
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: balbir@linux.vnet.ibm.com, "Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
In-Reply-To: <20080127150147.GA10914@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
	<20080126071339.GA25328@balbir.in.ibm.com>
	<18332.28991.658933.763115@cargo.ozlabs.ibm.com>
	<20080127150147.GA10914@balbir.in.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/27/08, Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
> * Paul Mackerras <paulus@samba.org> [2008-01-27 22:55:43]:
>
> > Balbir Singh writes:
> >
> > > Here's a better and more complete fix for the problem. Could you
> > > please see if it works for you? I tested it on a real NUMA box and it
> > > seemed to work fine there.
> >
> > There are a couple of other changes in behaviour that your patch
> > introduces, and I'd like to understand them better before taking the
> > patch.  First, with your patch we don't set nodes online if they end
> > up having no memory in them because of the memory limit, whereas
> > previously we did.  Secondly, in the case where we don't have NUMA
> > information, we now set node 0 online after adding each LMB, whereas
> > previously we only set it online once.
> >
> > If in fact these changes are benign, then your patch description
> > should mention them and explain why they are benign.
> >
>
> Yes, they are. I'll try and justify the changes with a good detailed
> changelog. If people prefer it, I can hide fake NUMA nodes under a
> config option, so that it does not come enabled by default.

Sigh, there already *is* a fake NUMA config option: CONFIG_NUMA_EMU.

"CONFIG_NUMA_EMU:
  Enable NUMA emulation. A flat machine will be split
  into virtual nodes when booted with "numa=fake=N", where N is the
  number of nodes. This is only useful for debugging."

I have to assume your patch is implementing the same feature for
powerpc (really just extending the x86_64 one), and thus should share
the config option.

Any chance you can just make some of that code common? Maybe as a
follow-on patch. I expect that some of Mel's (added to Cc) work to
allow NUMA to be set on x86 more easily will flow quite simply into
adding fake NUMA support there as well. So moving the code to a common
place (at least the parsing) makes sense.

I also feel like you want to be able to online memoryless nodes --
that's where we've been hitting a number of bugs lately in the VM. I
can't tell from Paul's comment if your patch prevents that from being
faked or not.

Thanks,
Nish
