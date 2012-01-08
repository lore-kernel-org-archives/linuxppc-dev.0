Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 22F65B6F67
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2012 14:55:10 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Sun, 8 Jan 2012 03:48:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q083oaQ13215566
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Jan 2012 14:50:36 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q083sucn002519
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Jan 2012 14:54:56 +1100
Message-ID: <1325994892.5482.10.camel@ThinkPad-T61>
Subject: Re: [PATCH v2 powerpc] fix unpaired __trace_hcall_entry and
 __trace_hcall_exit
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 08 Jan 2012 11:54:52 +0800
In-Reply-To: <1325552057.23910.5.camel@pasglop>
References: <1324260407.3006.17.camel@ThinkPad-T61>
 <1325552057.23910.5.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-03 at 11:54 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-12-19 at 10:06 +0800, Li Zhong wrote:
> > Unpaired calling of __trace_hcall_entry and __trace_hcall_exit could
> > cause incorrect preempt count. And it might happen as the global
> > variable hcall_tracepoint_refcount is checked separately before calling
> > them. 
> > 
> > I don't know much about the powerpc arch. But the idea here is to store
> > the hcall_tracepoint_refcount locally, so __trace_hcall_entry and
> > __trace_hcall_exit will be called or not called in pair by checking the
> > same value. 
> 
> Can you re-use an existing spot in the stack frame rather than adding
> this entry ? There's plenty of unused spots :-) For example the link
> editor doubleword is never going to be used in that function, we could
> hijack it safely. It would make the patch (and the code) simpler.
> 
> Cheers,
> Ben.

Hi Ben, 

Thank you for the suggestion. Below is the updated version, much less
code changes :) Would you please help review again to see whether my
understanding is correct? 

Thanks,
Zhong

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hvCall.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall.S
b/arch/powerpc/platforms/pseries/hvCall.S
index fd05fde..3ce73d0 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -36,6 +36,7 @@ BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
 	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
+	std	r12,32(r1);					\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
@@ -74,7 +75,7 @@ END_FTR_SECTION(0, 1);						\
 BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
-	ld      r12,hcall_tracepoint_refcount@toc(r2);		\
+	ld      r12,32(r1);					\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
-- 
1.7.5.4
