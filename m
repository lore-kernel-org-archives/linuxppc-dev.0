Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCB7D1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 03:16:02 +1000 (AEST)
Date: Tue, 29 Sep 2015 19:15:56 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf record: Limit --intr-regs to platforms supporting
 PERF_REGS
Message-ID: <20150929171556.GA1856@krava.redhat.com>
References: <1443096718-11926-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150924125703.GA11857@krava.redhat.com>
 <CABPqkBSaxTm6-7x7VpwRtw6aS2qmHup_VsWK0VYFJVwZSMG10w@mail.gmail.com>
 <20150924164554.GA11493@naverao1-tp.in.ibm.com>
 <20150929053617.GA1060@naverao1-tp.in.ibm.com>
 <20150929065335.GE18363@krava.redhat.com>
 <20150929080010.GB1060@naverao1-tp.in.ibm.com>
 <20150929104711.GE27383@krava.redhat.com>
 <20150929163136.GA24723@naverao1-tp.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150929163136.GA24723@naverao1-tp.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2015 at 10:01:36PM +0530, Naveen N. Rao wrote:
> On 2015/09/29 12:47PM, Jiri Olsa wrote:
> > On Tue, Sep 29, 2015 at 01:30:10PM +0530, Naveen N. Rao wrote:
> > 
> > SNIP
> > 
> > > > > Suka has also posted a fix for this with a different approach [1]. Can 
> > > > > you please ack/pull one of these versions? Building perf is broken on 
> > > > > v4.3-rc due to this.
> > > > 
> > > > I did not get any answer for additional comments I made to the patch
> > > > (couldnt get marc.info working, sending the patch again)
> > > 
> > > Hi Jiri,
> > > I concur with the changes you proposed to my patch here (getting rid of 
> > > the weak variant):
> > > http://article.gmane.org/gmane.linux.kernel/2046108
> > > 
> > > I am aware of the other approach you posted (and the one attached 
> > > below). When I said "please ack/pull one of these versions", I meant one 
> > > of: your version, Suka's and mine.
> > 
> > I was hoping somebody could test it on ppc ;-)
> > 
> > I think the last version (in my last email) that keeps the weak
> > variable is correct, let's wait for Arnaldo to sort this out
> 
> I just tried it, but it fails. As Suka points out in his patch:
> "Adding perf_regs.o to util/Build unconditionally, exposes a 
> redefinition error for 'perf_reg_value()' function (due to the static 
> inline version in util/perf_regs.h). So use #ifdef 
> HAVE_PERF_REGS_SUPPORT' around that function."

could you (or Suka) please reply in here with the patch?

thanks,
jirka
