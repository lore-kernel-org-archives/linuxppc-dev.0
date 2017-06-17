Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqMR61SmwzDqLR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 12:59:46 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so2986987pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:59:46 -0700 (PDT)
Date: Sat, 17 Jun 2017 12:59:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/5] watchdog: provide watchdog_reconfigure() for
 arch watchdogs
Message-ID: <20170617125933.774d3858@roar.ozlabs.ibm.com>
In-Reply-To: <20170616112407.e150c215209d86d7e8916a47@linux-foundation.org>
References: <20170616065715.18390-1-npiggin@gmail.com>
 <20170616065715.18390-5-npiggin@gmail.com>
 <20170616112407.e150c215209d86d7e8916a47@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jun 2017 11:24:07 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jun 2017 16:57:14 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > After reconfiguring watchdog sysctls etc., architecture specific
> > watchdogs may not get all their parameters updated.
> > 
> > watchdog_reconfigure() can be implemented to pull the new values
> > in and set the arch NMI watchdog.
> >   
> 
> I'll update the title and changelog to say "watchdog_nmi_reconfigure".

Thanks.


> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -123,6 +123,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
> >  {
> >  }
> >  
> > +void __weak watchdog_nmi_reconfigure(void)
> > +{
> > +}  
> 
> Can we please get some documentation in here describing what it's for? 
> How arch maintainers might use this?  When and why it is called, what
> it must do?  etc.

Good point, how's this?

---
 kernel/watchdog.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 06cd965f64d2..36531025496f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -114,6 +114,10 @@ int __read_mostly watchdog_suspended;
 /*
  * These functions can be overridden if an architecture implements its
  * own hardlockup detector.
+ *
+ * watchdog_nmi_enable/disable can be implemented to start and stop when
+ * softlockup watchdog threads start and stop. The arch must select the
+ * SOFTLOCKUP_DETECTOR Kconfig.
  */
 int __weak watchdog_nmi_enable(unsigned int cpu)
 {
@@ -123,6 +127,17 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 {
 }
 
+/*
+ * watchdog_nmi_reconfigure can be implemented to be notified after any
+ * watchdog configuration change. The arch hardlockup watchdog should
+ * respond to the following variables:
+ * - nmi_watchdog_enabled
+ * - watchdog_thresh
+ * - watchdog_cpumask
+ * - sysctl_hardlockup_all_cpu_backtrace
+ * - hardlockup_panic
+ * - watchdog_suspended
+ */
 void __weak watchdog_nmi_reconfigure(void)
 {
 }
-- 
2.11.0
