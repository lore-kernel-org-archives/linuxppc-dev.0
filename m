Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59893C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 07:10:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B462171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 07:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B462171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PkdF0pXgzDqMM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 18:10:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iram.es
 (client-ip=130.206.19.142; helo=mx01.puc.rediris.es;
 envelope-from=paubert@iram.es; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iram.es
X-Greylist: delayed 76577 seconds by postgrey-1.36 at bilbo;
 Wed, 26 Dec 2018 18:08:31 AEDT
Received: from mx01.puc.rediris.es (outbound3mad.lav.puc.rediris.es
 [130.206.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Pkb33LvpzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 18:08:29 +1100 (AEDT)
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
 (user=smtp-out_iram mech=LOGIN bits=0)
 by mx01.puc.rediris.es  with ESMTP id wBN8Tvoq004705-wBN8Tvos004705
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 23 Dec 2018 09:29:57 +0100
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id 653E386743;
 Sun, 23 Dec 2018 09:29:56 +0100 (CET)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id CFB9586747;
 Sun, 23 Dec 2018 09:29:55 +0100 (CET)
Received: from lt-gp.iram.es (230.41.223.87.dynamic.jazztel.es [87.223.41.230])
 by sim.rediris.es (Postfix) with ESMTPA id 5407486743;
 Sun, 23 Dec 2018 09:29:54 +0100 (CET)
Date: Sun, 23 Dec 2018 09:29:44 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/4xx/ocm: fix compiler error
Message-ID: <20181223082944.o2qakn6f34megzfj@lt-gp.iram.es>
References: <20181222100934.8051-1-chunkeey@gmail.com>
 <abadbc68-c612-94c3-3248-dc6b55cf6822@c-s.fr>
 <2160350.91F9KbYz58@debian64>
 <06576f55-e31f-2554-255d-d10f8576c7ab@c-s.fr>
 <20181222171631.GA23740@gate.crashing.org>
 <f365c733-6a1d-1ae9-067a-2a9490388c38@c-s.fr>
 <20181222230451.GB23740@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181222230451.GB23740@gate.crashing.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-FEAS-AUTH-USER: smtp-out_iram
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 22, 2018 at 05:04:51PM -0600, Segher Boessenkool wrote:
> On Sat, Dec 22, 2018 at 08:37:28PM +0100, christophe leroy wrote:
> > Le 22/12/2018 à 18:16, Segher Boessenkool a écrit :
> > >On Sat, Dec 22, 2018 at 02:08:02PM +0100, christophe leroy wrote:
> > >>
> > >>Usually, Guarded implies no exec (at least on 6xx and 8xx).
> > >
> > >Huh?  What do you mean here?
> > 
> > From the 885 Reference Manual:
> > 
> > Address translation: the EA is translated by using the MMU’s TLB 
> > mechanism. Instructions are not fetched from no-execute or guarded 
> > memory and data accesses are not executed speculatively to or from the 
> > guarded memory.
> > 
> > 6.1.3.4 Instruction TLB Error Exception (0x01300)
> > This type of exception occurs as a result of one of the following 
> > conditions if MSR[IR] = 1:
> > - The EA cannot be translated.
> > - The fetch access violates memory protection
> > - The fetch access is to guarded memory
> > 
> > 
> > From e300core reference manual:
> > 
> > Translation Exception Conditions:
> > Exception condition: Instruction fetch from guarded memory
> > with MSR[IR] = 1 ==> ISI interrupt SRR1[3] = 1
> 
> Right, but you said 6xx as well, i.e. pure PowerPC.
> 
> If for example IR=0 you cannot have N=1, but you do have G=1.  There is
> no case where G=1 implies N=1 afaik, or where fetch is prohibited some
> other way (causes an ISI, say).

From the 750fx user's manual, similar wording can be found for other
processors (except 601), including the ones that use software TLB load
like 603/603e (the test for guarded memory is in the sample code for
the tlb miss handler):

"
An ISI exception occurs when no higher priority exception exists and an
attempt to fetch the next instruction fails. This exception is implemented 
as it is defined by the PowerPC architecture (OEA), and is taken for the
following conditions:
•   The effective address cannot be translated.
•   The fetch access is to a no-execute segment (SR[N] = 1).
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
•   The fetch access is to guarded storage and MSR[IR] = 1.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
•   The fetch access is to a segment for which SR[T] is set.
•   The fetch access violates memory protection.
When an ISI exception is taken, instruction fetching resumes at offset
0x00400 from the physical base indicated by MSR[IP].
"

	Gabriel
