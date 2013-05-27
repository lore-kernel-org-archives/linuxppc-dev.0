Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
In-reply-to: <51A32F1F.5020109@linux.vnet.ibm.com>
References: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369201667-9048-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1369206855.12874.9.camel@concordia> <519C88D9.30009@linux.vnet.ibm.com>
 <51A32F1F.5020109@linux.vnet.ibm.com>
Date: Tue, 28 May 2013 09:30:10 +1000
Message-ID: <2684.1369697410@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 05/22/2013 02:29 PM, Anshuman Khandual wrote:
> >>
> >> Your description from patch 0 should be here.
> > Does it sound better ?
> > 
> >>
> >>> -	if ((br_privilege != 7) && (br_privilege != 0))
> >>> -		return -1;
> >>> +
> >>> +	if (br_privilege)
> >>> +		pr_info("BHRB privilege state filter request %llx ignored\n",
> >>> +								br_privilege);
> >>
> >> Don't do that. Ignoring the br_privilege is either the right thing to do
> >> in which case we do it and print nothing,
> > 
> > 
> > I thought the informational print would at least make the user aware
> > of the fact that the separate filter request for BHRB went ignored.
> > Can we add this some where in the documentation ?
> 
> So, what we decide here ? We will just ignore any separate BHRB
> privilege state filter request without printing any informational
> event or warning ?

Printing it on the console is pointless.  No one will read it.  

If it's doing the filtering, then just drop the printk.  

	/* BHRB and regular PMU events share the same privilege state
	 * filter configuration. BHRB is always recorded along with a
	 * regular PMU event. As the privilege state filter is handled
	 * in the basic PMC configuration of the accompanying regular
	 * PMU event, we ignore any separate BHRB specific request.
	 */

That updated comment I think make it clear.  

So drop the printk and add the comment, and it's OK with me.

Mikey
